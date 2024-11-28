include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	ASPLODE BACK_OFF

####

ASPLODE:	asplode.o
	ld65 -o ASPLODE asplode.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

asplode.o:	asplode.s ../zx02_optim.s \
		graphics/sb_title.hgr.zx02 \
		graphics/sb_zone.hgr.zx02 \
		graphics/sb_sprites.inc \
		sound/asplode_sound.btc.zx02 \
		../audio.s play_asplode.s asplode_head.s \
		../hgr_sprite_big.s cycle_colors.s \
		../zp.inc ../hardware.inc
	ca65 -o asplode.o asplode.s -l asplode.lst

graphics/sb_sprites.inc:	
	cd graphics && make

graphics/sb_title.hgr.zx02:	
	cd graphics && make

asplode_sound/asplode.btc.zx02:	
	cd asplode_sound && make


####

BACK_OFF:	back_off.o
	ld65 -o BACK_OFF back_off.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

back_off.o:	back_off.s ../zx02_optim.s \
		graphics/bob_bg.hgr.zx02 \
		graphics/bob_sprites.inc \
		sound/back_off.btc.zx02 \
		../audio.s play_back_off.s \
		../hgr_sprite_big.s \
		../zp.inc ../hardware.inc
	ca65 -o back_off.o back_off.s -l back_off.lst

####

clean:	
	rm -f *.lst *.o *~ ASPLODE BACK_OFF



distclean:
	rm -f *.lst *.o *~ ASPLODE BACK_OFF
	cd graphics && make clean
	cd sound && make clean

