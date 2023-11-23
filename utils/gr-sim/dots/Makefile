CC = gcc
CFLAGS = -O2 -Wall -g

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

all:	dots

###

dots:	dots.o vga_emulator.o 8086_emulator.o ../gr-sim.a
	$(CC) -o dots dots.o vga_emulator.o 8086_emulator.o ../gr-sim.a $(LFLAGS) $(SDL_LIBS)

dots.o:	dots.c vga_emulator.h
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c dots.c

###

8086_emulator.o:	8086_emulator.c 8086_emulator.h
	$(CC) $(CFLAGS) -c 8086_emulator.c

###

vga_emulator.o:	vga_emulator.c vga_emulator.h
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c vga_emulator.c

###

clean:	
	rm -f *~ *.o dots hellmood_memories
