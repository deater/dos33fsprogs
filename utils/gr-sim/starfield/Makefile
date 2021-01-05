CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm
AR = ar

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	starfield starfield_fixed




starfield:	starfield.o $(GR_SIM)
	$(CC) -o starfield starfield.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

starfield.o:	starfield.c
	$(CC) $(CFLAGS) -c starfield.c

starfield_fixed:	starfield_fixed.o $(GR_SIM)
	$(CC) -o starfield_fixed starfield_fixed.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

starfield_fixed.o:	starfield_fixed.c
	$(CC) $(CFLAGS) -c starfield_fixed.c


clean:	
	rm -f *~ *.o starfield starfield_fixed
