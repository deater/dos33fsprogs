include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	gear.dsk

gear.dsk:	HELLO APPLE.BAS GEAR.BAS \
	APPLE2 GEAR LINE32 PATTERN PATTERN_LOGO SQUARE_WAVE
	cp $(EMPTYDISK) gear.dsk
	$(DOS33) -y gear.dsk SAVE A HELLO
	$(DOS33) -y gear.dsk SAVE A GEAR.BAS
	$(DOS33) -y gear.dsk SAVE A APPLE.BAS
	$(DOS33) -y gear.dsk BSAVE -a 0x3f5 GEAR
	$(DOS33) -y gear.dsk BSAVE -a 0xc00 APPLE2
	$(DOS33) -y gear.dsk BSAVE -a 0xc00 LINE32
	$(DOS33) -y gear.dsk BSAVE -a 0xc00 PATTERN
	$(DOS33) -y gear.dsk BSAVE -a 0x3f5 PATTERN_LOGO
	$(DOS33) -y gear.dsk BSAVE -a 0xc00 SQUARE_WAVE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

GEAR.BAS:	gear.bas
	$(TOKENIZE) < gear.bas > GEAR.BAS

###

APPLE.BAS:	apple.bas
	$(TOKENIZE) < apple.bas > APPLE.BAS


###

GEAR:	gear.o
	ld65 -o GEAR gear.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

gear.o:	gear.s
	ca65 -o gear.o gear.s -l gear.lst

###

SQUARE_WAVE:	square_wave.o
	ld65 -o SQUARE_WAVE square_wave.o -C $(LINKERSCRIPTS)/apple2_c00.inc

square_wave.o:	square_wave.s
	ca65 -o square_wave.o square_wave.s -l square_wave.lst


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
	rm -f *~ *.o *.lst HELLO GEAR.BAS GEAR PATTERN APPLE.BAS PATTERN_LOGO
