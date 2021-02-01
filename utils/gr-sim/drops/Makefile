CC = gcc
CFLAGS = -O2 -Wall -I.. -g

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	drops

drops: drops.o
	$(CC) $(LFLAGS) -o drops drops.o $(GR_SIM) $(SDL_LIBS)

drops.o:	drops.c
	$(CC) $(CFLAGS) -c drops.c

clean:	
	rm -f *~ *.o drops
