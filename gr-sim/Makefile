CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

all:	gr-sim

gr-sim:	gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o gr-sim gr-sim.o

gr-sim.o:	gr-sim.c
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c gr-sim.c

clean:	
	rm -f *~ *.o gr-sim


