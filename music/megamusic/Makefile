include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_RLE = ../../utils/gr-utils/png2rle

all:	megamusic.dsk

megamusic.dsk:	MEGAMUSIC MEGALOAD HALFMUSIC MUSIC.D000X2 MUSIC.D000 MUSIC.1000
	$(DOS33) -y megamusic.dsk BSAVE -a 0x1000 MUSIC.1000
	$(DOS33) -y megamusic.dsk BSAVE -a 0x4000 MUSIC.D000
	$(DOS33) -y megamusic.dsk BSAVE -a 0x4000 MUSIC.D000X2
	$(DOS33) -y megamusic.dsk BSAVE -a 0x4000 MEGAMUSIC
	$(DOS33) -y megamusic.dsk BSAVE -a 0x4000 HALFMUSIC
	$(DOS33) -y megamusic.dsk BSAVE -a 0x800 MEGALOAD


####

MUSIC.1000:	music_1000.o
	ld65 -o MUSIC.1000 music_1000.o -C ../../linker_scripts/apple2_1000.inc

music_1000.o:	music_1000.s
	ca65 -o music_1000.o music_1000.s -l music_1000.lst

####

MUSIC.D000:	music_d000.o
	ld65 -o MUSIC.D000 music_d000.o -C ../../linker_scripts/apple2_d000.inc

music_d000.o:	music_d000.s
	ca65 -o music_d000.o music_d000.s

####

MUSIC.D000X2:	music_2nd_d000.o
	ld65 -o MUSIC.D000X2 music_2nd_d000.o -C ../../linker_scripts/apple2_d000.inc

music_2nd_d000.o:	music_2nd_d000.s
	ca65 -o music_2nd_d000.o music_2nd_d000.s

####

MEGAMUSIC:	megamusic.o
	ld65 -o MEGAMUSIC megamusic.o -C ../../linker_scripts/apple2_4000.inc

megamusic.o:	megamusic.s \
	play_music.s falling_apple.s
	ca65 -o megamusic.o megamusic.s -l megamusic.lst

####

HALFMUSIC:	halfmusic.o
	ld65 -o HALFMUSIC halfmusic.o -C ../../linker_scripts/apple2_4000.inc

halfmusic.o:	halfmusic.s \
	play_half.s falling_half.s
	ca65 -o halfmusic.o halfmusic.s -l halfmusic.lst


####

MEGALOAD:        megaload.o
	ld65 -o MEGALOAD megaload.o -C ../../linker_scripts/apple2_800.inc

megaload.o:      megaload.s
	ca65 -o megaload.o megaload.s -l megaload.lst

####

clean:
		rm -f *~ *.o *.lst MEGAMUSIC MEGALOAD HALFMUSIC \
			MUSIC.1000 MUSIC.D000 MUSIC.D000X2
