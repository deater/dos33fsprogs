CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

all:	ksp

ksp:	ksp.o
	$(CC) $(LFLAGS) -o ksp ksp.o

ksp.o:	ksp.c
	$(CC) $(CFLAGS) -c ksp.c


clean:	
	rm -f *~ *.o ksp

