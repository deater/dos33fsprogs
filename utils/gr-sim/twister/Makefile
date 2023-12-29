CC = gcc
CFLAGS = -O2 -Wall -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

all:	generate_sines \
	twist_6502 twist_dump

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

twist_dump:	twist_dump.o ../gr-sim.a
	$(CC) -o twist_dump twist_dump.o ../gr-sim.a $(LFLAGS) $(SDL_LIBS)

twist_dump.o:	twist_dump.c
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c twist_dump.c



###

clean:	
	rm -f *~ *.o twist_6502 twist_dump generate_sines
