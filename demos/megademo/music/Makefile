CC = gcc
CFLAGS = -g -O2 -Wall

decode_pt3:	decode_pt3.o
	$(CC) $(LFLAGS) -o decode_pt3 decode_pt3.o

decode_pt3.o:	decode_pt3.c
	$(CC) $(CFLAGS) -c decode_pt3.c

clean:
	rm -f *.o *~ decode_pt3
