CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	plasma


plasma:	plasma.o $(GR_SIM)
	$(CC) -o plasma plasma.o \
		$(GR_SIM) $(LFLAGS) $(SDL_LIBS)

plasma.o:	plasma.c
	$(CC) $(CFLAGS) -c plasma.c


clean:	
	rm -f *~ *.o plasma
