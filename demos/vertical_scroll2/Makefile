include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY = ../../empty_disk/empty.dsk
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
PNG2RAW = ../../utils/gr-utils/png2raw

all:	scroller.dsk

scroller.dsk:	HELLO SCROLLER DSR_INTRO
	cp $(EMPTY) scroller.dsk
	$(DOS33) -y scroller.dsk SAVE A HELLO
	$(DOS33) -y scroller.dsk BSAVE -a 0x1000 SCROLLER
	$(DOS33) -y scroller.dsk BSAVE -a 0x1000 DSR_INTRO

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

SCROLLER:	scroller.o
	ld65 -o SCROLLER scroller.o -C ../../linker_scripts/apple2_1000.inc

scroller.o:	scroller.s gr_copy.s \
	gr_copy_large.s \
	zp.inc hardware.inc spaceman.lzsa spaceman2.lzsa
	ca65 -o scroller.o scroller.s -l scroller.lst

####

DSR_INTRO:	dsr_intro.o
	ld65 -o DSR_INTRO dsr_intro.o -C ../../linker_scripts/apple2_1000.inc

dsr_intro.o:	dsr_intro.s gr_copy.s \
	gr_copy_large.s \
	zp.inc hardware.inc desire.lzsa desire2.lzsa
	ca65 -o dsr_intro.o dsr_intro.s -l dsr_intro.lst


####

desire.inc:	desire.png desire2.png
	$(PNG2RLE) asm desire.png desire_rle > desire.inc
	$(PNG2RLE) asm desire2.png desire2_rle >> desire.inc

desire.lzsa:	desire.gr
	$(LZSA) -r -f2 desire.gr desire.lzsa

desire.gr:	desire.png
	$(PNG2GR) desire.png desire.gr

desire2.lzsa:	desire2.gr
	$(LZSA) -r -f2 desire2.gr desire2.lzsa

desire2.gr:	desire2.png
	$(PNG2GR) desire2.png desire2.gr


spaceman.lzsa:	spaceman_big.raw
	$(LZSA) -r -f2 spaceman_big.raw spaceman.lzsa

spaceman_big.raw:	spaceman_big.png
	$(PNG2RAW) spaceman_big.png spaceman_big.raw

spaceman2.lzsa:	spaceman_big2.raw
	$(LZSA) -r -f2 spaceman_big2.raw spaceman2.lzsa

spaceman_big2.raw:	spaceman_big2.png
	$(PNG2RAW) spaceman_big2.png spaceman_big2.raw



spaceman.inc:	spaceman_big.png
	$(PNG2RLE) asm spaceman_big.png spaceman_rle > spaceman.inc

spaceman2.inc:	spaceman_big2.png
	$(PNG2RLE) asm spaceman_big2.png spaceman2_rle > spaceman2.inc


####

clean:		
		rm -f *~ *.o *.lst SCROLLER HELLO DSR_INTRO
