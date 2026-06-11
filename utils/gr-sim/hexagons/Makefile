CC = gcc
CFLAGS = -O2 -Wall -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	rombs

###

rombs: rombs.o
	$(CC) $(LFLAGS) -o rombs rombs.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

rombs.o:	rombs.c
	$(CC) $(CFLAGS) -c rombs.c

###

clean:	
	rm -f *~ *.o rombs
