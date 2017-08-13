CC = gcc
CFLAGS = -Wall -O2 -g
LFLAGS =

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`

all:	rainbow sparkle kaleido tfv text



####

rainbow:	rainbow.o gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o rainbow rainbow.o gr-sim.o

rainbow.o:	rainbow.c
	$(CC) $(CFLAGS) -c rainbow.c

####

text:	text.o gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o text text.o gr-sim.o

text.o:	text.c
	$(CC) $(CFLAGS) -c text.c


####

tfv_backgrounds.o:	tfv_backgrounds.c tfv_backgrounds.h
	$(CC) $(CFLAGS) -c tfv_backgrounds.c

tfv_battle.o:	tfv_battle.c
	$(CC) $(CFLAGS) -c tfv_battle.c

tfv_flying.o:	tfv_flying.c
	$(CC) $(CFLAGS) -c tfv_flying.c

tfv_info.o:	tfv_info.c
	$(CC) $(CFLAGS) -c tfv_info.c

tfv_opener.o:	tfv_opener.c tfv_utils.h
	$(CC) $(CFLAGS) -c tfv_opener.c

tfv_sprites.o:	tfv_sprites.c tfv_sprites.c
	$(CC) $(CFLAGS) -c tfv_sprites.c

tfv_title.o:	tfv_title.c tfv_utils.h tfv_backgrounds.h
	$(CC) $(CFLAGS) -c tfv_title.c

tfv_utils.o:	tfv_utils.c tfv_utils.h
	$(CC) $(CFLAGS) -c tfv_utils.c

tfv.o:	tfv.c gr-sim.h tfv_backgrounds.h tfv_sprites.h
	$(CC) $(CFLAGS) -c tfv.c

tfv:	tfv.o tfv_backgrounds.o tfv_battle.o tfv_flying.o tfv_info.o tfv_opener.o tfv_sprites.o tfv_title.o tfv_utils.o gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o tfv tfv.o tfv_backgrounds.o tfv_battle.o tfv_flying.o tfv_info.o tfv_opener.o tfv_sprites.o tfv_title.o tfv_utils.o gr-sim.o

###

kaleido:	kaleido.o gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o kaleido kaleido.o gr-sim.o

kaleido.o:	kaleido.c
	$(CC) $(CFLAGS) -c kaleido.c


sparkle:	sparkle.o gr-sim.o
	$(CC) $(LFLAGS) $(SDL_LIBS) -o sparkle sparkle.o gr-sim.o

sparkle.o:	sparkle.c
	$(CC) $(CFLAGS) -c sparkle.c


gr-sim.o:	gr-sim.c gr-sim.h apple2_font.h
	$(CC) $(CFLAGS) $(SDL_INCLUDE) -c gr-sim.c

clean:	
	rm -f *~ *.o gr-sim rainbow sparkle kaleido tfv text


