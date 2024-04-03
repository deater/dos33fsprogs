CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

all:	dump_ck1

dump_ck1:	dump_ck1.o
	$(CC) -o dump_ck1 dump_ck1.o $(LFLAGS)

dump_ck1.o:	dump_ck1.c
	$(CC) $(CFLAGS) -c dump_ck1.c

clean:	
	rm -f *~ *.o dump_ck1

