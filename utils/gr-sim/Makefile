CC = gcc
CFLAGS = -Wall -O2 -g
LFLAGS = -lm
AR = ar

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

all:	gr-sim.a
	make -C 6502_test
	make -C bubble
	make -C donut
	make -C dos
	make -C dots
	make -C drops
	make -C fade
	make -C fire
#	make -C fluid
	make -C gr
	make -C hellmood_memories
	make -C hgr
	make -C kaleido_sparkle
	make -C lz4
	make -C mode7_demo
	make -C plasma
	make -C rasterbars
	make -C raytrace
	make -C rotate_wipe
	make -C split_screen
	make -C starfield
	make -C text
	make -C tfv
	make -C tunnel
	make -C twister
	make -C water

#### Library

gr_fast_clear.o:	gr_fast_clear.c gr-sim.h
	$(CC) $(CFLAGS) -c gr_fast_clear.c

####

gr-sim.a:	6502_emulate.o tfv_utils.o gr-sim.o gr_fast_clear.o hgr-sim.o
	$(AR) crs gr-sim.a 6502_emulate.o tfv_utils.o gr-sim.o gr_fast_clear.o hgr-sim.o


###

gr-sim.o:	gr-sim.c gr-sim.h apple2_font.h
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c gr-sim.c

6502_emulate.o:	6502_emulate.c 6502_emulate.h
	$(CC) $(CFLAGS) -c 6502_emulate.c

tfv_utils.o:	tfv_utils.c tfv_utils.h
	$(CC) $(CFLAGS) -c tfv_utils.c

hgr-sim.o:	hgr-sim.c gr-sim.h
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c hgr-sim.c


clean:	
	rm -f *~ *.o *.a
	make -C 6502_test clean
	make -C bubble clean
	make -C donut clean
	make -C dos clean
	make -C dots clean
	make -C drops clean
	make -C fade clean
	make -C fire clean
	make -C fluid clean
	make -C gr clean
	make -C hellmood_memories clean
	make -C hgr clean
	make -C kaleido_sparkle clean
	make -C lz4 clean
	make -C mode7_demo clean
	make -C plasma clean
	make -C rasterbars clean
	make -C raytrace clean
	make -C rotate_wipe clean
	make -C split_screen clean
	make -C starfield clean
	make -C text clean
	make -C tfv clean
	make -C tunnel clean
	make -C twister clean
	make -C water clean
