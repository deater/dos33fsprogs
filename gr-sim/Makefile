CC = gcc
CFLAGS = -Wall -O2
LFLAGS =

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

all:	rainbow

rainbow:	rainbow.o gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o rainbow rainbow.o gr-sim.o

rainbow.o:	rainbow.c
	$(CC) $(CFLAGS) -c rainbow.c


gr-sim.o:	gr-sim.c
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c gr-sim.c

clean:	
	rm -f *~ *.o gr-sim rainbow


