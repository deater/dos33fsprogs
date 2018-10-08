include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
B2D = ../bmp2dhr/b2d

all:	space_bars.dsk

space_bars.dsk:	SPACE_BARS
	$(DOS33) -y space_bars.dsk BSAVE -a 0x4000 SPACE_BARS


####

SPACE_BARS:	space_bars.o
	ld65 -o SPACE_BARS space_bars.o -C ../linker_scripts/apple2_4000.inc

space_bars.o:	space_bars.s instructions.s game.s \
	game_over.s gr_copy.s text_print.s title.s \
	spacebars_title.inc screen_split.s \
	vapor_lock.s delay_a.s lz4_decode.s SB_BACKGROUNDC.BIN.lz4
	ca65 -o space_bars.o space_bars.s -l space_bars.lst

####

spacebars_title.inc:	./images/spacebars_title_scaled.png
	$(PNG_TO_40x48D) asm ./images/spacebars_title_scaled.png spacebars_title > spacebars_title.inc

####

SB_BACKGROUNDC.BIN.lz4:	SB_BACKGROUNDC.BIN
	lz4 -f -16 SB_BACKGROUNDC.BIN

SB_BACKGROUNDC.BIN:	sb_background.bmp
	$(B2D) sb_background.bmp HGR -d

###

clean:		
		rm -f *~ *.o *.lst SPACE_BARS


