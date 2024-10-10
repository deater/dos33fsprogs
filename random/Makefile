CC = gcc
CFLAGS = -O2 -Wall
LFLAGS =

all:	random16 random8 random24

###

random24:	random24.o
	$(CC) $(LFLAGS) -o random24 random24.o

random24.o:	random24.c
	$(CC) $(CFLAGS) -c random24.c

###

random16:	random16.o
	$(CC) $(LFLAGS) -o random16 random16.o

random16.o:	random16.c
	$(CC) $(CFLAGS) -c random16.c

###

random8:	random8.o
	$(CC) $(LFLAGS) -o random8 random8.o

random8.o:	random8.c
	$(CC) $(CFLAGS) -c random8.c

###

clean:
	rm -f *~ *.o random16 random8 random24
