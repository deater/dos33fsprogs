CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	fireworks fw_purple lines image_load hgr_view seven \
	random16 scroll scroll-asm plasma_new plasma_test plasma_test64

###

hgr_view:	hgr_view.o $(GR_SIM)
	$(CC) -o hgr_view hgr_view.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)
hgr_view.o:	hgr_view.c

	$(CC) $(CFLAGS) -c hgr_view.c

###

image_load:	image_load.o $(GR_SIM)
	$(CC) -o image_load image_load.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

image_load.o:	image_load.c
	$(CC) $(CFLAGS) -c image_load.c

###

lines:	lines.o $(GR_SIM)
	$(CC) -o lines lines.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

lines.o:	lines.c
	$(CC) $(CFLAGS) -c lines.c

###

fireworks:	fireworks.o $(GR_SIM)
	$(CC) -o fireworks fireworks.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

fireworks.o:	fireworks.c
	$(CC) $(CFLAGS) -c fireworks.c

###

plasma_new:	plasma_new.o $(GR_SIM)
	$(CC) -o plasma_new plasma_new.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

plasma_new.o:	plasma_new.c
	$(CC) $(CFLAGS) -c plasma_new.c

###

plasma_test64:	plasma_test64.o $(GR_SIM)
	$(CC) -o plasma_test64 plasma_test64.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

plasma_test64.o:	plasma_test64.c
	$(CC) $(CFLAGS) -c plasma_test64.c

###

plasma_test:	plasma_test.o $(GR_SIM)
	$(CC) -o plasma_test plasma_test.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

plasma_test.o:	plasma_test.c
	$(CC) $(CFLAGS) -c plasma_test.c


###

fw_purple:	fw_purple.o $(GR_SIM)
	$(CC) -o fw_purple fw_purple.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

fw_purple.o:	fw_purple.c
	$(CC) $(CFLAGS) -c fw_purple.c
###

seven:	seven.o $(GR_SIM)
	$(CC) -o seven seven.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

seven.o:	seven.c
	$(CC) $(CFLAGS) -c seven.c

###

random16:	random16.o $(GR_SIM)
	$(CC) -o random16 random16.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

random16.o:	random16.c
	$(CC) $(CFLAGS) -c random16.c

####

scroll:	scroll.o $(GR_SIM)
	$(CC) -o scroll scroll.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

scroll.o:	scroll.c
	$(CC) $(CFLAGS) -c scroll.c

####

scroll-asm:	scroll-asm.o $(GR_SIM)
	$(CC) -o scroll-asm scroll-asm.o $(GR_SIM) $(LFLAGS) $(SDL_LIBS)

scroll-asm.o:	scroll-asm.c
	$(CC) $(CFLAGS) -c scroll-asm.c

####


clean:	
	rm -f *~ *.o fireworks lines image_load hgr_view fw_purple seven \
		random16 scroll scroll-asm plasma_text plasma_text64
