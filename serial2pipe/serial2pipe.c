#include <errno.h>
#include <sys/time.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/sysinfo.h>
#include <termios.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <signal.h>
#include <ifaddrs.h>
#include <netinet/in.h> 
#include <string.h> 
#include <arpa/inet.h>

#include "lo/lo.h"

//info: data will not appear on either named pipe unless/until BOTH pipes are 
//connected to a reader (because open() blocks for a reader in write-only mode).
//be sure to start both reader programs!

#ifdef __APPLE__
#define SERIAL_DEVICE_A "/dev/cu.usbmodem1411"
#endif
#ifdef __linux__
#define SERIAL_DEVICE_A "/dev/arduino1"
//#define SERIAL_DEVICE_A "/dev/arduino2"
#endif

#define PIPE_1 "watchdog_pipe1"
#define PIPE_2 "arduino_pipe1"
//#define PIPE_1 "watchdog_pipe2"
//#define PIPE_2 "arduino_pipe2"
#define BAUD B115200
#define WD_RECONNECT_TIME 60 //time in seconds between subsequent TCP reconnect attempts

// globals 
int fda; FILE *fsa;
int pipe1, pipe2;
int num_ffs = 0; //counter to detect if the Arduino serial cable has been yanked out (if so, Arduino floods 0xFF)
int pipe1_connected = 0; //0 if pipe not open, 1 if open
int pipe2_connected = 0; //0 if pipe not open, 1 if open
int watchdog_connected  = 0; //0 if not connected via TCP, 1 if connected
time_t start, end; //timer for ACKCLEAR messages for pipe1
time_t start2, end2; //timer for ACKCLEAR messages for pipe2
time_t start3, end3; //timer to keep "can't open" messages from overflow
time_t start4, end4; //timer to keep disconnected watchdog server from blocking/delaying
//stuff for TCP connection
struct hostent *hp; 
int sd = 0;
struct sockaddr_in server;
struct in_addr ipv4addr;

//TCP host details:
#define PORT 6666
//use this to test happy connection
#define HOST "10.42.16.17"
//use this to test broken connection
//#define HOST "192.168.1.17"

/* closes everything upon exit */
static void murder(int ignore) { 
  fclose(fsa); 
  close(fda); 
  if (pipe1)
    close(pipe1);
  if(pipe2)
    close(pipe2);
  if(sd)
    close(sd);
  exit(0);
} 

void get_ip(char *buff) {
  struct ifaddrs * ifAddrStruct = NULL, * ifa = NULL;
  void * tmpAddrPtr = NULL;
  getifaddrs(&ifAddrStruct);
  for (ifa = ifAddrStruct; ifa != NULL; ifa = ifa->ifa_next) {
    if (ifa ->ifa_addr->sa_family == AF_INET) { // check it is IP4
      char mask[INET_ADDRSTRLEN];
      void* mask_ptr = &((struct sockaddr_in*) ifa->ifa_netmask)->sin_addr;
      inet_ntop(AF_INET, mask_ptr, mask, INET_ADDRSTRLEN);
      if (strcmp(mask, "255.0.0.0") != 0) {
        // is a valid IP4 Address
        tmpAddrPtr = &((struct sockaddr_in *) ifa->ifa_addr)->sin_addr;
        char addressBuffer[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, tmpAddrPtr, addressBuffer, INET_ADDRSTRLEN);
	if (strcmp(ifa->ifa_name, "eth0") == 0) {
	  if (ifAddrStruct != NULL) freeifaddrs(ifAddrStruct);
	  sprintf(buff, "%s", addressBuffer);
	  return;
	}
	//        printf("%s IP Address %s\n", ifa->ifa_name, addressBuffer);
      } else if (ifa->ifa_addr->sa_family == AF_INET6) { // check it is IP6
        // is a valid IP6 Address
        // fuck it
      }
    }
  }
  if (ifAddrStruct != NULL) freeifaddrs(ifAddrStruct);
}
void build_error_str(char *dest, char *errcode_str, char* pipename) {
  char buf[64];
  char hostname[1024];       
  char addressBuffer[INET_ADDRSTRLEN];
  struct sysinfo info;
  int mins, hours, days, sec;
  sysinfo(&info);
  sec = info.uptime;
  //  printf("Uptime = %d\n", sec);
  mins = sec/60;
  hours = mins/60;
  days = hours / 24;

  sec=sec-(mins*60);
  mins=mins-(hours*60);
  hours=hours-(days*24); 	
  /*  if (days == 0) {
    sprintf(buf, "%02d:%02d:%02d", hours, mins, sec);
  } else if (days == 1) {
    sprintf(buf,"%d day, %02d:%02d:%02d", days, hours, mins, sec);
    } else {*/
    sprintf(buf, "%d days, %02d:%02d:%02d", days, hours, mins, sec);
    //  }

  gethostname(hostname, 1024);
  get_ip(addressBuffer);
  sprintf(dest, "%s %s/%s %ld %s", errcode_str, addressBuffer, pipename, info.uptime, buf);
  printf("%s\n", dest);
  // format example/test:
  //  char *message = "ERRDUINO_BROKENPIPE 127.0.0.1 1234 x days, 00:01:02";
}

