CC = gcc
CFLAGS = -Wall -O2 -g -I..
LFLAGS = -lm

SDL_LIBS= `sdl-config --libs`
SDL_INCLUDE= `sdl-config --cflags`
GR_SIM = ../gr-sim.a

PNG2RLE = ../../gr-utils/png2rle
TFVDIR = ../../tfv

all:	tfv

###

$(PNG2RLE):	
	cd ../.. && cd gr-utils && make

####

tfv_backgrounds.c:	$(PNG2RLE) \
			$(TFVDIR)/title.png \
			$(TFVDIR)/map.png \
			$(TFVDIR)/landing.png \
			$(TFVDIR)/harfco.png \
			$(TFVDIR)/belair.png \
			$(TFVDIR)/math_office.png \
			$(TFVDIR)/video_hr.png \
			$(TFVDIR)/collegep.png \
			$(TFVDIR)/umcp.png \
			$(TFVDIR)/dining.png \
			$(TFVDIR)/metro.png \
			$(TFVDIR)/talbot.png
	$(PNG2RLE) c $(TFVDIR)/title.png title_rle > tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/map.png map_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/landing.png landing_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/harfco.png harfco_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/belair.png belair_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/math_office.png math_office_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/video_hr.png video_hr_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/collegep.png collegep_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/umcp.png umcp_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/dining.png dining_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/metro.png metro_rle >> tfv_backgrounds.c
	$(PNG2RLE) c $(TFVDIR)/talbot.png talbot_rle >> tfv_backgrounds.c





####

tfv_backgrounds.o:	tfv_backgrounds.c tfv_backgrounds.h
	$(CC) $(CFLAGS) -c tfv_backgrounds.c

tfv_battle.o:	tfv_battle.c
	$(CC) $(CFLAGS) -c tfv_battle.c

tfv_citymap.o:	tfv_citymap.c
	$(CC) $(CFLAGS) -c tfv_citymap.c

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

tfv_worldmap.o:	tfv_worldmap.c
	$(CC) $(CFLAGS) -c tfv_worldmap.c


tfv_multiply.o:	tfv_multiply.c
	$(CC) $(CFLAGS) -c tfv_multiply.c

tfv_multiply:	tfv_multiply.o
	$(CC) $(LFLAGS) -o tfv_multiply tfv_multiply.o


tfv.o:	tfv.c ../gr-sim.h tfv_backgrounds.h tfv_sprites.h
	$(CC) $(CFLAGS) -c tfv.c

tfv:	tfv.o tfv_backgrounds.o tfv_battle.o tfv_citymap.o tfv_flying.o \
		tfv_info.o tfv_opener.o tfv_sprites.o tfv_textentry.o \
		tfv_title.o tfv_worldmap.o \
		$(GR_SIM)
	$(CC) $(LFLAGS) $(SDL_LIBS) -o tfv tfv.o \
		tfv_backgrounds.o tfv_battle.o tfv_citymap.o tfv_flying.o \
		tfv_info.o tfv_opener.o tfv_sprites.o tfv_textentry.o \
		tfv_title.o tfv_worldmap.o \
		$(GR_SIM)

clean:	
	rm -f *~ *.o tfv



