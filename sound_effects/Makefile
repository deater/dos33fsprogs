include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	sound.dsk

sound.dsk:	HELLO SOUND
	cp empty.dsk sound.dsk
	$(DOS33) -y sound.dsk SAVE A HELLO
	$(DOS33) -y sound.dsk BSAVE -a 0x1000 SOUND

SOUND: sound.o
	ld65 -o SOUND sound.o -C ../linker_scripts/apple2_1000.inc

sound.o:	sound.s
	ca65 -o sound.o sound.s -l sound.lst

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO SOUND


