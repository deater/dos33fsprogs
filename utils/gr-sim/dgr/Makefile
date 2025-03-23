CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	dgr_view


###

dgr_view:	dgr_view.o $(GR_SIM)
	$(CC) -o dgr_view dgr_view.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

dgr_view.o:	dgr_view.c
	$(CC) $(CFLAGS) -c dgr_view.c

###


clean:	
	rm -f *~ *.o dgr_view
