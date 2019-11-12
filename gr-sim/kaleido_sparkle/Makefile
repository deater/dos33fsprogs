CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	sparkle kaleido rainbow


###

kaleido:	kaleido.o $(GR_SIM)
	$(CC) -o kaleido kaleido.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

kaleido.o:	kaleido.c
	$(CC) $(CFLAGS) -c kaleido.c

###

sparkle:	sparkle.o $(GR_SIM)
	$(CC) -o sparkle sparkle.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

sparkle.o:	sparkle.c
	$(CC) $(CFLAGS) -c sparkle.c

###

rainbow:	rainbow.o $(GR_SIM)
	$(CC) -o rainbow rainbow.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

rainbow.o:	rainbow.c
	$(CC) $(CFLAGS) -c rainbow.c

####


clean:	
	rm -f *~ *.o kaleido sparkle rainbow
