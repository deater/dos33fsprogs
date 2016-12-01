CC = gcc
CFLAGS = -Wall -O2
LFLAGS =-lpcap

all:	testarp webserver

###

testarp:	testarp.o
	$(CC) $(LFLAGS) -o testarp testarp.o

testarp.o:	testarp.c
	$(CC) $(CFLAGS) -c testarp.c

###

webserver:	webserver.o
	$(CC) $(LFLAGS) -o webserver webserver.o

webserver.o:	webserver.c
	$(CC) $(CFLAGS) -c webserver.c

###

clean:
	rm -f *~ *.o testarp webserver
