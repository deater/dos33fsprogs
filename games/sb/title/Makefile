include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts

all:	TITLE

####

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

title.o:	title.s ../zx02_optim.s \
		../zp.inc ../hardware.inc \
		../hgr_logo_scroll.s ../audio.s ../hgr_sprite.s \
		../hgr_sprite_big.s ../hgr_copy_fast.s \
		play_purple.s ../lc_detect.s ../hgr_tables.s \
		sound/purple.btc.zx02 \
		graphics/czmg4ap_title.hgr.zx02 \
		graphics/videlectrix_top.hgr.zx02 \
		graphics/the_cheat_loading.hgr.zx02 \
		graphics/title_sprites.inc
	ca65 -o title.o title.s -l title.lst

sound/purple.btc.zx02:
	cd sound && make

graphics/czmg4ap_title.hgr.zx02:	
	cd graphics && make

####

clean:	
	rm -f *.lst *.o *~ TITLE

distclean:	
	rm -f *.lst *.o *~ TITLE
	cd sound && make clean
	cd graphics && make clean


