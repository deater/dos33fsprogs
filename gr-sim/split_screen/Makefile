CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	split_screen KATC.BIN

###

split_screen:	split_screen.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o split_screen split_screen.o $(GR_SIM)

split_screen.o:	split_screen.c
	$(CC) $(CFLAGS) -c split_screen.c

####

KATC.BIN:	kat.bmp
	../../bmp2dhr/b2d kat.bmp hgr dither

clean:	
	rm -f *~ *.o split_screen image_load
