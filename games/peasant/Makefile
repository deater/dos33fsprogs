include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts
EMPTY_DISK = ../../empty_disk
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PRODOSDIR = ../../utils/prodos-utils/
PRODOS = ../../utils/prodos-utils/prodos
PRODOS_RAW = ../../utils/prodos-utils/prodos_raw


all:	peasant_disk1.dsk peasant_disk2.dsk peasant_disk3.dsk peasant.2mg

peasant_disk1.dsk:	QBOOT QLOAD \
	./vid_logo/VID_LOGO ./title/TITLE ./intro/INTRO \
	./music/MUSIC ./copy/COPY_CHECK ./inventory/INVENTORY \
	SAVE1 SAVE2 SAVE3 PARSE_INPUT.ZX02 ./game_over/GAME_OVER
	cp $(EMPTY_DISK)/empty.dsk peasant_disk1.dsk
	$(DOS33_RAW) peasant_disk1.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) peasant_disk1.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) peasant_disk1.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) peasant_disk1.dsk  0 11 SAVE1      0   1
	$(DOS33_RAW) peasant_disk1.dsk  0 12 SAVE2      0   1
	$(DOS33_RAW) peasant_disk1.dsk  0 13 SAVE3      0   1
	$(DOS33_RAW) peasant_disk1.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) peasant_disk1.dsk  3  0 ./music/MUSIC       0   0
	$(DOS33_RAW) peasant_disk1.dsk  4  0 ./vid_logo/VID_LOGO 0   0
	$(DOS33_RAW) peasant_disk1.dsk  6  0 ./title/TITLE       0   0
	$(DOS33_RAW) peasant_disk1.dsk  9  0 ./intro/INTRO       0   0
	$(DOS33_RAW) peasant_disk1.dsk  13 0 PARSE_INPUT.ZX02  0   0
	$(DOS33_RAW) peasant_disk1.dsk  14 0 ./inventory/INVENTORY  0   0
	$(DOS33_RAW) peasant_disk1.dsk  15 0 ./game_over/GAME_OVER    0   0
	$(DOS33_RAW) peasant_disk1.dsk  30 0 ./copy/COPY_CHECK   0   0

peasant_disk2.dsk:	QBOOT QLOAD \
	PEASANT1 PEASANT2 PEASANT3 PEASANT4 \
	./wrong_boot/WBOOT2
	cp $(EMPTY_DISK)/empty.dsk peasant_disk2.dsk
	$(DOS33_RAW) peasant_disk2.dsk   0 0  ./wrong_boot/WBOOT2      0   1
	$(DOS33_RAW) peasant_disk2.dsk  15 0 PEASANT1	  0   0
	$(DOS33_RAW) peasant_disk2.dsk  20 0 PEASANT2	  0   0
	$(DOS33_RAW) peasant_disk2.dsk  25 0 PEASANT3	  0   0
	$(DOS33_RAW) peasant_disk2.dsk  30 0 PEASANT4	  0   0

peasant_disk3.dsk:	./trogdor/TROGDOR ./ending/ENDING \
	./cliff_base/CLIFF_BASE ./cliff_heights/CLIFF_HEIGHTS \
	./climb/CLIMB \
	./game_over/GAME_OVER ./inside/INSIDE ./inn/INN \
	./archery/ARCHERY ./map/MAP \
	./wrong_boot/WBOOT3
	cp $(EMPTY_DISK)/empty.dsk peasant_disk3.dsk
	$(DOS33_RAW) peasant_disk3.dsk   0 0  ./wrong_boot/WBOOT3      0   1
	$(DOS33_RAW) peasant_disk3.dsk   1 0 ./map/MAP          0   0
	$(DOS33_RAW) peasant_disk3.dsk   3 0 ./archery/ARCHERY      0   0
	$(DOS33_RAW) peasant_disk3.dsk   7 0 ./inside/INSIDE       0   0
	$(DOS33_RAW) peasant_disk3.dsk  11 0 ./inn/INN          0   0
	$(DOS33_RAW) peasant_disk3.dsk  15 0 ./trogdor/TROGDOR	  0   0
	$(DOS33_RAW) peasant_disk3.dsk  19 0 ./ending/ENDING	  0   0
	$(DOS33_RAW) peasant_disk3.dsk  24 0 ./cliff_base/CLIFF_BASE	  0   0
	$(DOS33_RAW) peasant_disk3.dsk  26 0 ./climb/CLIMB	  0   0
	$(DOS33_RAW) peasant_disk3.dsk  30 0 ./cliff_heights/CLIFF_HEIGHTS	  0   0

