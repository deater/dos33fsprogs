include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../linker_scripts/

all:	MONSTERS

###

MONSTERS:	monsters.o
	ld65 -o MONSTERS monsters.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

monsters.o:	monsters.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	graphics/monster_pumpkin.raw_bottom.zx02 graphics/monster_pumpkin.raw_top.zx02 \
	graphics/pq_tree_dhgr.raw_bottom.zx02 graphics/pq_tree_dhgr.raw_top.zx02
	ca65 -o monsters.o monsters.s -l monsters.lst

####

graphics/monster_pumpkin.raw_top.zx02:	
	cd graphics && make

graphics/monster_pumpkin.raw_bottom.zx02:	
	cd graphics && make


####

clean:
	rm -f *~ MONSTERS *.zx02 *.lst *.o *.AUX *.BIN

distclean:
	rm -f *~ MONSTERS *.zx02 *.lst *.o *.AUX *.BIN
	cd graphics && make clean

