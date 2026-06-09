CC = gcc
CFLAGS = -O2 -Wall -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	walking_cube

###

walking_cube: walking_cube.o
	$(CC) $(LFLAGS) -o walking_cube walking_cube.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

walking_cube.o:	walking_cube.c
	$(CC) $(CFLAGS) -c walking_cube.c

###

clean:	
	rm -f *~ *.o walking_cube
