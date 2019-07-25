CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	water


####
#demo_title.c:	../gr-utils/png2rle ../tfv/demo.png
#	../gr-utils/png2rle c ../tfv/demo.png demo_rle > demo_title.c


####

water:	water.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o water water.o $(GR_SIM)

water.o:	water.c demo_title.c
	$(CC) $(CFLAGS) -c water.c

####

clean:	
	rm -f *~ *.o water
