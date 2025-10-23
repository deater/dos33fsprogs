include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../utils/hgr-utils/png2dhgr4
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../../empty_disk/
LINKER_SCRIPTS = ../../../linker_scripts/

all:	dhgr_load.dsk

####

dhgr_load.dsk: HELLO \
	REGULAR
	cp $(EMPTY_DISK)/empty.dsk dhgr_load.dsk
	$(DOS33) -y dhgr_load.dsk SAVE A HELLO
	$(DOS33) -y dhgr_load.dsk BSAVE -a 0x6000 REGULAR


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

REGULAR:	regular.o
	ld65 -o REGULAR regular.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

regular.o:	regular.s \
	zp.inc hardware.inc \
	graphics/monster_pumpkin.bin.zx02 graphics/monster_pumpkin.aux.zx02
	ca65 -o regular.o regular.s -l regular.lst

####

graphics/monster_pumpkin.aux.zx02:	
	cd graphics && make

graphics/monster_pumpkin.bin.zx02:	
	cd graphics && make


####

clean:
	rm -f *~ REGULAR *.zx02 *.lst *.o HELLO

distclean:
	rm -f *~ REGULAR *.zx02 *.lst *.o HELLO
	cd graphics && make clean

