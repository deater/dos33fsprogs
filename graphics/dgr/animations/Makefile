CC = gcc
CFLAGS = -O2 -Wall
LFLAGS =

all:	generate_common

###

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

####

clean:	
	rm -f *~ generate_common *.o

