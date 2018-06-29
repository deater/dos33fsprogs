CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	rotate


####
#demo_title.c:	../gr-utils/png2rle ../tfv/demo.png
#	../gr-utils/png2rle c ../tfv/demo.png demo_rle > demo_title.c


####

rotate:	rotate.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o rotate rotate.o $(GR_SIM)

rotate.o:	rotate.c demo_title.c
	$(CC) $(CFLAGS) -c rotate.c

####

clean:	
	rm -f *~ *.o rotate
