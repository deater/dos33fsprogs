include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts
EMPTY_DISK = ../../empty_disk
LZSA = ~/research/lzsa/lzsa/lzsa

all:	peasant.dsk peasant_side2.dsk

peasant.dsk:	QBOOT QLOAD VID_LOGO TITLE INTRO \
	PEASANT1 PEASANT2 PEASANT3 PEASANT4 ENDING TROGDOR \
	SAVE1 SAVE2 SAVE3 MUSIC INVENTORY
	cp $(EMPTY_DISK)/empty.dsk peasant.dsk
	$(DOS33_RAW) peasant.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) peasant.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) peasant.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) peasant.dsk  0 11 SAVE1      0   1
	$(DOS33_RAW) peasant.dsk  0 12 SAVE2      0   1
	$(DOS33_RAW) peasant.dsk  0 13 SAVE3      0   1
	$(DOS33_RAW) peasant.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) peasant.dsk  3  0 MUSIC      0   0
	$(DOS33_RAW) peasant.dsk  4  0 VID_LOGO   0   0
	$(DOS33_RAW) peasant.dsk  6  0 TITLE      0   0
	$(DOS33_RAW) peasant.dsk  9  0 INTRO      0   0
	$(DOS33_RAW) peasant.dsk  14 0 INVENTORY  0   0
	$(DOS33_RAW) peasant.dsk  15 0 PEASANT1	  0   0
	$(DOS33_RAW) peasant.dsk  20 0 PEASANT2	  0   0
	$(DOS33_RAW) peasant.dsk  25 0 PEASANT3	  0   0
	$(DOS33_RAW) peasant.dsk  30 0 PEASANT4	  0   0

peasant_side2.dsk:	WBOOT2 COPY_CHECK TROGDOR ENDING CLIFF GAME_OVER
	cp $(EMPTY_DISK)/empty.dsk peasant_side2.dsk
	$(DOS33_RAW) peasant_side2.dsk   0 0  WBOOT2      0   1
	$(DOS33_RAW) peasant_side2.dsk   1 0 COPY_CHECK   0   0
	$(DOS33_RAW) peasant_side2.dsk   3 0 GAME_OVER    0   0
	$(DOS33_RAW) peasant_side2.dsk  19 0 TROGDOR	  0   0
	$(DOS33_RAW) peasant_side2.dsk  24 0 ENDING	  0   0
	$(DOS33_RAW) peasant_side2.dsk  29 0 CLIFF	  0   0



###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s	qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst


###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_b00.inc

qload.o:	qload.s qboot.inc \
		decompress_fast_v2.s \
		hgr_font.s \
		draw_box.s \
		hgr_rectangle.s \
		hgr_1x28_sprite_mask.s \
		hgr_1x5_sprite.s \
		hgr_partial_save.s \
		hgr_input.s \
		hgr_tables.s \
		hgr_text_box.s \
		clear_bottom.s \
		hgr_hgr2.s \
		gr_offsets.s \
		qkumba_popwr.s
	ca65 -o qload.o qload.s -l qload.lst

###

WBOOT2:	wrong_boot2.o
	ld65 -o WBOOT2 wrong_boot2.o -C ../../linker_scripts/apple2_800.inc

wrong_boot2.o: 	wrong_boot2.s
	ca65 -o wrong_boot2.o wrong_boot2.s -l wrong_boot2.lst

###

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

####

