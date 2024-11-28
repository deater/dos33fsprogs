include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft


all:	DUCK_POND

####

DUCK_POND:	duck_pond.o
	ld65 -o DUCK_POND duck_pond.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

duck_pond.o:	duck_pond.s ../zx02_optim.s \
		../zp.inc ../hardware.inc \
		../gr_copy.s duck_score.s ../gr_putsprite_mask.s \
		draw_ducks.s move_ducks.s \
		graphics/duck_sprites.inc graphics/num_sprites.inc
	ca65 -o duck_pond.o duck_pond.s -l duck_pond.lst

graphics/duck_sprites.inc:	
	cd graphics && make

####

clean:	
	rm -f *.lst *.o *~ DUCK_POND

distclean:
	rm -f *.lst *.o *~ DUCK_POND
	cd graphics && make clean
