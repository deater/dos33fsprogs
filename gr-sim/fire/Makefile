CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	fire fire2 fire_blue fire3 fire4


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



fire3:	fire3.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o fire3 fire3.o \
		$(GR_SIM)

fire3.o:	fire3.c
	$(CC) $(CFLAGS) -c fire3.c


fire4:	fire4.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o fire4 fire4.o \
		$(GR_SIM)

fire4.o:	fire4.c
	$(CC) $(CFLAGS) -c fire4.c




fire_blue:	fire_blue.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o fire_blue fire_blue.o \
		$(GR_SIM)

fire_blue.o:	fire_blue.c
	$(CC) $(CFLAGS) -c fire_blue.c

clean:	
	rm -f *~ *.o fire fire2 fire_blue fire3 fire4
