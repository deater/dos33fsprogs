CC = gcc
CFLAGS = -Wall -O2 -g -I..
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

PNG2RLE = ../../gr-utils/png2rle
ARTDIR = ../../tfv/art


all:	tfv

###

$(GR_SIM):	
	cd .. && make

###

$(PNG2RLE):	
	cd ../.. && cd gr-utils && make

####

tfv_backgrounds.c:	$(PNG2RLE) \
			$(ARTDIR)/title.png \
			$(ARTDIR)/map.png \
			$(ARTDIR)/landing.png \
			$(ARTDIR)/harfco.png \
			$(ARTDIR)/belair.png \
			$(ARTDIR)/math_office.png \
			$(ARTDIR)/video_hr.png \
			$(ARTDIR)/collegep.png \
			$(ARTDIR)/umcp.png \
			$(ARTDIR)/dining.png \
			$(ARTDIR)/metro.png \
			$(ARTDIR)/talbot.png
	$(PNG2RLE) c $(ARTDIR)/title.png title_rle > tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/map.png map_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/landing.png landing_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/harfco.png harfco_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/belair.png belair_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/math_office.png math_office_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/video_hr.png video_hr_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/collegep.png collegep_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/umcp.png umcp_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/dining.png dining_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/metro.png metro_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(ARTDIR)/talbot.png talbot_rle >> tfv_backgrounds.c





####

tfv_backgrounds.o:	tfv_backgrounds.c tfv_backgrounds.h
	$(CC) $(CFLAGS) -c tfv_backgrounds.c

tfv_battle.o:	tfv_battle.c
	$(CC) $(CFLAGS) -c tfv_battle.c

#tfv_citymap.o:	tfv_citymap.c
#	$(CC) $(CFLAGS) -c tfv_citymap.c

tfv_flying.o:	tfv_flying.c tfv_flying_fixed.c tfv_flying_float.c tfv_flying_6502.c
	$(CC) $(CFLAGS) -c tfv_flying.c

tfv_info.o:	tfv_info.c
	$(CC) $(CFLAGS) -c tfv_info.c

tfv_opener.o:	tfv_opener.c ../tfv_utils.h
	$(CC) $(CFLAGS) -c tfv_opener.c

tfv_sprites.o:	tfv_sprites.c tfv_sprites.c
	$(CC) $(CFLAGS) -c tfv_sprites.c

tfv_textentry.o:	tfv_textentry.c
	$(CC) $(CFLAGS) -c tfv_textentry.c

tfv_title.o:	tfv_title.c ../tfv_utils.h tfv_backgrounds.h
	$(CC) $(CFLAGS) -c tfv_title.c

tfv_worldmap.o:	tfv_worldmap.c tfv_mapinfo.h
	$(CC) $(CFLAGS) -c tfv_worldmap.c


tfv_multiply.o:	tfv_multiply.c
	$(CC) $(CFLAGS) -c tfv_multiply.c

tfv_multiply:	tfv_multiply.o
	$(CC) $(LFLAGS) -o tfv_multiply tfv_multiply.o


tfv.o:	tfv.c ../gr-sim.h tfv_backgrounds.h tfv_sprites.h
	$(CC) $(CFLAGS) -c tfv.c

tfv:	tfv.o tfv_backgrounds.o tfv_battle.o tfv_flying.o \
		tfv_info.o tfv_opener.o tfv_sprites.o tfv_textentry.o \
		tfv_title.o tfv_worldmap.o tfv_mapinfo.h \
		$(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o tfv tfv.o \
		tfv_backgrounds.o tfv_battle.o tfv_flying.o \
		tfv_info.o tfv_opener.o tfv_sprites.o tfv_textentry.o \
		tfv_title.o tfv_worldmap.o \
		$(GR_SIM)

clean:	
	rm -f *~ *.o tfv



