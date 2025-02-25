CC = gcc
CFLAGS = -O2 -Wall -I.. -g

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	starpath_gr starpath_hgr starpath_basic

###

starpath_gr: starpath_gr.o
	$(CC) $(LFLAGS) -o starpath_gr starpath_gr.o $(GR_SIM) $(SDL_LIBS)

starpath_gr.o:	starpath_gr.c
	$(CC) $(CFLAGS) -c starpath_gr.c

###

starpath_basic: starpath_basic.o
	$(CC) $(LFLAGS) -o starpath_basic starpath_basic.o $(GR_SIM) $(SDL_LIBS)

starpath_basic.o:	starpath_basic.c
	$(CC) $(CFLAGS) -c starpath_basic.c


###

starpath_hgr: starpath_hgr.o
	$(CC) $(LFLAGS) -o starpath_hgr starpath_hgr.o $(GR_SIM) $(SDL_LIBS)

starpath_hgr.o:	starpath_hgr.c
	$(CC) $(CFLAGS) -c starpath_hgr.c


###

clean:	
	rm -f *~ *.o starpath_hgr starpath_gr starpath_basic
