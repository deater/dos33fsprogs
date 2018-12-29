CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	fire fire2 fire_blue


fire:	fire.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o fire fire.o \
		$(GR_SIM)

fire.o:	fire.c
	$(CC) $(CFLAGS) -c fire.c


fire2:	fire2.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o fire2 fire2.o \
		$(GR_SIM)

fire2.o:	fire2.c
	$(CC) $(CFLAGS) -c fire2.c


fire_blue:	fire_blue.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o fire_blue fire_blue.o \
		$(GR_SIM)

fire_blue.o:	fire_blue.c
	$(CC) $(CFLAGS) -c fire_blue.c

clean:	
	rm -f *~ *.o fire fire2 fire_blue
