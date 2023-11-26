CC = gcc
CFLAGS = -O2 -Wall -g

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

all:	dots dots_dump dots_play dots_minimal

###

dots_play:	dots_play.o vga_emulator.o 8086_emulator.o ../gr-sim.a
	$(CC) -o dots_play dots_play.o vga_emulator.o 8086_emulator.o ../gr-sim.a $(LFLAGS) $(SDL_LIBS)

dots_play.o:	dots_play.c vga_emulator.h
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c dots_play.c

###

dots_dump:	dots_dump.o vga_emulator.o 8086_emulator.o ../gr-sim.a
	$(CC) -o dots_dump dots_dump.o vga_emulator.o 8086_emulator.o ../gr-sim.a $(LFLAGS) $(SDL_LIBS)

dots_dump.o:	dots_dump.c vga_emulator.h
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c dots_dump.c

###

dots:	dots.o vga_emulator.o 8086_emulator.o ../gr-sim.a
	$(CC) -o dots dots.o vga_emulator.o 8086_emulator.o ../gr-sim.a $(LFLAGS) $(SDL_LIBS)

dots.o:	dots.c vga_emulator.h
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c dots.c

###

dots_minimal:	dots_minimal.o ../gr-sim.a
	$(CC) -o dots_minimal dots_minimal.o ../gr-sim.a $(LFLAGS) $(SDL_LIBS)

dots_minimal.o:	dots_minimal.c
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c dots_minimal.c


###

8086_emulator.o:	8086_emulator.c 8086_emulator.h
	$(CC) $(CFLAGS) -c 8086_emulator.c

###

vga_emulator.o:	vga_emulator.c vga_emulator.h
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c vga_emulator.c

###

clean:	
	rm -f *~ *.o dots dots_dump dots_play dots_minimal
