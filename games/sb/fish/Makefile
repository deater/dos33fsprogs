include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts

all:	FISH

####

FISH:	fish.o
	ld65 -o FISH fish.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

fish.o:	fish.s zx02_optim.s \
		graphics/fish_title.hgr.zx02 \
		graphics/fish_bg.hgr.zx02 \
		graphics/boat_sprites.inc \
		graphics/strongbad_sprites.inc \
		graphics/fish_sprites.inc \
		sounds/fish.btc.zx02 \
		sounds/get_in_boat.btc.zx02 \
		hgr_sprite.s \
		hgr_sprite_mask.s \
		hgr_sprite_big.s \
		audio.s play_sounds.s \
		zp.inc hardware.inc
	ca65 -o fish.o fish.s -l fish.lst




#graphics/sb_sprites.inc:	
#	cd fish_graphics && make

#graphics/sb_title.hgr.zx02:	
#	cd fish_graphics && make

#sound/fish.btc.zx02:	
#	cd fish_sound && make

clean:	
	rm -f *.lst *.o FISH

