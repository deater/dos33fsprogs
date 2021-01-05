CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	tunnel tunnel2

####

tunnel:	tunnel.o $(GR_SIM)
	$(CC) -o tunnel tunnel.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

tunnel.o:	tunnel.c
	$(CC) $(CFLAGS) -c tunnel.c

####

tunnel2:	tunnel2.o $(GR_SIM)
	$(CC) -o tunnel2 tunnel2.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

tunnel2.o:	tunnel2.c
	$(CC) $(CFLAGS) -c tunnel2.c


####

clean:	
	rm -f *~ *.o tunnel tunnel2