/* Tries to connect (if not connected) every N seconds. If already connected, sends the message */
/* The initial TCP connection blocks pretty badly, so we want to avoid reconnects as much as possible */
void TCPSendMessage(char * message)
{
  if (watchdog_connected == 0) {
    double diff;
    time(&end4);
    diff = difftime(end4,start4);
    //    printf("trying to send/comparing times: %f sec\n", diff);

    if (diff < WD_RECONNECT_TIME) {
      return;
    } else {
      //      printf("thirty seconds passed, try again\n");
      time(&start4);  //restarts timer for "don't block/constantly reconnect" loop
    }

    printf("Now connecting / reconnecting\n");
    sd = socket(AF_INET,SOCK_STREAM,0);
    server.sin_family = AF_INET;
    
    inet_pton(AF_INET, HOST, &ipv4addr);
    hp = gethostbyaddr(&ipv4addr, sizeof ipv4addr, AF_INET);
    if (hp == 0) {
      herror("gethostbyname error:");
      watchdog_connected = 0;
      time(&start4);  //restarts timer for "don't block/constantly reconnect" loop
      sd = 0;
    } else {
      bcopy(hp->h_addr, &(server.sin_addr.s_addr), hp->h_length);
      server.sin_port = htons(PORT);
      
      connect(sd, (struct sockaddr *)&server, sizeof(server));
    }
  } // endif (watchdog_connected == 0) {

  if (sd) {
    int ret = 0;

    ret = send(sd, (char *)message, strlen((char *)message), 0);
    if (ret != -1)
    //    printf("Sent %s\n", message);
      watchdog_connected = 1;
    else {
      perror("send() error:");
      watchdog_connected = 0;
    }
  } else {
    printf("Error, can't connect to %s\n", HOST);
    watchdog_connected = 0;
    time(&start4); //restarts timer for "don't block/constantly reconnect" loop
  }
}

void open_ports() {
  fda = -1;
  time(&start);
  time(&start2);
  time(&start3);
  time(&start4);
  //this loop should allow you to start serial2pipe while the Arduino isn't 
  //connected. Also allows reconnect on serial errors.
  while(fda < 0) {
    // get descriptor for serial port to arduino
    fda = open(SERIAL_DEVICE_A, O_RDONLY | O_NOCTTY );
    if (fda < 0) { 
      double diff;
      time(&end3);
      diff = difftime(end3,start3);
      if (diff > 30) {
	printf("[ERROR] cannot open file %s\n", 
	       SERIAL_DEVICE_A);
	time(&start3);
      }
    }
  }
  
  // get file stream pointer for serial port to arduino
  fsa = fdopen( fda, "r");
  if (fsa < 0) 
    printf("[ERROR] cannot open stream: %s from: %d\n", 
	   SERIAL_DEVICE_A, fda);
  
  // set up options for terminal device
  struct termios toptions;
  tcgetattr(fda, &toptions);
  cfsetispeed(&toptions, BAUD);
  cfsetospeed(&toptions, BAUD);
  /* 8 bits, no parity, no stop bits */
  toptions.c_cflag &= ~PARENB;
  toptions.c_cflag &= ~CSTOPB;
  toptions.c_cflag &= ~CSIZE;
  toptions.c_cflag |= CS8;
  // /* no hardware flow control */
  // toptions.c_cflag &= ~CRTSCTS;
  /* enable receiver, ignore status lines */
  toptions.c_cflag |= CREAD | CLOCAL;
  /* disable input/output flow control, disable restart chars */
  toptions.c_iflag &= ~(IXON | IXOFF | IXANY);
  /* disable canonical input, disable echo,
   *  disable visually erase chars,
   *   disable terminal-generated signals */
  toptions.c_iflag &= ~(ICANON | ECHO | ECHOE | ISIG);
  /* disable output processing */
  toptions.c_oflag &= ~OPOST;
  /* wait for 1 characters to come in before read returns */
  toptions.c_cc[VMIN] = 1;
  /* no minimum time to wait before read returns */
  toptions.c_cc[VTIME] = 0;
  /* commit the options */
  tcsetattr(fda, TCSANOW, &toptions);
  
}

