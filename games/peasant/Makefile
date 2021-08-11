include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts
EMPTY_DISK = ../../empty_disk

all:	peasant.dsk

peasant.dsk:	QBOOT QLOAD INTRO PEASANT
	cp $(EMPTY_DISK)/empty.dsk peasant.dsk
#	$(DOS33) -y peasant.dsk BSAVE -a 0x6000 PEASANT
	$(DOS33_RAW) peasant.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) peasant.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) peasant.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) peasant.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) peasant.dsk  3  0 INTRO      0   0
	$(DOS33_RAW) peasant.dsk  10 0 PEASANT    0   0

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s	qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_e00.inc

qload.o:	qload.s qboot.inc
	ca65 -o qload.o qload.s -l qload.lst

###

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

intro.o:	intro.s graphics_intro/intro_graphics.inc
	ca65 -o intro.o intro.s -l intro.lst

###

PEASANT:	peasant.o
	ld65 -o PEASANT peasant.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant.o:	peasant.s graphics/graphics.inc \
		directions.s cottage.s lake_w.s lake_e.s river.s knight.s
	ca65 -o peasant.o peasant.s -l peasant.lst

###

FONT_TEST:	font_test.o
	ld65 -o FONT_TEST font_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_test.o:	font_test.s hgr_font.s hgr_1x8_sprite.s
	ca65 -o font_test.o font_test.s -l font_test.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO PEASANT FONT_TEST

