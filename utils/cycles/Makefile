include ../../Makefile.inc

all:	calc_freq

####

calc_freq:	calc_freq.o
	$(CC) $(LFLAGS) -o calc_freq calc_freq.o

calc_freq.o:	calc_freq.c
	$(CC) $(CFLAGS) -c calc_freq.c

####

clean:	
	rm -f *~ *.o calc_freq

