include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
B2D = ../../utils/bmp2dhr/b2d
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	sound.dsk

sound.dsk:	HELLO SOUND TINY
	cp $(EMPTY_DISK) sound.dsk
	$(DOS33) -y sound.dsk SAVE A HELLO
	$(DOS33) -y sound.dsk BSAVE -a 0x1000 SOUND
	$(DOS33) -y sound.dsk BSAVE -a 0x1000 TINY

###

SOUND: sound.o
	ld65 -o SOUND sound.o -C ../../linker_scripts/apple2_1000.inc

sound.o:	sound.s
	ca65 -o sound.o sound.s -l sound.lst

###

TINY: tiny.o
	ld65 -o TINY tiny.o -C ../../linker_scripts/apple2_1000.inc

tiny.o:	tiny.s
	ca65 -o tiny.o tiny.s -l tiny.lst

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO SOUND TINY


