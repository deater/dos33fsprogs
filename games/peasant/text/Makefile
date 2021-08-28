CC = gcc
CFLAGS = -O2 -Wall -g

all:	dump_text

###

dump_text:	dump_text.o
	$(CC) -o dump_text dump_text.o $(LFLAGS)

dump_text.o:	dump_text.c
	$(CC) $(CFLAGS) -c dump_text.c

###

clean:	
	rm -f *.o dump_text