qload.inc:	generate_common QLOAD
	./generate_common -a 0xb00 -s load_file qload.lst > qload.inc
	./generate_common -a 0xb00 -s sector_write qload.lst >> qload.inc
	./generate_common -a 0xb00 -s requested_sector qload.lst >> qload.inc
	./generate_common -a 0xb00 -s decompress_lzsa2_fast qload.lst >> qload.inc
	./generate_common -a 0xb00 -s getsrc_smc qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr2 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_make_tables qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_put_string qload.lst >> qload.inc
	./generate_common -a 0xb00 -s save_bg_1x28 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s restore_bg_1x28 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_draw_sprite_1x28 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s input_buffer qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_text_box qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_text_box_nosave qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_partial_restore qload.lst >> qload.inc
	./generate_common -a 0xb00 -s clear_bottom qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_input qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_partial_save qload.lst >> qload.inc
	./generate_common -a 0xb00 -s draw_box qload.lst >> qload.inc
	./generate_common -a 0xb00 -s disp_put_string qload.lst >> qload.inc
	./generate_common -a 0xb00 -s disp_one_line qload.lst >> qload.inc
	./generate_common -a 0xb00 -s invert_smc1 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s disp_put_string_cursor qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_put_char_cursor qload.lst >> qload.inc
	./generate_common -a 0xb00 -s vgi_simple_rectangle qload.lst >> qload.inc
	./generate_common -a 0xb00 -s peasant_text qload.lst >> qload.inc
	echo "hposn_high = \$$BA00" >> qload.inc
	echo "hposn_low = \$$BB00" >> qload.inc
	echo "driveoff = \$$A22" >> qload.inc
	echo "driveon = \$$A9D" >> qload.inc

####

music.inc:	generate_common MUSIC
	./generate_common -a 0xd000 -s pt3_init_song music.lst > music.inc
	./generate_common -a 0xd000 -s mockingboard_init music.lst >> music.inc
	./generate_common -a 0xd000 -s reset_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s clear_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s mockingboard_setup_interrupt music.lst >> music.inc
	./generate_common -a 0xd000 -s mockingboard_disable_interrupt music.lst >> music.inc
	./generate_common -a 0xd000 -s done_pt3_irq_handler music.lst >> music.inc
	./generate_common -a 0xd000 -s PT3_LOC music.lst >> music.inc


###

inventory.inc:	generate_common INVENTORY
	./generate_common -a 0xd000 -s show_inventory inventory.lst > inventory.inc

###

INVENTORY:	inventory.o
	ld65 -o INVENTORY inventory.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

inventory.o:	inventory.s \
		sprites/inventory_sprites.inc \
		hgr_2x16_sprite.s
	ca65 -o inventory.o inventory.s -l inventory.lst

###

VID_LOGO:	vid_logo.o
	ld65 -o VID_LOGO vid_logo.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

vid_logo.o:	vid_logo.s qload.inc \
		decompress_fast_v2.s hgr_overlay.s speaker_beeps.s \
		graphics_vid/vid_graphics.inc
	ca65 -o vid_logo.o vid_logo.s -l vid_logo.lst

###

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

title.o:	title.s qload.inc music.inc \
		graphics_title/title_graphics.inc \
		graphics_title/altfire.inc \
		directions.s \
		pt3_lib_mockingboard_patch.s duet.s
	ca65 -o title.o title.s -l title.lst

###

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

intro.o:	intro.s zp.inc qload.inc music.inc \
		graphics_peasantry/graphics_intro.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_intro.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		hgr_partial_save.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		title.s directions.s \
		intro_cottage.s intro_lake_w.s intro_lake_e.s \
		intro_river.s intro_knight.s \
		new_game.s
	ca65 -o intro.o intro.s -l intro.lst

###

MUSIC:	music.o
	ld65 -o MUSIC music.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

music.o:	music.s zp.inc \
		music/peasant.pt3 \
		pt3_lib_core.s \
		pt3_lib_mockingboard_detect.s \
		pt3_lib_detect_model.s \
		pt3_lib_mockingboard.inc \
		pt3_lib_init.s \
		pt3_lib_mockingboard_setup.s \
		pt3_lib_irq_handler.s
	ca65 -o music.o music.s -l music.lst


###


CLIFF:	cliff.o
	ld65 -o CLIFF cliff.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

cliff.o:	cliff.s zp.inc inventory.inc \
		graphics_cliff/cliff_graphics.inc sprites/peasant_sprites.inc \
		graphics_cliff/priority_cliff.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o cliff.o cliff.s -l cliff.lst

