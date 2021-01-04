CC = gcc
CFLAGS = -Wall -O2 -I.. -g
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

all:	rotate rotate_zoom_in rotate_zoom_out


####
#demo_title.c:	../gr-utils/png2rle ../tfv/demo.png
#	../gr-utils/png2rle c ../tfv/demo.png demo_rle > demo_title.c


####

rotate:	rotate.o $(GR_SIM)
	$(CC) -o rotate rotate.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

rotate.o:	rotate.c demo_title.c
	$(CC) $(CFLAGS) -c rotate.c

####

rotate_zoom_in:	rotate_zoom_in.o $(GR_SIM)
	$(CC) -o rotate_zoom_in rotate_zoom_in.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

rotate_zoom_in.o:	rotate_zoom_in.c demo_title.c
	$(CC) $(CFLAGS) -c rotate_zoom_in.c

####

rotate_zoom_out:	rotate_zoom_out.o $(GR_SIM)
	$(CC) -o rotate_zoom_out rotate_zoom_out.o $(GR_SIM) $(SDL_LIBS) $(LFLAGS)

rotate_zoom_out.o:	rotate_zoom_out.c demo_title.c
	$(CC) $(CFLAGS) -c rotate_zoom_out.c


####

clean:	
	rm -f *~ *.o rotate rotate_zoom_in rotate_zoom_out
