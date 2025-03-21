CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	dhgr_view unpack4


###

dhgr_view:	dhgr_view.o $(GR_SIM)
	$(CC) -o dhgr_view dhgr_view.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

dhgr_view.o:	dhgr_view.c
	$(CC) $(CFLAGS) -c dhgr_view.c

###

unpack4:	unpack4.o $(GR_SIM)
	$(CC) -o unpack4 unpack4.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

unpack4.o:	unpack4.c
	$(CC) $(CFLAGS) -c unpack4.c


####


clean:	
	rm -f *~ *.o dhgr_view unpack4
