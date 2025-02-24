CC = gcc
CFLAGS = -O2 -Wall -I.. -g

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	starpath_gr

###

starpath_gr: starpath_gr.o
	$(CC) $(LFLAGS) -o starpath_gr starpath_gr.o $(GR_SIM) $(SDL_LIBS)

starpath_gr.o:	starpath_gr.c
	$(CC) $(CFLAGS) -c starpath_gr.c

###

clean:	
	rm -f *~ *.o hellmood_memories starpath_gr hellmood_simple
