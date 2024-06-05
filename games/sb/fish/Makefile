include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts

all:	FISH

####

FISH:	fish.o
	ld65 -o FISH fish.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

fish.o:	fish.s zx02_optim.s \
		zp.inc hardware.inc
	ca65 -o fish.o fish.s -l fish.lst


#		fish_graphics/sb_title.hgr.zx02 \
#		fish_graphics/sb_zone.hgr.zx02 \
#		fish_graphics/sb_sprites.inc \
#		fish_sound/fish_sound.btc.zx02 \
#		audio.s play_fish.s fish_head.s \
#		hgr_sprite_big.s cycle_colors.s \


#graphics/sb_sprites.inc:	
#	cd fish_graphics && make

#graphics/sb_title.hgr.zx02:	
#	cd fish_graphics && make

#sound/fish.btc.zx02:	
#	cd fish_sound && make

clean:	
	rm -f *.lst *.o FISH

