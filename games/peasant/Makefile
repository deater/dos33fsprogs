include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts
EMPTY_DISK = ../../empty_disk

all:	peasant.dsk

peasant.dsk:	HELLO PEASANT FONT_TEST
	cp $(EMPTY_DISK)/empty.dsk peasant.dsk
	$(DOS33) -y peasant.dsk SAVE A HELLO
	$(DOS33) -y peasant.dsk BSAVE -a 0x6000 PEASANT
	$(DOS33) -y peasant.dsk BSAVE -a 0x6000 FONT_TEST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PEASANT:	peasant.o
	ld65 -o PEASANT peasant.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant.o:	peasant.s graphics/graphics.inc \
		directions.s cottage.s lake_w.s lake_e.s river.s
	ca65 -o peasant.o peasant.s -l peasant.lst

###

FONT_TEST:	font_test.o
	ld65 -o FONT_TEST font_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_test.o:	font_test.s hgr_font.s hgr_1x8_sprite.s
	ca65 -o font_test.o font_test.s -l font_test.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO PEASANT FONT_TEST

