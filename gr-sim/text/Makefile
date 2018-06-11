CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	text


####

text:	text.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o text text.o $(GR_SIM)

text.o:	text.c
	$(CC) $(CFLAGS) -c text.c

clean:	
	rm -f *~ *.o text
