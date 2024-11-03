include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	band.dsk

###

band.dsk:	HELLO BAND
	cp $(EMPTY_DISK)/empty.dsk band.dsk
	$(DOS33) -y band.dsk SAVE A HELLO
	$(DOS33) -y band.dsk BSAVE -a 0x6000 BAND

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###



####

BAND:	band.o
	ld65 -o BAND band.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

band.o:	band.s vertical_scroll.s \
	font_4am_1x8_oneline.s\
	band_core.s lyrics.s \
	./fonts/font_4am_1x8_data.s \
	zp.inc hardware.inc \
	graphics/guitar_sprites.inc \
	hgr_sprite.s
	ca65 -o band.o band.s -l band.lst

###

#graphics/summary1_invert.hgr.zx02:	
#	cd graphics && make

###

clean:
		rm -f *~ *.o *.lst BAND


