CC = gcc
CFLAGS = -O2 -Wall -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

all:	generate_sines \
	twist_6502

###

generate_sines:	generate_sines.o
	$(CC) -o generate_sines generate_sines.o $(LFLAGS) -lm

generate_sines.o:	generate_sines.c
	$(CC) $(CFLAGS) -c generate_sines.c

###

twist_6502:	twist_6502.o ../gr-sim.a
	$(CC) -o twist_6502 twist_6502.o ../gr-sim.a $(LFLAGS) $(SDL_LIBS)

twist_6502.o:	twist_6502.c
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c twist_6502.c



###

clean:	
	rm -f *~ *.o dots dots_dump dots_play dots_minimal dots_6502 dots_play2
