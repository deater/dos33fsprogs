CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	lz4d_verbose krw_decode

###

lz4d_verbose:	lz4d_verbose.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o lz4d_verbose lz4d_verbose.o $(GR_SIM)

lz4d_verbose.o:	lz4d_verbose.c demo_title.c
	$(CC) $(CFLAGS) -c lz4d_verbose.c

####

krw_decode:	krw_decode.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o krw_decode krw_decode.o $(GR_SIM)

krw_decode.o:	krw_decode.c demo_title.c
	$(CC) $(CFLAGS) -c krw_decode.c

clean:	
	rm -f *~ *.o gr-sim lz4d_verbose krw_decode
