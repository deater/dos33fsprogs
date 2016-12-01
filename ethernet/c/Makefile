CC = gcc
CFLAGS = -Wall -O2
LFLAGS =-lpcap

all:	testarp

testarp:	testarp.o
	$(CC) $(LFLAGS) -o testarp testarp.o

testarp.o:	testarp.c
	$(CC) $(CFLAGS) -c testarp.c

clean:
	rm -f *~ *.o testarp
