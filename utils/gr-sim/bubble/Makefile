CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	bubble bubble_orig

####

bubble:	bubble.o $(GR_SIM)
	$(CC) -o bubble bubble.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

bubble.o:	bubble.c
	$(CC) $(CFLAGS) -c bubble.c

####

bubble_orig:	bubble_orig.o $(GR_SIM)
	$(CC) -o bubble_orig bubble_orig.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

bubble_orig.o:	bubble_orig.c
	$(CC) $(CFLAGS) -c bubble_orig.c


####

clean:	
	rm -f *~ *.o bubble bubble_orig
