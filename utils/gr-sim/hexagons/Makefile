CC = gcc
CFLAGS = -O2 -Wall -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	hexagons

###

hexagons: hexagons.o
	$(CC) $(LFLAGS) -o hexagons hexagons.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

hexagons.o:	hexagons.c
	$(CC) $(CFLAGS) -c hexagons.c

###

clean:	
	rm -f *~ *.o hexagons
