CC = gcc
TGT1 = serial2pipe.c
CFLAGS = -O3 -std=gnu99 -Wall -g
LIBS = -llo
BUILDDIR = .

all:
	@mkdir -p $(BUILDDIR)
	$(CC) $(CFLAGS) $(LIBS) -o $(BUILDDIR)/$(TGT1:.c= ) $(TGT1)

clean:
	rm $(BUILDDIR)/*

# should also make init.d link for this
# and make should update-rc.d
install:
	@mkdir -p $(HOME)/builds/
	@cp -v $(BUILDDIR)/$(TGT1:.c= ) $(HOME)/serial2pipe
