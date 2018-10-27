include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_RLE = ../gr-utils/png2rle

all:	megamusic.dsk

megamusic.dsk:	MEGAMUSIC MEGALOAD
	$(DOS33) -y megamusic.dsk BSAVE -a 0x4000 MEGAMUSIC
	$(DOS33) -y megamusic.dsk BSAVE -a 0x800 MEGALOAD

####

MEGAMUSIC:	megamusic.o
	ld65 -o MEGAMUSIC megamusic.o -C ../linker_scripts/apple2_4000.inc

megamusic.o:	megamusic.s \
	play_music.s falling_apple.s
	ca65 -o megamusic.o megamusic.s -l megamusic.lst


####

MEGALOAD:        megaload.o
	ld65 -o MEGALOAD megaload.o -C ../linker_scripts/apple2_800.inc

megaload.o:      megaload.s
	ca65 -o megaload.o megaload.s -l megaload.lst

####

clean:
		rm -f *~ *.o *.lst MEGAMUSIC MEGALOAD
