include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts
EMPTY_DISK = ../../empty_disk
LZSA = ~/research/lzsa/lzsa/lzsa

all:	peasant.dsk peasant_side2.dsk

zip:	peasant.dsk peasant_side2.dsk
	zip peasant.zip peasant.dsk peasant_side2.dsk

peasant.dsk:	QBOOT QLOAD VID_LOGO TITLE INTRO \
	PEASANT1 PEASANT2 PEASANT3 PEASANT4 ENDING TROGDOR \
	SAVE1 SAVE2 SAVE3 MUSIC INVENTORY PARSE_INPUT.LZSA
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
	$(DOS33_RAW) peasant.dsk  13 0 PARSE_INPUT.LZSA  0   0
	$(DOS33_RAW) peasant.dsk  14 0 INVENTORY  0   0
	$(DOS33_RAW) peasant.dsk  15 0 PEASANT1	  0   0
	$(DOS33_RAW) peasant.dsk  20 0 PEASANT2	  0   0
	$(DOS33_RAW) peasant.dsk  25 0 PEASANT3	  0   0
	$(DOS33_RAW) peasant.dsk  30 0 PEASANT4	  0   0

peasant_side2.dsk:	WBOOT2 COPY_CHECK TROGDOR ENDING \
	CLIFF GAME_OVER INSIDE INN ARCHERY MAP
	cp $(EMPTY_DISK)/empty.dsk peasant_side2.dsk
	$(DOS33_RAW) peasant_side2.dsk   0 0  WBOOT2      0   1
	$(DOS33_RAW) peasant_side2.dsk   1 0 COPY_CHECK   0   0
	$(DOS33_RAW) peasant_side2.dsk   3 0 GAME_OVER    0   0
	$(DOS33_RAW) peasant_side2.dsk   4 0 MAP          0   0
	$(DOS33_RAW) peasant_side2.dsk   6 0 ARCHERY      0   0
	$(DOS33_RAW) peasant_side2.dsk   9 0 INSIDE       0   0
	$(DOS33_RAW) peasant_side2.dsk  14 0 INN          0   0
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
		text/word_list.s \
		clear_bottom.s \
		hgr_hgr2.s \
		gr_offsets.s \
		qkumba_popwr.s \
		random16.s
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

###

generate_all_symbols:	generate_all_symbols.o
	$(CC) $(LFLAGS) -o generate_all_symbols generate_all_symbols.o

generate_all_symbols.o:	generate_all_symbols.c
	$(CC) $(CFLAGS) -c generate_all_symbols.c


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
	./generate_common -a 0xb00 -s save_menu qload.lst >> qload.inc
	./generate_common -a 0xb00 -s load_menu qload.lst >> qload.inc
	./generate_common -a 0xb00 -s location_names_l qload.lst >> qload.inc
	./generate_common -a 0xb00 -s location_names_h qload.lst >> qload.inc
	./generate_common -a 0xb00 -s wait_until_keypress qload.lst >> qload.inc
	./generate_common -a 0xb00 -s random16 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s score_points qload.lst >> qload.inc
	./generate_common -a 0xb00 -s print_score qload.lst >> qload.inc
	./generate_common -a 0xb00 -s update_score qload.lst >> qload.inc
	./generate_common -a 0xb00 -s speaker_beep qload.lst >> qload.inc
	./generate_common -a 0xb00 -s speaker_duration qload.lst >> qload.inc
	./generate_common -a 0xb00 -s speaker_frequency qload.lst >> qload.inc
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
		text/intro.inc \
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
		parse_input.inc \
		cliff_actions.s DIALOG_CLIFF.LZSA dialog_cliff.inc \
		graphics_cliff/cliff_graphics.inc sprites/peasant_sprites.inc \
		graphics_cliff/priority_cliff.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o cliff.o cliff.s -l cliff.lst

###

ARCHERY:	archery.o
	ld65 -o ARCHERY archery.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

