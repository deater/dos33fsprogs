CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	nibble

####

nibble:	nibble.o $(GR_SIM)
	$(CC) -o nibble nibble.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

nibble.o:	nibble.c
	$(CC) $(CFLAGS) -c nibble.c

####

nibble2:	nibble2.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o nibble2 nibble2.o $(GR_SIM)

nibble2.o:	nibble2.c
	$(CC) $(CFLAGS) -c nibble2.c


####

clean:	
	rm -f *~ *.o nibble nibble2
