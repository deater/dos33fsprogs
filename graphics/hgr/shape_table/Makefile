include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	shape_table.dsk

shape_table.dsk:	HELLO APPLE.BAS GEARS.BAS \
	APPLE2 GEARS LINE32 PATTERN PATTERN_LOGO SQUARE_WAVE \
	AGONY17 HERRING16 STRIPE17 COOL_WAVE TEETH32 TICK_TOCK \
	GEARS_TINY
	cp $(EMPTYDISK) shape_table.dsk
	$(DOS33) -y shape_table.dsk SAVE A HELLO
	$(DOS33) -y shape_table.dsk SAVE A GEARS.BAS
	$(DOS33) -y shape_table.dsk SAVE A APPLE.BAS
	$(DOS33) -y shape_table.dsk BSAVE -a 0x3f5 GEARS
	$(DOS33) -y shape_table.dsk BSAVE -a 0x60 GEARS_TINY
	$(DOS33) -y shape_table.dsk BSAVE -a 0xc00 APPLE2
	$(DOS33) -y shape_table.dsk BSAVE -a 0xc00 LINE32
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 AGONY17
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 STRIPE17
	$(DOS33) -y shape_table.dsk BSAVE -a 0xc00 HERRING16
	$(DOS33) -y shape_table.dsk BSAVE -a 0xc00 PATTERN
	$(DOS33) -y shape_table.dsk BSAVE -a 0x3f5 PATTERN_LOGO
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 SQUARE_WAVE
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 COOL_WAVE
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 TEETH32
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 TICK_TOCK

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

GEARS.BAS:	gears.bas
	$(TOKENIZE) < gears.bas > GEARS.BAS

###

APPLE.BAS:	apple.bas
	$(TOKENIZE) < apple.bas > APPLE.BAS


###

GEARS:	gears.o
	ld65 -o GEARS gears.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

gears.o:	gears.s
	ca65 -o gears.o gears.s -l gears.lst

###

GEARS_TINY:	gears_tiny.o
	ld65 -o GEARS_TINY gears_tiny.o -C $(LINKERSCRIPTS)/apple2_60_zp.inc

gears_tiny.o:	gears_tiny.s
	ca65 -o gears_tiny.o gears_tiny.s -l gears_tiny.lst


###

SQUARE_WAVE:	square_wave.o
	ld65 -o SQUARE_WAVE square_wave.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

square_wave.o:	square_wave.s
	ca65 -o square_wave.o square_wave.s -l square_wave.lst


###

COOL_WAVE:	cool_wave.o
	ld65 -o COOL_WAVE cool_wave.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

cool_wave.o:	cool_wave.s
	ca65 -o cool_wave.o cool_wave.s -l cool_wave.lst

###

TEETH32:	teeth32.o
	ld65 -o TEETH32 teeth32.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

teeth32.o:	teeth32.s
	ca65 -o teeth32.o teeth32.s -l teeth32.lst

###

TICK_TOCK:	tick_tock.o
	ld65 -o TICK_TOCK tick_tock.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

tick_tock.o:	tick_tock.s
	ca65 -o tick_tock.o tick_tock.s -l tick_tock.lst





###

APPLE2:	apple2.o
	ld65 -o APPLE2 apple2.o -C $(LINKERSCRIPTS)/apple2_c00.inc

apple2.o:	apple2.s
	ca65 -o apple2.o apple2.s -l apple2.lst

###

LINE32:	line32.o
	ld65 -o LINE32 line32.o -C $(LINKERSCRIPTS)/apple2_c00.inc

line32.o:	line32.s
	ca65 -o line32.o line32.s -l line32.lst

###

AGONY17:	agony17.o
	ld65 -o AGONY17 agony17.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

agony17.o:	agony17.s
	ca65 -o agony17.o agony17.s -l agony17.lst

###

STRIPE17:	stripe17.o
	ld65 -o STRIPE17 stripe17.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

stripe17.o:	stripe17.s
	ca65 -o stripe17.o stripe17.s -l stripe17.lst


###

HERRING16:	herring16.o
	ld65 -o HERRING16 herring16.o -C $(LINKERSCRIPTS)/apple2_c00.inc

herring16.o:	herring16.s
	ca65 -o herring16.o herring16.s -l herring16.lst



###

PATTERN:	pattern.o
	ld65 -o PATTERN pattern.o -C $(LINKERSCRIPTS)/apple2_c00.inc

pattern.o:	pattern.s
	ca65 -o pattern.o pattern.s -l pattern.lst

###

PATTERN_LOGO:	pattern_logo.o
	ld65 -o PATTERN_LOGO pattern_logo.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

pattern_logo.o:	pattern_logo.s
	ca65 -o pattern_logo.o pattern_logo.s -l pattern_logo.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO GEAR.BAS GEARS PATTERN APPLE.BAS \
		PATTERN_LOGO COOL_WAVE SQUARE_WAVE TEETH32 TICK_TOCK \
		HERRING16 STRIPE17 AGONY17 LINE32 APPLE2 GEARS_TINY
