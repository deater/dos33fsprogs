include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2GR = ../../utils/gr-utils/png2gr
PNG2RLE = ../../utils/gr-utils/png2rle

TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft


ARTDIR = ./art

all:	tfv.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

tfv.dsk:	$(DOS33) HELLO LOADER TFV_CREDITS TFV_TITLE TFV_FLYING TFV_WORLD
	$(DOS33) -y tfv.dsk SAVE A HELLO
	$(DOS33) -y tfv.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y tfv.dsk BSAVE -a 0x4000 TFV_CREDITS
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 TFV_TITLE
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 TFV_FLYING
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 TFV_WORLD

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../../linker_scripts/apple2_1000.inc

loader.o:	loader.s init_vars.s common_defines.inc zp.inc
	ca65 -o loader.o loader.s -l loader.lst

###

credits.o:	credits.s credits_sprites.inc mockingboard.s \
	vapor_lock.s gr_putsprite.s move_letters.s \
	./graphics_credits/KATC.lzsa
	ca65 -o credits.o credits.s -l credits.lst

TFV_CREDITS:	credits.o
	ld65 -o TFV_CREDITS credits.o -C ../../linker_scripts/apple2_4000.inc

###

TFV_TITLE:	tfv_title.o
	ld65 -o TFV_TITLE tfv_title.o -C ../../linker_scripts/apple2_2000.inc

tfv_title.o:	tfv_title.s zp.inc \
	gr_vlin.s tfv_opener.s \
	draw_menu.s keyboard.s joystick.s \
	graphics_title/tfv_title.inc
	ca65 -o tfv_title.o tfv_title.s -l tfv_title.lst

###

###

TFV_FLYING:	tfv_flying.o
	ld65 -o TFV_FLYING tfv_flying.o -C ../../linker_scripts/apple2_2000.inc

tfv_flying.o:	tfv_flying.s zp.inc \
	gr_putsprite.s \
	help_flying.s \
	flying_mode7.s flying_sprites.inc
	ca65 -o tfv_flying.o tfv_flying.s -l tfv_flying.lst

###

TFV_WORLD:	tfv_world.o
	ld65 -o TFV_WORLD tfv_world.o -C ../../linker_scripts/apple2_2000.inc

tfv_world.o:	tfv_world.s zp.inc \
	long_wait.s gr_put_num.s gr_putsprite_mask.s \
	tfv_overworld.s tfv_drawmap.s \
	tfv_battle.s tfv_battle_menu.s tfv_battle_limit.s tfv_battle_summons.s \
	tfv_battle_magic.s tfv_battle_enemy.s tfv_battle_draw_hero.s \
	tfv_battle_boss.s tfv_battle_attack.s \
	help_overworld.s rotate_intro.s rotozoom.s \
	sound_effects.s speaker_tone.s \
	graphics_map/tfv_backgrounds.inc \
	graphics_battle/battle_graphics.inc \
	tfv_sprites.inc battle_sprites.inc \
	play_music.s music/fighting.pt3 music/victory.pt3 music/battle_music.inc
	ca65 -o tfv_world.o tfv_world.s -l tfv_world.lst

graphics_map/tfv_backgrounds.inc:
	cd graphics_map && make

graphics_battle/battle_graphics.inc:
	cd graphics_battle && make

music/battle_music.inc:
	cd battle_music && make



###

clean:	
	rm -f *~ TITLE.GR *.o *.lst TFV_CREDITS TFV_TITLE TFV_FLYING TFV_WORLD HELLO LOADER
	cd graphics_battle && make clean
	cd music && make clean