void open_pipes() {
  printf("Started. Please start programs to listen on %s and %s. serial2pipe will now block (i.e. wait forever!) until both reader programs have been started.\n\n", PIPE_1, PIPE_2);
  fflush(stdout);
  //opens named pipes
  pipe1 = open(PIPE_1, O_WRONLY);
  printf("Reader successfully connected to %s\n", PIPE_1);
  pipe2 = open(PIPE_2, O_WRONLY);
  printf("Reader successfully connected to %s\n", PIPE_2);
  
  if (pipe1 == 0) {
    printf("Error! Can't open named pipe %s\n", PIPE_1);
    exit(-1);
  }
  
  if (pipe2 == 0) {
    printf("Error! Can't open named pipe %s\n", PIPE_2);
    exit(-1);
  }
}

int main(void)
{
  char tmp;
  int stat1 = 0, stat2 = 0;
  // install signal handler
  if (signal(SIGINT, murder) == SIG_ERR)
    printf("[FAILED] to install SIGINT handle\n");
  
  //ignore SIGPIPE. Necessary to keep broken pipes from killing the program.
  //this redirects errors to the write() calls below, where they can be handled. 
  signal(SIGPIPE, SIG_IGN); 
  
  open_ports();
  
  open_pipes();
  
  printf("Initialized! Beginning loop...\n");
  
  while(1)  // main loop
    //grabs chars off the arduino serial port, writes to both pipes.
    {
      tmp = getc(fsa);
      
      if (tmp == EOF) {
	printf("SERIAL ERROR\n");
	open_ports();
      }
      
      //for whatever reason, Arduino sends a flood of 0xFFs if you pull the USB cord out,
      //not EOF. So, um, don't send more than 10 consecutive 0xFFs in your data...
      if (tmp == 0xFF) {
        num_ffs++;
      } else
    	num_ffs = 0;
      
      if (num_ffs >= 10) {
	printf("SERIAL ERROR\n");
	open_ports();
      }
      
      if (tmp >=32 && tmp <= 126) //don't print unicode etc as characters! weird stuff printf'd as %c can segfault on linux
	printf("%c",tmp);
      else
	printf("%x",tmp);
      stat1 = write(pipe1, &tmp, 1);
      stat2 = write(pipe2, &tmp, 1);
      
      if (stat1 < 0) {
	//put error reporting to the watchdog here -- we want to know if the pipe breaks 
	char error_str[2000];
	char *error_str2 = (char *)malloc(2000);
	//	printf("pipe1_connected %d\n", pipe1_connected);
	  sprintf(error_str, "Write error on %s:", PIPE_1);
	  perror(error_str);
	  build_error_str(error_str2, "ERRDUINO_BROKENPIPE", PIPE_1);
	  TCPSendMessage(error_str2);
	if (pipe1_connected == 1) {
	  pipe1_connected = 0;
	}
      } else {
	double diff;
	time(&end);
	diff = difftime(end,start);
	//	printf("Seconds since last send %.2lf\n", diff);
	if (diff > 30) {
	  char *error_str2 = (char *)malloc(2000);
	  build_error_str(error_str2, "ERRDUINO_ACKCLEAR", PIPE_1);
	  TCPSendMessage(error_str2);
          pipe1_connected = 1;
	  time(&start);
	}
      }
      
      if (stat2 < 0) {
	//put error reporting to the watchdog here -- we want to know if the pipe breaks 
	char error_str[2000];
	char *error_str2 = (char *)malloc(2000);
	sprintf(error_str, "Write error on %s:", PIPE_2);
	perror(error_str);
	build_error_str(error_str2, "ERRDUINO_BROKENPIPE", PIPE_2);
	TCPSendMessage(error_str2);
	if (pipe2_connected == 1)
	  pipe2_connected = 0;
      } else {
	double diff;
	time(&end2);
	diff = difftime(end2,start2);
	//	printf("Seconds since last send %.2lf\n", diff);
	if (diff > 30) {
	  char *error_str2 = (char *)malloc(2000);
	  build_error_str(error_str2, "ERRDUINO_ACKCLEAR", PIPE_2);
	  TCPSendMessage(error_str2);
          pipe2_connected = 1;
	  time(&start2);
	}
      }
      
    } 
  murder(1); //if we end up here, close the pipes and TCP connection
  return 0;
}
