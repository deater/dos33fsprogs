include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	dhgr_plasma.dsk

####

dhgr_plasma.dsk: HELLO \
	PLASMA
	cp $(EMPTY_DISK)/empty.dsk dhgr_plasma.dsk
	$(DOS33) -y dhgr_plasma.dsk SAVE A HELLO
	$(DOS33) -y dhgr_plasma.dsk BSAVE -a 0x8000 PLASMA

####

PLASMA:	plasma.o
	ld65 -o PLASMA plasma.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

plasma.o:	plasma.s \
	do_plasma.s init_plasma.s scroll_off.s \
	zp.inc hardware.inc
	ca65 -o plasma.o plasma.s -l plasma.lst

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###


clean:
	rm -f *~ *.o *.lst PLASMA HELLO