archery.o:	archery.s zp.inc inventory.inc \
		parse_input.inc \
		graphics_archery/archery_graphics.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o archery.o archery.s -l archery.lst

###

MAP:	map.o
	ld65 -o MAP map.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

map.o:	map.s zp.inc inventory.inc \
		parse_input.inc \
		graphics_map/map_graphics.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o map.o map.s -l map.lst



###


GAME_OVER:	game_over.o
	ld65 -o GAME_OVER game_over.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

game_over.o:	game_over.s zp.inc \
		graphics_over/game_over_graphics.inc \
		graphics_over/game_over_animation.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o game_over.o game_over.s -l game_over.lst



###


PEASANT1:	peasant1.o
	ld65 -o PEASANT1 peasant1.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant1.o:	peasant1.s zp.inc inventory.inc \
		parse_input.inc \
		peasant1_actions.s DIALOG_PEASANT1.LZSA dialog_peasant1.inc \
		text/peasant1.inc text/kerrek.inc \
		kerrek_actions.s \
		sprites/peasant_sprites.inc sprites/inventory_sprites.inc \
		graphics_peasantry/graphics_peasant1.inc \
		graphics_peasantry/priority_peasant1.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o peasant1.o peasant1.s -l peasant1.lst

###

PEASANT2:	peasant2.o
	ld65 -o PEASANT2 peasant2.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant2.o:	peasant2.s zp.inc inventory.inc \
		parse_input.inc \
		peasant2_actions.s DIALOG_PEASANT2.LZSA dialog_peasant2.inc \
		graphics_peasantry/graphics_peasant2.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_peasant2.inc \
		sprites/inventory_sprites.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		peasant_move.s score.s inventory.s loadsave_menu.s
	ca65 -o peasant2.o peasant2.s -l peasant2.lst

###

PEASANT3:	peasant3.o
	ld65 -o PEASANT3 peasant3.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant3.o:	peasant3.s zp.inc inventory.inc \
		parse_input.inc \
		peasant3_actions.s DIALOG_PEASANT3.LZSA dialog_peasant3.inc \
		graphics_peasantry/graphics_peasant3.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_peasant3.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o peasant3.o peasant3.s -l peasant3.lst

###

PEASANT4:	peasant4.o
	ld65 -o PEASANT4 peasant4.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant4.o:	peasant4.s zp.inc inventory.inc \
		parse_input.inc \
		sprites/ned_sprites.inc \
		peasant4_actions.s DIALOG_PEASANT4.LZSA dialog_peasant4.inc \
		kerrek_actions.s \
		text/peasant4.inc text/kerrek.inc \
		graphics_peasantry/graphics_peasant4.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_peasant4.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
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
		keyboard.s new_map_location.s \
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
		keyboard.s new_map_location.s \
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

INSIDE:	inside.o
	ld65 -o INSIDE inside.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

inside.o:	inside.s zp.inc inventory.inc \
		parse_input.inc \
		inside_actions.s DIALOG_INSIDE.LZSA dialog_inside.inc \
		graphics_inside/graphics_inside.inc sprites/peasant_sprites.inc \
		graphics_inside/priority_inside.inc \
		sprites/inventory_sprites.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		peasant_move.s score.s inventory.s loadsave_menu.s
	ca65 -o inside.o inside.s -l inside.lst

###

INN:	inn.o
	ld65 -o INN inn.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

inn.o:	inn.s zp.inc inventory.inc \
		parse_input.inc \
		inn_actions.s DIALOG_INN.LZSA dialog_inn.inc \
		graphics_inn/graphics_inn.inc sprites/peasant_sprites.inc \
		graphics_inn/priority_inn.inc \
		sprites/inventory_sprites.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		peasant_move.s score.s inventory.s loadsave_menu.s
	ca65 -o inn.o inn.s -l inn.lst



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

