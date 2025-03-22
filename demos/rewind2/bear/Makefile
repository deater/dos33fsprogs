include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../linker_scripts/

all:	BEAR

###

BEAR:	bear.o
	ld65 -o BEAR bear.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

bear.o:	bear.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	bear.packed.zx02
	ca65 -o bear.o bear.s -l bear.lst

####

bear.packed.zx02:     bear.packed
	$(ZX02) bear.packed bear.packed.zx02

bear.packed:  bear.png
	$(PNG_TO_DHGR4) bear.png bear

####

clean:
	rm -f *~ BEAR *.zx02
