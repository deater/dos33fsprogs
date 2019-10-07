CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	gr_view

###

gr_view:	gr_view.o $(GR_SIM)
	$(CC) -o gr_view gr_view.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

gr_view.o:	gr_view.c
	$(CC) $(CFLAGS) -c gr_view.c

####


clean:	
	rm -f *~ *.o gr_view
