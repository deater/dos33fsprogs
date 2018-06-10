CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	6502_test

###

6502_test:	6502_test.o $(GR_SIM)
	$(CC) $(LFLAGS) -o 6502_test 6502_test.o $(GR_SIM)

6502_test.o:	6502_test.c ../6502_emulate.h
	$(CC) $(CFLAGS) -c 6502_test.c


clean:	
	rm -f *~ *.o 6502_test
