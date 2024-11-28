include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

#all:	sb.dsk

all:	RAT

####

RAT:	rat.o
	ld65 -o RAT rat.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

rat.o:	rat.s \
	../zx02_optim.s ../duet.s ../hgr_sprite_mask.s \
	../hgr_sprite.s ../hgr_tables.s \
	../zp.inc ../hardware.inc \
	sound/fortnight.ed \
	graphics/a2_fortnight.hgr.zx02 \
	graphics/a2_fortnight_99.hgr.zx02 \
	graphics/a2_fortnight_100.hgr.zx02 \
	graphics/a2_fortnight_rat1.hgr.zx02 \
	graphics/a2_fortnight_rat2.hgr.zx02 \
	graphics/a2_break.hgr.zx02 \
	graphics/disk_sprites.inc
	ca65 -o rat.o rat.s -l rat.lst

sound/fortnight.ed:	
	cd sound && make

graphics/a2_fortnight.hgr.zx02:	
	cd graphics && make


clean:	
	rm -f *.lst *.o *~ RAT

distclean:	
	rm -f *.lst *.o *~ RAT
	cd sound && make clean
	cd graphics && make clean
