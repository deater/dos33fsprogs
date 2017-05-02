CC = gcc
CFLAGS = -Wall -O2 -g
LFLAGS =

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

all:	rainbow sparkle kaleido

rainbow:	rainbow.o gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o rainbow rainbow.o gr-sim.o

rainbow.o:	rainbow.c
	$(CC) $(CFLAGS) -c rainbow.c


kaleido:	kaleido.o gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o kaleido kaleido.o gr-sim.o

kaleido.o:	kaleido.c
	$(CC) $(CFLAGS) -c kaleido.c


sparkle:	sparkle.o gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o sparkle sparkle.o gr-sim.o

sparkle.o:	sparkle.c
	$(CC) $(CFLAGS) -c sparkle.c


gr-sim.o:	gr-sim.c
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c gr-sim.c

clean:	
	rm -f *~ *.o gr-sim rainbow sparkle kaleido


