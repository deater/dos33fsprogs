include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY = ../../empty_disk/empty.dsk

all:	scroller.dsk

scroller.dsk:	HELLO SCROLLER
	cp $(EMPTY) scroller.dsk
	$(DOS33) -y scroller.dsk SAVE A HELLO
	$(DOS33) -y scroller.dsk BSAVE -a 0x1000 SCROLLER

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

SCROLLER:	scroller.o
	ld65 -o SCROLLER scroller.o -C ../../linker_scripts/apple2_1000.inc

scroller.o:	scroller.s gr_copy.s gr_unrle.s gr_unrle_large.s \
	gr_copy_large.s \
	zp.inc hardware.inc desire.inc spaceman.inc spaceman2.inc
	ca65 -o scroller.o scroller.s -l scroller.lst

####

desire.inc:	desire.png desire2.png
	$(PNG2RLE) asm desire.png desire_rle > desire.inc
	$(PNG2RLE) asm desire2.png desire2_rle >> desire.inc

spaceman.inc:	spaceman_big.png
	$(PNG2RLE) asm spaceman_big.png spaceman_rle > spaceman.inc

spaceman2.inc:	spaceman_big2.png
	$(PNG2RLE) asm spaceman_big2.png spaceman2_rle > spaceman2.inc


####

clean:		
		rm -f *~ *.o *.lst SCROLLER HELLO
