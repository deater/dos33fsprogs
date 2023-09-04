CC = gcc
CFLAGS = -O2 -Wall
LFLAGS =
MATH_LFLAGS = -lm

all:	sine_dup sine_reverse


###

sine_dup:	sine_dup.o
	$(CC) -o sine_dup sine_dup.o $(LFLAGS) $(MATH_LFLAGS)

sine_dup.o:	sine_dup.c
	$(CC) $(CFLAGS) -c sine_dup.c

###

sine_reverse:	sine_reverse.o
	$(CC) -o sine_reverse sine_reverse.o $(LFLAGS)

sine_reverse.o:	sine_reverse.c
	$(CC) $(CFLAGS) -c sine_reverse.c


###

clean:	
	rm -f *~ *.o sine_dup sine_reverse