parse_input.inc:	generate_common parse_input
	./generate_common -a 0xee00 -s parse_input parse_input.lst > parse_input.inc
	./generate_common -a 0xee00 -s setup_default_verb_table parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s load_custom_verb_table parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s partial_message_step parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s finish_parse_message parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_talk parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_haldo parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_give parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_ask parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_unknown parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_look parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_get parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_climb parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_load parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_common_save parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s get_noun_again parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s parse_input_smc parse_input.lst >> parse_input.inc


###

PARSE_INPUT.LZSA:	parse_input
	$(LZSA) -r -f2 parse_input PARSE_INPUT.LZSA

parse_input:	parse_input.o
	ld65 -o parse_input parse_input.o -C ../../linker_scripts/apple2_ee00.inc

parse_input.o:	parse_input.s tokens.inc text/common.inc.lookup
	ca65 -o parse_input.o parse_input.s -l parse_input.lst


###

DIALOG_PEASANT1.LZSA:	dialog_peasant1
	$(LZSA) -r -f2 dialog_peasant1 DIALOG_PEASANT1.LZSA

dialog_peasant1:	dialog_peasant1.o
	ld65 -o dialog_peasant1 dialog_peasant1.o -C ../../linker_scripts/apple2_d000.inc

dialog_peasant1.o:	dialog_peasant1.s text/peasant1.inc.lookup
	ca65 -o dialog_peasant1.o dialog_peasant1.s -l dialog_peasant1.lst

###

dialog_peasant1.inc:	generate_all_symbols dialog_peasant1
	./generate_all_symbols -a 0xd000 dialog_peasant1.lst > dialog_peasant1.inc

###

DIALOG_PEASANT2.LZSA:	dialog_peasant2
	$(LZSA) -r -f2 dialog_peasant2 DIALOG_PEASANT2.LZSA

dialog_peasant2:	dialog_peasant2.o
	ld65 -o dialog_peasant2 dialog_peasant2.o -C ../../linker_scripts/apple2_d000.inc

dialog_peasant2.o:	dialog_peasant2.s text/peasant2.inc.lookup
	ca65 -o dialog_peasant2.o dialog_peasant2.s -l dialog_peasant2.lst

###

dialog_peasant2.inc:	generate_all_symbols dialog_peasant2
	./generate_all_symbols -a 0xd000 dialog_peasant2.lst > dialog_peasant2.inc

####

DIALOG_PEASANT3.LZSA:	dialog_peasant3
	$(LZSA) -r -f2 dialog_peasant3 DIALOG_PEASANT3.LZSA

dialog_peasant3:	dialog_peasant3.o
	ld65 -o dialog_peasant3 dialog_peasant3.o -C ../../linker_scripts/apple2_d000.inc

dialog_peasant3.o:	dialog_peasant3.s text/peasant3.inc.lookup
	ca65 -o dialog_peasant3.o dialog_peasant3.s -l dialog_peasant3.lst

###

dialog_peasant3.inc:	generate_all_symbols dialog_peasant3
	./generate_all_symbols -a 0xd000 dialog_peasant3.lst > dialog_peasant3.inc

####
DIALOG_PEASANT4.LZSA:	dialog_peasant4
	$(LZSA) -r -f2 dialog_peasant4 DIALOG_PEASANT4.LZSA

dialog_peasant4:	dialog_peasant4.o
	ld65 -o dialog_peasant4 dialog_peasant4.o -C ../../linker_scripts/apple2_d000.inc

dialog_peasant4.o:	dialog_peasant4.s text/peasant4.inc.lookup
	ca65 -o dialog_peasant4.o dialog_peasant4.s -l dialog_peasant4.lst

###

dialog_peasant4.inc:	generate_all_symbols dialog_peasant4
	./generate_all_symbols -a 0xd000 dialog_peasant4.lst > dialog_peasant4.inc

####

DIALOG_INSIDE.LZSA:	dialog_inside
	$(LZSA) -r -f2 dialog_inside DIALOG_INSIDE.LZSA

dialog_inside:	dialog_inside.o
	ld65 -o dialog_inside dialog_inside.o -C ../../linker_scripts/apple2_d000.inc