peasant.2mg:  dts_block PROBOOTHD QLOAD_HD \
	./vid_logo/VID_LOGO ./title/TITLE ./intro/INTRO \
	./music/MUSIC ./copy/COPY_CHECK ./inventory/INVENTORY \
	./map/MAP ./archery/ARCHERY ./inside/INSIDE ./inn/INN \
	./trogdor/TROGDOR ./ending/ENDING ./cliff_base/CLIFF_BASE \
	./climb/CLIMB \
	./cliff_heights/CLIFF_HEIGHTS \
	SAVE1 SAVE2 SAVE3 PARSE_INPUT.ZX02 ./game_over/GAME_OVER
	$(PRODOSDIR)/mkprodosfs peasant.2mg -n PeasantsQ -b 2800 -2
	$(PRODOS_RAW) peasant.2mg 0 PROBOOTHD 0 0
	$(PRODOS_RAW) peasant.2mg `./dts_block 0 1  0`  QLOAD_HD 0 0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 0 11` SAVE1      0   1
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 0 12` SAVE2      0   1
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 0 13` SAVE3      0   1
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 3  0` ./music/MUSIC       0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 4  0` ./vid_logo/VID_LOGO 0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 6  0` ./title/TITLE       0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 9  0` ./intro/INTRO       0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 13 0` PARSE_INPUT.ZX02  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 14 0` ./inventory/INVENTORY  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 15 0` ./game_over/GAME_OVER    0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 30 0` ./copy/COPY_CHECK   0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2  0 0`  ./wrong_boot/WBOOT2      0   1
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 15 0` PEASANT1	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 20 0` PEASANT2	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 25 0` PEASANT3	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 30 0` PEASANT4	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3  0 0` ./wrong_boot/WBOOT3      0   1
	$(PRODOS_RAW) peasant.2mg `./dts_block 3  1 0` ./map/MAP          0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3  3 0` ./archery/ARCHERY      0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3  7 0` ./inside/INSIDE       0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 11 0` ./inn/INN          0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 15 0` ./trogdor/TROGDOR	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 19 0` ./ending/ENDING	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 24 0` ./cliff_base/CLIFF_BASE	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 26 0` ./climb/CLIMB	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 30 0` ./cliff_heights/CLIFF_HEIGHTS	  0   0

###

dts_block:	dts_block.o
	$(CC) $(LFLAGS) -o dts_block dts_block.o

dts_block.o:	dts_block.c
	$(CC) $(CFLAGS) -c dts_block.c

###

PROBOOTHD:	proboothd.o
	ld65 -o PROBOOTHD proboothd.o -C $(LINKER_SCRIPTS)/apple2_800.inc

proboothd.o:	proboothd.s
	ca65 -o proboothd.o proboothd.s -l proboothd.lst

###

QLOAD_HD:       qload_hd.o
	ld65 -o QLOAD_HD qload_hd.o -C $(LINKER_SCRIPTS)/apple2_b00.inc

qload_hd.o:	qload_hd.s qboot.inc \
		zx02_optim.s \
		hgr_font.s \
		draw_box.s \
		hgr_rectangle.s \
		hgr_1x28_sprite_mask.s \
		hgr_partial_save.s \
		hgr_input.s \
		hgr_tables.s \
		hgr_text_box.s \
		text/word_list.s \
		clear_bottom.s \
		hgr_hgr2.s \
		hgr_copy.s \
		gr_offsets.s \
		qkumba_popwr.s \
		random16.s
	ca65 -o qload_hd.o qload.s -DFLOPPY=0 -l qload_hd.lst

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s	qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst


###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_b00.inc

qload.o:	qload.s qboot.inc \
		zx02_optim.s \
		hgr_font.s \
		draw_box.s \
		hgr_rectangle.s \
		hgr_1x28_sprite_mask.s \
		hgr_partial_save.s \
		hgr_input.s \
		hgr_tables.s \
		hgr_text_box.s \
		text/word_list.s \
		clear_bottom.s \
		hgr_hgr2.s \
		hgr_copy.s \
		gr_offsets.s \
		qkumba_popwr.s \
		random16.s
	ca65 -o qload.o qload.s -DFLOPPY=1 -l qload.lst

###

./wrong_boot/WBOOT2:
	cd wrong_boot && make

./wrong_boot/WBOOT3:
	cd wrong_boot && make


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

qboot.inc:	generate_common QBOOT
	./generate_common -a 0x000 -s seek qboot_sector.lst > qboot.inc
	./generate_common -a 0x000 -s curtrk_smc qboot_sector.lst >> qboot.inc
	./generate_common -a 0x000 -s phase_smc qboot_sector.lst >> qboot.inc
	./generate_common -a 0x000 -s driveon qboot_sector.lst >> qboot.inc
	./generate_common -a 0x000 -s wait_1s qboot_sector.lst >> qboot.inc
	./generate_common -a 0x000 -s driveoff qboot_sector.lst >> qboot.inc
	./generate_common -a 0x000 -s switch_drive1 qboot_sector.lst >> qboot.inc
	./generate_common -a 0x000 -s switch_drive2 qboot_sector.lst >> qboot.inc
	./generate_common -a 0x000 -s load_new qboot_sector.lst >> qboot.inc
	./generate_common -a 0x000 -s load_address qboot_sector.lst >> qboot.inc
	echo "load_track=load_address+1" >> qboot.inc
	echo "load_sector=load_address+2" >> qboot.inc
	echo "load_length=load_address+3" >> qboot.inc

####

qload.inc:	generate_common QLOAD
	./generate_common -a 0xb00 -s load_file qload.lst > qload.inc
	./generate_common -a 0xb00 -s sector_write qload.lst >> qload.inc
#	./generate_common -a 0xb00 -s check_floppy_in_drive2 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s requested_sector qload.lst >> qload.inc
	./generate_common -a 0xb00 -s zx02_full_decomp qload.lst >> qload.inc
	./generate_common -a 0xb00 -s zx_src_l qload.lst >> qload.inc
	./generate_common -a 0xb00 -s zx_src_h qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr2 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_make_tables qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_put_string qload.lst >> qload.inc
	./generate_common -a 0xb00 -s restore_bg_1x28 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_draw_sprite_1x28 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s input_buffer qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_text_box qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_text_box_nosave qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_partial_restore qload.lst >> qload.inc
	./generate_common -a 0xb00 -s clear_bottom qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_input qload.lst >> qload.inc
	./generate_common -a 0xb00 -s done_hgr_input qload.lst >> qload.inc
	./generate_common -a 0xb00 -s draw_box qload.lst >> qload.inc
	./generate_common -a 0xb00 -s disp_put_string qload.lst >> qload.inc
	./generate_common -a 0xb00 -s disp_one_line qload.lst >> qload.inc
	./generate_common -a 0xb00 -s invert_smc1 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s disp_put_string_cursor qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_put_char_cursor qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_put_char qload.lst >> qload.inc
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
#	echo "driveoff = \$$A22" >> qload.inc
#	echo "driveon = \$$A9D" >> qload.inc

####

./music/music.inc:	./generate_common
	cd music && make

###

./inventory/inventory.inc:	./generate_common
	cd inventory && make

###

inventory/INVENTORY:	
	cd inventory && make

./vid_logo/VID_LOGO: qload.inc
	cd vid_logo && make

./title/TITLE:	./music/music.inc
	cd title && make

./intro/INTRO:	./music/music.inc
	cd intro && make

./music/MUSIC:	
	cd music && make

####

./cliff_base/CLIFF_BASE:
	cd cliff_base && make

./climb/CLIMB:
	cd climb && make

./cliff_heights/CLIFF_HEIGHTS:
	cd cliff_heights && make

./archery/ARCHERY:
	cd archery && make

./map/MAP:	
	cd map && make

./game_over/GAME_OVER:
	cd game_over && make


./knight_falls_rock/KNIGHT_FALLS_ROCK:	DIALOG_KNIGHT_FALLS_ROCK.ZX02
	cd knight_falls_rock && make

###


PEASANT1:	peasant1.o
	ld65 -o PEASANT1 peasant1.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant1.o:	peasant1.s zp.inc ./inventory/inventory.inc \
		parse_input.inc \
		peasant1_actions.s \
		text/DIALOG_PEASANT1.ZX02 text/dialog_peasant1.inc \
		kerrek_actions.s peasant_common.s \
		sprites/peasant_sprites.inc \
		sprites/kerrek_sprites.inc \
		sprites/gary_sprites.inc \
		graphics_peasantry/graphics_peasant1.inc \
		graphics_peasantry/priority_peasant1.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		move_peasant.s score.s
	ca65 -o peasant1.o peasant1.s -l peasant1.lst

###

PEASANT2:	peasant2.o
	ld65 -o PEASANT2 peasant2.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant2.o:	peasant2.s zp.inc ./inventory/inventory.inc \
		parse_input.inc \
		peasant2_actions.s \
		text/DIALOG_PEASANT2.ZX02 text/dialog_peasant2.inc \
		graphics_peasantry/graphics_peasant2.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_peasant2.inc \
		sprites/river_bubble_sprites.inc \
		animate_river.s \
		peasant_common.s \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		move_peasant.s score.s loadsave_menu.s
	ca65 -o peasant2.o peasant2.s -l peasant2.lst

###

PEASANT3:	peasant3.o
	ld65 -o PEASANT3 peasant3.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant3.o:	peasant3.s zp.inc ./inventory/inventory.inc \
		parse_input.inc \
		peasant3_actions.s \
		text/DIALOG_PEASANT3.ZX02 text/dialog_peasant3.inc \
		graphics_peasantry/graphics_peasant3.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_peasant3.inc \
		peasant_common.s \
		animate_bubbles.s \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		move_peasant.s score.s
	ca65 -o peasant3.o peasant3.s -l peasant3.lst

###

PEASANT4:	peasant4.o
	ld65 -o PEASANT4 peasant4.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant4.o:	peasant4.s zp.inc ./inventory/inventory.inc \
		parse_input.inc \
		sprites/ned_sprites.inc \
		peasant4_actions.s \
		text/DIALOG_PEASANT4.ZX02 text/dialog_peasant4.inc \
		kerrek_actions.s peasant_common.s \
		graphics_peasantry/graphics_peasant4.inc sprites/peasant_sprites.inc \
		graphics_peasantry/priority_peasant4.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_1x28_sprite_mask.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s new_map_location.s \
		move_peasant.s score.s
	ca65 -o peasant4.o peasant4.s -l peasant4.lst

###

./trogdor/TROGDOR:	
	cd trogdor && make

./ending/ENDING:	
	cd ending && make

./copy/COPY_CHECK:	
	cd copy && make

./inside/INSIDE:
	cd inside && make

./inn/INN:
	cd inn && make

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
	./generate_common -a 0xee00 -s finish_parse_message_nowait parse_input.lst >> parse_input.inc
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
	./generate_common -a 0xee00 -s hay_blown_away_message parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s print_text_message parse_input.lst >> parse_input.inc
	./generate_common -a 0xee00 -s restore_parse_message parse_input.lst >> parse_input.inc



###

PARSE_INPUT.ZX02:	parse_input
	$(ZX02) -f  parse_input PARSE_INPUT.ZX02

parse_input:	parse_input.o
	ld65 -o parse_input parse_input.o -C ../../linker_scripts/apple2_ee00.inc

parse_input.o:	parse_input.s tokens.inc text/common.inc.lookup
	ca65 -o parse_input.o parse_input.s -l parse_input.lst

###

text/DIALOG_PEASANT1.ZX02:
	cd text && make

text/DIALOG_PEASANT2.ZX02:
	cd text && make

text/DIALOG_PEASANT3.ZX02:
	cd text && make

text/DIALOG_PEASANT4.ZX02:
	cd text && make

###

text/dialog_peasant1.inc:
	cd text && make

text/dialog_peasant2.inc:
	cd text && make

text/dialog_peasant3.inc:
	cd text && make

text/dialog_peasant4.inc:
	cd text && make

####

dialog_test:	dialog_test.o
	ld65 -o dialog_test dialog_test.o -C ../../linker_scripts/apple2_d000.inc

dialog_test.o:	dialog_test.s
	ca65 -o dialog_test.o dialog_test.s -l dialog_test.lst

####

graphics_peasantry/graphics_intro.inc:
	cd graphics_peasantry && make

graphics_peasantry/graphics_peasant1.inc:
	cd graphics_peasantry && make

####

sprites/peasant_sprites.inc:
	cd sprites && make

####

text/common.inc.lookup:
	cd text && make


###

submit:	peasant_floppies.zip peasant.2mg.zip

peasant_floppies.zip:	peasant_disk1.dsk peasant_disk2.dsk peasant_disk3.dsk
	zip peasant_floppies.zip peasant_disk1.dsk peasant_disk2.dsk peasant_disk3.dsk

peasant.2mg.zip:	peasant.2mg
	zip peasant.2mg.zip peasant.2mg

###

distclean:
	make clean
	cd sprites && make clean
	cd sprites_peasant && make clean
	cd graphics_peasantry && make clean
	cd text && make clean
	cd archery && make distclean
	cd cliff_base && make distclean
	cd cliff_heights && make distclean
	cd climb && make clean
	cd copy && make distclean
	cd ending && make distclean
	cd game_over && make distclean
	cd inn && make distclean
	cd inside && make distclean
	cd intro && make distclean
	cd map && make distclean
	cd text && make distclean
	cd trogdor && make distclean
	cd vid_logo && make distclean
	cd wrong_boot && make distclean
	cd music && make distclean
###

clean:	
	rm -f *~ *.o *.lst qload.inc \
			PEASANT1 PEASANT2 PEASANT3 PEASANT4 \
			*.ZX02 dialog_peasant2 \
			generate_common generate_all_symbols
	cd archery && make clean
	cd cliff_base && make clean
	cd cliff_heights && make clean
	cd climb && make clean
	cd copy && make clean
	cd ending && make clean
	cd game_over && make clean
	cd inn && make clean
	cd inside && make clean
	cd intro && make clean
	cd map && make clean
	cd music && make clean
	cd text && make clean
	cd title && make clean
	cd trogdor && make clean
	cd vid_logo && make clean
	cd wrong_boot && make clean
