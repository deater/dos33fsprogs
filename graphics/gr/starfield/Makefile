include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	starfield.dsk

$(DOS33):	
	cd ../../../utils/dos33fs-utils && make

starfield.dsk:	$(DOS33) HELLO STARFIELD_DEMO STARFIELD_1K STARFIELD.BAS \
	STARSMALL STARBOT STARBOT_LOOKUP
	cp $(EMPTY_DISK)/empty.dsk starfield.dsk
	$(DOS33) -y starfield.dsk SAVE A HELLO
	$(DOS33) -y starfield.dsk SAVE A STARFIELD.BAS
	$(DOS33) -y starfield.dsk BSAVE -a 0x1000 STARFIELD_DEMO
	$(DOS33) -y starfield.dsk BSAVE -a 0x1000 STARFIELD_1K
	$(DOS33) -y starfield.dsk BSAVE -a 0xc00 STARSMALL
	$(DOS33) -y starfield.dsk BSAVE -a 0xc00 STARBOT_LOOKUP
	$(DOS33) -y starfield.dsk BSAVE -a 0x36d STARBOT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

STARFIELD.BAS:	starfield.bas
	$(TOKENIZE) < starfield.bas > STARFIELD.BAS


###

STARFIELD_DEMO:	starfield_demo.o
	ld65 -o STARFIELD_DEMO starfield_demo.o -C $(LINKERSCRIPTS)/apple2_1000.inc

starfield_demo.o:	starfield_demo.s \
	gr_scroll.s \
	pageflip.s \
	gr_setpage.s \
	gr_fast_clear.s
	ca65 -o starfield_demo.o starfield_demo.s -l starfield_demo.lst

###

STARFIELD_1K:   starfield_1k.o
	ld65 -o STARFIELD_1K starfield_1k.o -C $(LINKERSCRIPTS)/apple2_1000.inc

starfield_1k.o: starfield_1k.s \
	gr_scroll.s \
	pageflip.s \
	gr_setpage.s \
	gr_fast_clear.s
	ca65 -o starfield_1k.o starfield_1k.s -l starfield_1k.lst

###

STARSMALL:   starsmall.o
	ld65 -o STARSMALL starsmall.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starsmall.o: starsmall.s
	ca65 -o starsmall.o starsmall.s -l starsmall.lst

###

STARBOT:   starbot.o
	ld65 -o STARBOT starbot.o -C $(LINKERSCRIPTS)/apple2_36d.inc

starbot.o: starbot.s
	ca65 -o starbot.o starbot.s -l starbot.lst

###

STARBOT_LOOKUP:   starbot_lookup.o
	ld65 -o STARBOT_LOOKUP starbot_lookup.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starbot_lookup.o: starbot_lookup.s
	ca65 -o starbot_lookup.o starbot_lookup.s -l starbot_lookup.lst


###

clean:	
	rm -f *~ *.o STARFIELD_DEMO STARFIELD_1K *.lst

