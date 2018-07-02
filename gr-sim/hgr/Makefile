CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	lines


###

lines:	lines.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o lines lines.o $(GR_SIM)

lines.o:	lines.c
	$(CC) $(CFLAGS) -c lines.c

####


clean:	
	rm -f *~ *.o lines
