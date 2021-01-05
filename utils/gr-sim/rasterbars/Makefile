CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	rasterbars rasterbars_fixed


rasterbars:	rasterbars.o $(GR_SIM)
	$(CC) -o rasterbars rasterbars.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

rasterbars.o:	rasterbars.c
	$(CC) $(CFLAGS) -c rasterbars.c

rasterbars_fixed:	rasterbars_fixed.o $(GR_SIM)
	$(CC) -o rasterbars_fixed rasterbars_fixed.o $(GR_SIM) \
		$(LFLAGS) $(SDL_LIBS)

rasterbars_fixed.o:	rasterbars_fixed.c
	$(CC) $(CFLAGS) -c rasterbars_fixed.c


clean:	
	rm -f *~ *.o rasterbars rasterbars_fixed
