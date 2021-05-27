CC = gcc
CFLAGS = -O2 -Wall -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	raytrace

raytrace: raytrace.o
	$(CC) -o raytrace raytrace.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

raytrace.o:	raytrace.c
	$(CC) $(CFLAGS) -c raytrace.c

clean:	
	rm -f *~ *.o raytrace
