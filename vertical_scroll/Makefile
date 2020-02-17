include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle

all:	scroller.dsk

scroller.dsk:	HELLO SCROLLER
	cp empty.dsk scroller.dsk
	$(DOS33) -y scroller.dsk SAVE A HELLO
	$(DOS33) -y scroller.dsk BSAVE -a 0x1000 SCROLLER

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

SCROLLER:	scroller.o
	ld65 -o SCROLLER scroller.o -C ../linker_scripts/apple2_1000.inc

scroller.o:	scroller.s gr_copy.s gr_unrle.s gr_unrle_large.s \
	gr_copy_large.s \
	zp.inc hardware.inc desire.inc spaceman.inc
	ca65 -o scroller.o scroller.s -l scroller.lst

####

desire.inc:	desire.png desire2.png
	$(PNG2RLE) asm desire.png desire_rle > desire.inc
	$(PNG2RLE) asm desire2.png desire2_rle >> desire.inc

spaceman.inc:	spaceman_big.png
	$(PNG2RLE) asm spaceman_big.png spaceman_rle > spaceman.inc


####

clean:		
		rm -f *~ *.o *.lst SCROLLER
