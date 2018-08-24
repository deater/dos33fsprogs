CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	lines image_load hgr_view

###

hgr_view:	hgr_view.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o hgr_view hgr_view.o $(GR_SIM)

hgr_view.o:	hgr_view.c
	$(CC) $(CFLAGS) -c hgr_view.c

###

image_load:	image_load.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o image_load image_load.o $(GR_SIM)

image_load.o:	image_load.c
	$(CC) $(CFLAGS) -c image_load.c

###

lines:	lines.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o lines lines.o $(GR_SIM)

lines.o:	lines.c
	$(CC) $(CFLAGS) -c lines.c

####


clean:	
	rm -f *~ *.o lines image_load hgr_view
