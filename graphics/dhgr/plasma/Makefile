include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	dhgr_plasma.dsk

####

dhgr_plasma.dsk: HELLO \
	HGR_PLASMA
	cp $(EMPTY_DISK)/empty.dsk dhgr_plasma.dsk
	$(DOS33) -y dhgr_plasma.dsk SAVE A HELLO
	$(DOS33) -y dhgr_plasma.dsk BSAVE -a 0x8000 HGR_PLASMA

####

HGR_PLASMA:	hgr_plasma.o
	ld65 -o HGR_PLASMA hgr_plasma.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

hgr_plasma.o:	hgr_plasma.s \
	init_plasma.s scroll_off.s \
	zp.inc hardware.inc
	ca65 -o hgr_plasma.o hgr_plasma.s -l hgr_plasma.lst

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###


clean:
	rm -f *~ *.o *.lst HGR_PLASMA HELLO