###


GAME_OVER:	game_over.o
	ld65 -o GAME_OVER game_over.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

game_over.o:	game_over.s zp.inc \
		graphics_over/game_over_graphics.inc \
		graphics_over/game_over_animation.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o game_over.o game_over.s -l game_over.lst



###


PEASANT1:	peasant1.o
	ld65 -o PEASANT1 peasant1.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant1.o:	peasant1.s zp.inc inventory.inc \
		sprites/peasant_sprites.inc sprites/inventory_sprites.inc \
		graphics_peasantry/graphics_peasant1.inc \
		graphics_peasantry/priority_peasant1.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o peasant1.o peasant1.s -l peasant1.lst

###

PEASANT2:	peasant2.o
	ld65 -o PEASANT2 peasant2.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant2.o:	peasant2.s zp.inc inventory.inc \
		graphics_peasantry/graphics_peasant2.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_peasant2.inc \
		sprites/inventory_sprites.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s inventory.s loadsave_menu.s
	ca65 -o peasant2.o peasant2.s -l peasant2.lst

###

PEASANT3:	peasant3.o
	ld65 -o PEASANT3 peasant3.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant3.o:	peasant3.s zp.inc inventory.inc \
		graphics_peasantry/graphics_peasant3.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_peasant3.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o peasant3.o peasant3.s -l peasant3.lst

###

PEASANT4:	peasant4.o
	ld65 -o PEASANT4 peasant4.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant4.o:	peasant4.s zp.inc inventory.inc \
		graphics_peasantry/graphics_peasant4.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_peasant4.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o peasant4.o peasant4.s -l peasant4.lst

###

TROGDOR:	trogdor.o
	ld65 -o TROGDOR trogdor.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

trogdor.o:	trogdor.s zp.inc \
		graphics_trogdor/trogdor_graphics.inc sprites/trogdor_sprites.inc \
		sprites/inventory_sprites.inc \
		ssi263_simple_speech.s \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s inventory.s

	ca65 -o trogdor.o trogdor.s -l trogdor.lst

###

ENDING:	ending.o
	ld65 -o ENDING ending.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

ending.o:	ending.s zp.inc qload.inc music.inc \
		graphics_end/ending_graphics.inc sprites/peasant_sprites.inc \
		sprites/ending_sprites.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_2x14_sprite_mask.s hgr_1x5_sprite.s \
		hgr_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s inventory.s

	ca65 -o ending.o ending.s -l ending.lst


###

COPY_CHECK:	copy_check.o
	ld65 -o COPY_CHECK copy_check.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

copy_check.o:	copy_check.s graphics_copy/copy_graphics.inc \
		hgr_input.s \
		draw_box.s hgr_rectangle.s hgr_font.s \
		copy_check.s
	ca65 -o copy_check.o copy_check.s -l copy_check.lst


###

SAVE1:	save1.o
	ld65 -o SAVE1 save1.o -C ../../linker_scripts/apple2_e00.inc

save1.o:	save1.s
	ca65 -o save1.o save1.s -l save1.lst

###

SAVE2:	save2.o
	ld65 -o SAVE2 save2.o -C ../../linker_scripts/apple2_e00.inc

save2.o:	save2.s
	ca65 -o save2.o save2.s -l save2.lst

###

SAVE3:	save3.o
	ld65 -o SAVE3 save3.o -C ../../linker_scripts/apple2_e00.inc

save3.o:	save3.s
	ca65 -o save3.o save3.s -l save3.lst

###

DIALOG_PEASANT1.LZSA:	dialog_peasant1
	$(LZSA) -r -f2 dialog_peasant1 DIALOG_PEASANT1.LZSA

dialog_peasant1:	dialog_peasant1.o
	ld65 -o dialog_peasant1 dialog_peasant1.o -C ../../linker_scripts/apple2_6000.inc

dialog_peasant1.o:	dialog_peasant1.s
	ca65 -o dialog_peasant1.o dialog_peasant1.s -l dialog_peasant1.lst

