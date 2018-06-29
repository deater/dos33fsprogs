CC = gcc
CFLAGS = -Wall -O2

all:	b2d

b2d:	b2d.o
	$(CC) $(LFLAGS) -o b2d b2d.o

b2d.o:	b2d.c b2d.h
	$(CC) $(CFLAGS) -c b2d.c

clean:	
	rm -f *~ *.o b2d