dialog_inside.o:	dialog_inside.s text/inside.inc.lookup
	ca65 -o dialog_inside.o dialog_inside.s -l dialog_inside.lst

###

dialog_inside.inc:	generate_all_symbols dialog_inside
	./generate_all_symbols -a 0xd000 dialog_inside.lst > dialog_inside.inc

####

DIALOG_INN.LZSA:	dialog_inn
	$(LZSA) -r -f2 dialog_inn DIALOG_INN.LZSA

dialog_inn:	dialog_inn.o
	ld65 -o dialog_inn dialog_inn.o -C ../../linker_scripts/apple2_d000.inc

dialog_inn.o:	dialog_inn.s text/inn.inc.lookup
	ca65 -o dialog_inn.o dialog_inn.s -l dialog_inn.lst

###

dialog_inn.inc:	generate_all_symbols dialog_inn
	./generate_all_symbols -a 0xd000 dialog_inn.lst > dialog_inn.inc

####

DIALOG_CLIFF.LZSA:	dialog_cliff
	$(LZSA) -r -f2 dialog_cliff DIALOG_CLIFF.LZSA

dialog_cliff:	dialog_cliff.o
	ld65 -o dialog_cliff dialog_cliff.o -C ../../linker_scripts/apple2_d000.inc

dialog_cliff.o:	dialog_cliff.s text/cliff.inc
	ca65 -o dialog_cliff.o dialog_cliff.s -l dialog_cliff.lst

###

dialog_cliff.inc:	generate_all_symbols dialog_cliff
	./generate_all_symbols -a 0xd000 dialog_cliff.lst > dialog_cliff.inc

####

dialog_test:	dialog_test.o
	ld65 -o dialog_test dialog_test.o -C ../../linker_scripts/apple2_d000.inc

dialog_test.o:	dialog_test.s
	ca65 -o dialog_test.o dialog_test.s -l dialog_test.lst

####

graphics_archery/archery_graphics.inc:
	cd graphics_archery && make

graphics_cliff/cliff_graphics.inc:
	cd graphics_cliff && make

graphics_copy/copy_graphics.inc:
	cd graphics_copy && make

graphics_end/ending_graphics.inc:
	cd graphics_end && make

graphics_inn/graphics_inn.inc:
	cd graphics_inn && make

graphics_inside/graphics_inside.inc:
	cd graphics_inside && make

graphics_map/map_graphics.inc:
	cd graphics_map && make

graphics_over/game_over_graphics.inc:
	cd graphics_over && make

graphics_peasantry/graphics_intro.inc:
	cd graphics_peasantry && make

graphics_peasantry/graphics_peasant1.inc:
	cd graphics_peasantry && make

graphics_title/title_graphics.inc:
	cd graphics_title && make

graphics_trogdor/trogdor_graphics.inc:
	cd graphics_trogdor && make

graphics_vid/vid_graphics.inc:
	cd graphics_vid && make

####

sprites/inventory_sprites.inc:
	cd sprites && make

sprites/peasant_sprites.inc:
	cd sprites && make

sprites/trogdor_sprites.inc:
	cd sprites && make

####

text/common.inc.lookup:
	cd text && make


###

distclean:
	make clean
	cd sprites && make clean
	cd graphics_archery && make clean
	cd graphics_cliff && make clean
	cd graphics_copy && make clean
	cd graphics_end && make clean
	cd graphics_inn && make clean
	cd graphics_inside && make clean
	cd graphics_map && make clean
	cd graphics_over && make clean
	cd graphics_peasantry && make clean
	cd graphics_title && make clean
	cd graphics_trogdor && make clean
	cd graphics_vid && make clean
	cd text && make clean

###

clean:	
	rm -f *~ *.o *.lst HELLO VID_LOGO TITLE INTRO COPY_CHECK \
			PEASANT1 PEASANT2 PEASANT3 PEASANT4 \
			TROGDOR ENDING MUSIC GAME_OVER \
			dialog_peasant2
