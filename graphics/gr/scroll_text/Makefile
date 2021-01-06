include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft


all:	scroll_text.dsk scroller

$(DOS33):	
	cd ../../../utils/dos33fs-utils && make

scroll_text.dsk:	$(DOS33) HELLO SCROLL_DEMO
	cp empty.dsk scroll_text.dsk
	$(DOS33) -y scroll_text.dsk SAVE A HELLO
	$(DOS33) -y scroll_text.dsk BSAVE -a 0x1000 SCROLL_DEMO

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SCROLL_DEMO:	scroll_demo.o
	ld65 -o SCROLL_DEMO scroll_demo.o -C ../../../linker_scripts/apple2_1000.inc

scroll_demo.o:	scroll_demo.s \
	deater_scroll.inc \
	gr_hlin.s \
	gr_fast_clear.s \
	gr_scroll.s \
	pageflip.s \
	gr_setpage.s
	ca65 -o scroll_demo.o scroll_demo.s -l scroll_demo.lst

###

scroller:	scroller.o
	$(CC) $(LFLAGS) -o scroller scroller.o

scroller.o:	scroller.c
	$(CC) $(CFLAGS) -c scroller.c

###

clean:	
	rm -f *~ *.o scroller background SCROLL_DEMO *.lst

