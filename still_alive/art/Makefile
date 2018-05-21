CC = gcc
CFLAGS = -O2 -Wall

all:	create_lz4_art

create_lz4_art:	create_lz4_art.c
	$(CC) $(CFLAGS) -o create_lz4_art create_lz4_art.c

clean:
	rm -f *.o *~ *.lz4 create_lz4_art
