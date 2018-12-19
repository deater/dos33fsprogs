CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	fireworks fw_purple lines image_load hgr_view seven random16 scroll scroll-asm

###

hgr_view:	hgr_view.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o hgr_view hgr_view.o $(GR_SIM)

hgr_view.o:	hgr_view.c
	$(CC) $(CFLAGS) -c hgr_view.c

###

image_load:	image_load.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o image_load image_load.o $(GR_SIM)

image_load.o:	image_load.c
	$(CC) $(CFLAGS) -c image_load.c

###

lines:	lines.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o lines lines.o $(GR_SIM)

lines.o:	lines.c
	$(CC) $(CFLAGS) -c lines.c

###

fireworks:	fireworks.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o fireworks fireworks.o $(GR_SIM)

fireworks.o:	fireworks.c
	$(CC) $(CFLAGS) -c fireworks.c

###

fw_purple:	fw_purple.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o fw_purple fw_purple.o $(GR_SIM)

fw_purple.o:	fw_purple.c
	$(CC) $(CFLAGS) -c fw_purple.c
###

seven:	seven.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o seven seven.o $(GR_SIM)

seven.o:	seven.c
	$(CC) $(CFLAGS) -c seven.c

###

random16:	random16.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o random16 random16.o $(GR_SIM)

random16.o:	random16.c
	$(CC) $(CFLAGS) -c random16.c

####

scroll:	scroll.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o scroll scroll.o $(GR_SIM)

scroll.o:	scroll.c
	$(CC) $(CFLAGS) -c scroll.c

####

scroll-asm:	scroll-asm.o $(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o scroll-asm scroll-asm.o $(GR_SIM)

scroll-asm.o:	scroll-asm.c
	$(CC) $(CFLAGS) -c scroll-asm.c

####


clean:	
	rm -f *~ *.o fireworks lines image_load hgr_view fw_purple seven random16 scroll scroll-asm
