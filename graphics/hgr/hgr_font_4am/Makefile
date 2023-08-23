include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	hgr_font4.dsk

hgr_font4.dsk:	HELLO BIOS_TEST FONT_TEST
	cp $(EMPTY_DISK)/empty.dsk hgr_font4.dsk
	$(DOS33) -y hgr_font4.dsk SAVE A HELLO
	$(DOS33) -y hgr_font4.dsk BSAVE -a 0x6000 BIOS_TEST
	$(DOS33) -y hgr_font4.dsk BSAVE -a 0x6000 FONT_TEST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BIOS_TEST:	bios_test.o
	ld65 -o BIOS_TEST bios_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

bios_test.o:	bios_test.s \
	font_condensed.s font_condensed_data.s \
	zx02_optim.s graphics/a2_energy.hgr.zx02
	ca65 -o bios_test.o bios_test.s -l bios_test.lst

###

FONT_TEST:	font_test.o
	ld65 -o FONT_TEST font_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_test.o:	font_test.s \
	font_condensed.s font_condensed_data.s
	ca65 -o font_test.o font_test.s -l font_test.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO BIOS_TEST FONT_TEST