###

DIALOG_PEASANT2.LZSA:	dialog_peasant2
	$(LZSA) -r -f2 dialog_peasant2 DIALOG_PEASANT2.LZSA

dialog_peasant2:	dialog_peasant2.o
	ld65 -o dialog_peasant2 dialog_peasant2.o -C ../../linker_scripts/apple2_6000.inc

dialog_peasant2.o:	dialog_peasant2.s
	ca65 -o dialog_peasant2.o dialog_peasant2.s -l dialog_peasant2.lst

###

DIALOG_PEASANT3.LZSA:	dialog_peasant3
	$(LZSA) -r -f2 dialog_peasant3 DIALOG_PEASANT3.LZSA

dialog_peasant3:	dialog_peasant3.o
	ld65 -o dialog_peasant3 dialog_peasant3.o -C ../../linker_scripts/apple2_6000.inc

dialog_peasant3.o:	dialog_peasant3.s
	ca65 -o dialog_peasant3.o dialog_peasant3.s -l dialog_peasant3.lst

###

DIALOG_PEASANT4.LZSA:	dialog_peasant4
	$(LZSA) -r -f2 dialog_peasant4 DIALOG_PEASANT4.LZSA

dialog_peasant4:	dialog_peasant4.o
	ld65 -o dialog_peasant4 dialog_peasant4.o -C ../../linker_scripts/apple2_6000.inc

dialog_peasant4.o:	dialog_peasant4.s
	ca65 -o dialog_peasant4.o dialog_peasant4.s -l dialog_peasant4.lst

###

DIALOG_INSIDE.LZSA:	dialog_inside
	$(LZSA) -r -f2 dialog_inside DIALOG_INSIDE.LZSA

dialog_inside:	dialog_inside.o
	ld65 -o dialog_inside dialog_inside.o -C ../../linker_scripts/apple2_6000.inc

dialog_inside.o:	dialog_inside.s
	ca65 -o dialog_inside.o dialog_inside.s -l dialog_inside.lst

###

DIALOG_CLIFF.LZSA:	dialog_cliff
	$(LZSA) -r -f2 dialog_cliff DIALOG_CLIFF.LZSA

dialog_cliff:	dialog_cliff.o
	ld65 -o dialog_cliff dialog_cliff.o -C ../../linker_scripts/apple2_6000.inc

dialog_cliff.o:	dialog_cliff.s
	ca65 -o dialog_cliff.o dialog_cliff.s -l dialog_cliff.lst







####

graphics_vid/vid_graphics.inc:
	cd graphics_vid && make

graphics_title/title_graphics.inc:
	cd graphics_title && make

graphics_peasantry/graphics_intro.inc:
	cd graphics_peasantry && make

graphics_peasantry/graphics_peasant1.inc:
	cd graphics_peasantry && make

graphics_cliff/cliff_graphics.inc:
	cd graphics_cliff && make

graphics_copy/copy_graphics.inc:
	cd graphics_copy && make

graphics_over/game_over_graphics.inc:
	cd graphics_over && make

graphics_trogdor/trogdor_graphics.inc:
	cd graphics_trogdor && make

graphics_end/ending_graphics.inc:
	cd graphics_end && make

sprites/inventory_sprites.inc:
	cd sprites && make

sprites/trogdor_sprites.inc:
	cd sprites && make


###

distclean:
	make clean
	cd sprites && make clean
	cd graphics_vid && make clean
	cd graphics_title && make clean
	cd graphics_peasantry && make clean
	cd graphics_copy && make clean
	cd graphics_trogdor && make clean
	cd graphics_end && make clean
	cd graphics_cliff && make clean
	cd graphics_over && make clean

###

clean:	
	rm -f *~ *.o *.lst HELLO VID_LOGO TITLE INTRO COPY_CHECK \
			PEASANT1 PEASANT2 PEASANT3 PEASANT4 \
			TROGDOR ENDING MUSIC GAME_OVER



