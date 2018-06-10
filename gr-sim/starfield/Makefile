CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm
AR = ar

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	starfield starfield_fixed




starfield:	starfield.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o starfield starfield.o $(GR_SIM)

starfield.o:	starfield.c
	$(CC) $(CFLAGS) -c starfield.c

starfield_fixed:	starfield_fixed.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o starfield_fixed starfield_fixed.o $(GR_SIM)

starfield_fixed.o:	starfield_fixed.c
	$(CC) $(CFLAGS) -c starfield_fixed.c


clean:	
	rm -f *~ *.o starfield starfield_fixed
