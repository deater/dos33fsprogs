CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	donut

####

donut:	donut.o $(GR_SIM)
	$(CC) -o donut donut.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

donut.o:	donut.c
	$(CC) $(CFLAGS) -c donut.c

####

clean:	
	rm -f *~ *.o donut
