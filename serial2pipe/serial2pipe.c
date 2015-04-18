#include <termios.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <signal.h>

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

// global for when we need to close
int fda; FILE *fsa;
int pipe1, pipe2;
static void murder(int ignore) { 
  fclose(fsa); 
  close(fda); 
  if (pipe1)
    close(pipe1);
  if(pipe2)
    close(pipe2);
  exit(0);
} 

void open_ports() {
  fda = -1;
  //this loop should allow you to start serial2pipe while the Arduino isn't 
  //connected. Also allows reconnect on serial errors.
  while(fda < 0) {
    // get descriptor for serial port to arduino
    fda = open(SERIAL_DEVICE_A, O_RDONLY | O_NOCTTY );
    if (fda < 0) 
      printf("[ERROR] cannot open file %s\n", 
	     SERIAL_DEVICE_A);
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

  // install signal handler
  if (signal(SIGINT, murder) == SIG_ERR)
    printf("[FAILED] to install SIGINT handle\n");

  //ignore SIGPIPE. Necessary to keep broken pipes from killing the program
  signal(SIGPIPE, SIG_IGN); 

  open_ports();

  open_pipes();

   printf("Initialized! Beginning loop...\n");

  while(1)  // our loop
    //grabs chars off the arduino serial port, writes to both pipes.
  {
    tmp = getc(fsa);

    if (tmp == EOF) {
      printf("SERIAL ERROR\n");
      open_ports();
    }

    //for whatever reason, Arduino sends a flood of 0xFFs if you pull the USB cord out,
    //not EOF. So, um, don't send more than 5 consecutive 0xFFs in your data...
    if (tmp == 0xFF) {
      tmp = getc(fsa);
      if (tmp == 0xFF) {
	 tmp = getc(fsa);
	if (tmp == 0xFF) {
	   tmp = getc(fsa);
	   if (tmp == 0xFF) {
	     tmp = getc(fsa);
	     if (tmp == 0xFF) {
  
	       printf("SERIAL ERROR\n");
	       open_ports();
	     }
	   }
	}
    }
    }

    if (tmp >=32 && tmp <= 126) //don't print unicode etc as characters!
      printf("%c\n",tmp);
    else
      printf("%x\n",tmp);
    write(pipe1, &tmp, 1);
    write(pipe2, &tmp, 1);
  } 
  murder(1); //if we end up here, close the pipes
  return 0;
}
