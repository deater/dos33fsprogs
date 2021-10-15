CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	plasma plasma_fixed plasma_new

###

plasma:	plasma.o $(GR_SIM)
	$(CC) -o plasma plasma.o \
		$(GR_SIM) $(LFLAGS) $(SDL_LIBS)

plasma.o:	plasma.c
	$(CC) $(CFLAGS) -c plasma.c

###

plasma_new:	plasma_new.o $(GR_SIM)
	$(CC) -o plasma_new plasma_new.o \
		$(GR_SIM) $(LFLAGS) $(SDL_LIBS)

plasma_new.o:	plasma_new.c
	$(CC) $(CFLAGS) -c plasma_new.c


###

plasma_fixed:	plasma_fixed.o $(GR_SIM)
	$(CC) -o plasma_fixed plasma_fixed.o \
		$(GR_SIM) $(LFLAGS) $(SDL_LIBS)

plasma_fixed.o:	plasma_fixed.c
	$(CC) $(CFLAGS) -c plasma_fixed.c

###


clean:	
	rm -f *~ *.o plasma
