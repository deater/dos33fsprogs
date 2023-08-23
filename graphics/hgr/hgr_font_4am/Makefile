include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	hgr_font4.dsk

hgr_font4.dsk:	HELLO BIOS_TEST
	cp $(EMPTY_DISK)/empty.dsk hgr_font4.dsk
	$(DOS33) -y hgr_font4.dsk SAVE A HELLO
	$(DOS33) -y hgr_font4.dsk BSAVE -a 0x6000 BIOS_TEST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BIOS_TEST:	bios_test.o
	ld65 -o BIOS_TEST bios_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

bios_test.o:	bios_test.s hgr_font.s hgr_1x8_sprite.s
	ca65 -o bios_test.o bios_test.s -l bios_test.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO BIOS_TEST

