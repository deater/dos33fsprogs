include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	shape_table.dsk

shape_table.dsk:	HELLO APPLE.BAS GEARS.BAS \
	APPLE2 GEARS LINE32 PATTERN PATTERN_LOGO SQUARE_WAVE \
	AGONY17 HERRING16 STRIPE17 COOL_WAVE TEETH32 TICK_TOCK \
	GEARS_TINY WEAVE15 COLUMNS16 CATS16 TEST EGGS16 WAVY16 \
	MIRROR15 FIELD15 GEARS_FANCY
	cp $(EMPTYDISK) shape_table.dsk
	$(DOS33) -y shape_table.dsk SAVE A HELLO
	$(DOS33) -y shape_table.dsk SAVE A GEARS.BAS
	$(DOS33) -y shape_table.dsk SAVE A APPLE.BAS
	$(DOS33) -y shape_table.dsk BSAVE -a 0x3f5 GEARS
	$(DOS33) -y shape_table.dsk BSAVE -a 0x60 GEARS_TINY
	$(DOS33) -y shape_table.dsk BSAVE -a 0x50 GEARS_FANCY
	$(DOS33) -y shape_table.dsk BSAVE -a 0xc00 APPLE2
	$(DOS33) -y shape_table.dsk BSAVE -a 0xc00 LINE32
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 AGONY17
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 WEAVE15
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 STRIPE17
	$(DOS33) -y shape_table.dsk BSAVE -a 0xc00 HERRING16
	$(DOS33) -y shape_table.dsk BSAVE -a 0xc00 PATTERN
	$(DOS33) -y shape_table.dsk BSAVE -a 0x3f5 PATTERN_LOGO
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 SQUARE_WAVE
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 COOL_WAVE
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 TEETH32
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 TICK_TOCK
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 COLUMNS16
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 CATS16
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 TEST
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 EGGS16
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 WAVY16
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 MIRROR15
	$(DOS33) -y shape_table.dsk BSAVE -a 0xe7 FIELD15

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

GEARS_FANCY:	gears_fancy.o
	ld65 -o GEARS_FANCY gears_fancy.o -C $(LINKERSCRIPTS)/apple2_50_zp.inc

gears_fancy.o:	gears_fancy.s
	ca65 -o gears_fancy.o gears_fancy.s -l gears_fancy.lst



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

COLUMNS16:	columns16.o
	ld65 -o COLUMNS16 columns16.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

columns16.o:	columns16.s
	ca65 -o columns16.o columns16.s -l columns16.lst

###

CATS16:	cats16.o
	ld65 -o CATS16 cats16.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

cats16.o:	cats16.s
	ca65 -o cats16.o cats16.s -l cats16.lst

###

WAVY16:	wavy16.o
	ld65 -o WAVY16 wavy16.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

wavy16.o:	wavy16.s
	ca65 -o wavy16.o wavy16.s -l wavy16.lst


###

EGGS16:	eggs16.o
	ld65 -o EGGS16 eggs16.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

eggs16.o:	eggs16.s
	ca65 -o eggs16.o eggs16.s -l eggs16.lst


###

TEST:	test.o
	ld65 -o TEST test.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

test.o:	test.s
	ca65 -o test.o test.s -l test.lst



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

WEAVE15:	weave15.o
	ld65 -o WEAVE15 weave15.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

weave15.o:	weave15.s
	ca65 -o weave15.o weave15.s -l weave15.lst

###

MIRROR15:	mirror15.o
	ld65 -o MIRROR15 mirror15.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

mirror15.o:	mirror15.s
	ca65 -o mirror15.o mirror15.s -l mirror15.lst

###

FIELD15:	field15.o
	ld65 -o FIELD15 field15.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

field15.o:	field15.s
	ca65 -o field15.o field15.s -l field15.lst




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
		HERRING16 STRIPE17 AGONY17 LINE32 APPLE2 GEARS_TINY WEAVE15 \
		COLUMNS16 CATS16 TEST EGGS16 WAVY16 MIRROR15 FIELD15 \
		GEARS_FANCY

