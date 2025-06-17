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


all:	peasant_disk1.dsk peasant_disk2.dsk peasant_disk3.dsk \
	peasant_disk4.dsk peasant_disk5.dsk peasant.2mg

peasant_disk1.dsk:	QBOOT QLOAD \
	./vid_logo/VID_LOGO ./title/TITLE ./intro/INTRO \
	./music/MUSIC ./copy/COPY_CHECK ./inventory/INVENTORY \
	./saves/SAVE_DATA PARSE_INPUT.ZX02 \
	./game_over/GAME_OVER \
	sprites_peasant/PEASANT_SPRITES_COMMON \
	map/MAP
	cp $(EMPTY_DISK)/empty.dsk peasant_disk1.dsk
	$(DOS33_RAW) peasant_disk1.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) peasant_disk1.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) peasant_disk1.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) peasant_disk1.dsk  0 12 ./saves/SAVE_DATA  0   1
	$(DOS33_RAW) peasant_disk1.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) peasant_disk1.dsk  3  0 ./sprites_peasant/PEASANT_SPRITES_COMMON  0   0
	$(DOS33_RAW) peasant_disk1.dsk  4  0 ./game_over/GAME_OVER    0   0
	$(DOS33_RAW) peasant_disk1.dsk  5  0 ./map/MAP          0   0
	$(DOS33_RAW) peasant_disk1.dsk  7  0 ./music/MUSIC       0   0
	$(DOS33_RAW) peasant_disk1.dsk  8  0 ./vid_logo/VID_LOGO 0   0
	$(DOS33_RAW) peasant_disk1.dsk  10  0 ./title/TITLE       0   0
	$(DOS33_RAW) peasant_disk1.dsk  13  0 ./intro/INTRO       0   0
	$(DOS33_RAW) peasant_disk1.dsk  17 0 PARSE_INPUT.ZX02  0   0
	$(DOS33_RAW) peasant_disk1.dsk  18 0 ./inventory/INVENTORY  0   0
	$(DOS33_RAW) peasant_disk1.dsk  30 0 ./copy/COPY_CHECK   0   0

peasant_disk2.dsk:	QBOOT QLOAD \
	./location_gary/GARY_LOADER \
	./location_kerrek1/KERREK1_LOADER \
	./location_well/WELL_LOADER \
	./location_yellow_tree/YELLOW_TREE_LOADER \
	./location_waterfall/WATERFALL_LOADER \
	./location_haystack/HAYSTACK_LOADER \
	./location_puddle/PUDDLE_LOADER \
	./location_brothers/BROTHERS_LOADER \
	./location_river/RIVER_LOADER \
	./location_knight/KNIGHT_LOADER \
	./wrong_boot/WBOOT2 \
	./game_over/GAME_OVER \
	sprites_peasant/PEASANT_SPRITES_COMMON \
	map/MAP
	cp $(EMPTY_DISK)/empty.dsk peasant_disk2.dsk
	$(DOS33_RAW) peasant_disk2.dsk   0 0  ./wrong_boot/WBOOT2      0   1
	$(DOS33_RAW) peasant_disk2.dsk  3  0 ./sprites_peasant/PEASANT_SPRITES_COMMON  0   0
	$(DOS33_RAW) peasant_disk2.dsk  4  0 ./game_over/GAME_OVER    0   0
	$(DOS33_RAW) peasant_disk2.dsk  5  0 ./map/MAP          0   0
	$(DOS33_RAW) peasant_disk2.dsk  10 0 ./location_gary/GARY_LOADER 0   0
	$(DOS33_RAW) peasant_disk2.dsk  12 0 ./location_kerrek1/KERREK1_LOADER 0   0
	$(DOS33_RAW) peasant_disk2.dsk  14 0 ./location_well/WELL_LOADER 0   0
	$(DOS33_RAW) peasant_disk2.dsk  16 0 ./location_yellow_tree/YELLOW_TREE_LOADER 0   0
	$(DOS33_RAW) peasant_disk2.dsk  18 0 ./location_waterfall/WATERFALL_LOADER 0   0
	$(DOS33_RAW) peasant_disk2.dsk  20 0 ./location_haystack/HAYSTACK_LOADER 0   0
	$(DOS33_RAW) peasant_disk2.dsk  22 0 ./location_puddle/PUDDLE_LOADER	  0   0
	$(DOS33_RAW) peasant_disk2.dsk  24 0 ./location_brothers/BROTHERS_LOADER 0   0
	$(DOS33_RAW) peasant_disk2.dsk  26 0 ./location_river/RIVER_LOADER	  0   0
	$(DOS33_RAW) peasant_disk2.dsk  28 0 ./location_knight/KNIGHT_LOADER	  0   0





peasant_disk3.dsk:	QBOOT QLOAD \
	./wrong_boot/WBOOT3 \
	./game_over/GAME_OVER \
	sprites_peasant/PEASANT_SPRITES_COMMON \
	location_jhonka/JHONKA_LOADER \
	location_cottage/COTTAGE_LOADER \
	location_lake_west/LAKE_WEST_LOADER \
	location_lake_east/LAKE_EAST_LOADER \
	location_outside_inn/OUTSIDE_INN_LOADER \
	location_ned_cottage/NED_COTTAGE_LOADER \
	location_wavy_tree/WAVY_TREE_LOADER \
	location_kerrek2/KERREK2_LOADER \
	location_lady_cottage/LADY_COTTAGE_LOADER \
	location_burninated/BURNINATED_LOADER \
	map/MAP
	cp $(EMPTY_DISK)/empty.dsk peasant_disk3.dsk
	$(DOS33_RAW) peasant_disk3.dsk  0  0  ./wrong_boot/WBOOT3      0   1
	$(DOS33_RAW) peasant_disk3.dsk  3  0 ./sprites_peasant/PEASANT_SPRITES_COMMON  0   0
	$(DOS33_RAW) peasant_disk3.dsk  4  0 ./game_over/GAME_OVER    0   0
	$(DOS33_RAW) peasant_disk3.dsk  5  0 ./map/MAP          0   0
	$(DOS33_RAW) peasant_disk3.dsk  10 0 ./location_jhonka/JHONKA_LOADER          0   0
	$(DOS33_RAW) peasant_disk3.dsk  12 0 ./location_cottage/COTTAGE_LOADER          0   0
	$(DOS33_RAW) peasant_disk3.dsk  14 0 ./location_lake_west/LAKE_WEST_LOADER          0   0
	$(DOS33_RAW) peasant_disk3.dsk  16 0 ./location_lake_east/LAKE_EAST_LOADER          0   0
	$(DOS33_RAW) peasant_disk3.dsk  18 0 ./location_outside_inn/OUTSIDE_INN_LOADER          0   0
	$(DOS33_RAW) peasant_disk3.dsk  20 0 ./location_ned_cottage/NED_COTTAGE_LOADER          0   0
	$(DOS33_RAW) peasant_disk3.dsk  22 0 ./location_wavy_tree/WAVY_TREE_LOADER          0   0
	$(DOS33_RAW) peasant_disk3.dsk  24 0 ./location_kerrek2/KERREK2_LOADER          0   0
	$(DOS33_RAW) peasant_disk3.dsk  26 0 ./location_lady_cottage/LADY_COTTAGE_LOADER          0   0
	$(DOS33_RAW) peasant_disk3.dsk  28 0 ./location_burninated/BURNINATED_LOADER          0   0

peasant_disk4.dsk:	\
	./location_inside_lady/INSIDE_LADY_LOADER \
	./location_inside_ned/INSIDE_NED_LOADER \
	./location_hidden_glen/HIDDEN_GLEN_LOADER \
	./location_inside_inn/INSIDE_INN_LOADER \
	./archery/ARCHERY \
	./wrong_boot/WBOOT4 \
	./game_over/GAME_OVER \
	sprites_peasant/PEASANT_SPRITES_COMMON \
	map/MAP
	cp $(EMPTY_DISK)/empty.dsk peasant_disk4.dsk
	$(DOS33_RAW) peasant_disk4.dsk   0 0  ./wrong_boot/WBOOT4      0   1
	$(DOS33_RAW) peasant_disk4.dsk   3 0 ./sprites_peasant/PEASANT_SPRITES_COMMON  0   0
	$(DOS33_RAW) peasant_disk4.dsk   4 0 ./game_over/GAME_OVER    0   0
	$(DOS33_RAW) peasant_disk4.dsk   5 0 ./map/MAP          0   0
	$(DOS33_RAW) peasant_disk4.dsk   7 0 ./archery/ARCHERY      0   0
	$(DOS33_RAW) peasant_disk4.dsk  16 0 ./location_inside_inn/INSIDE_INN_LOADER          0   0
	$(DOS33_RAW) peasant_disk4.dsk  18 0 ./location_inside_lady/INSIDE_LADY_LOADER          0   0
	$(DOS33_RAW) peasant_disk4.dsk  20 0 ./location_inside_ned/INSIDE_NED_LOADER          0   0
	$(DOS33_RAW) peasant_disk4.dsk  22 0 ./location_hidden_glen/HIDDEN_GLEN_LOADER          0   0

peasant_disk5.dsk:	./wrong_boot/WBOOT5 \
	 ./climb/CLIMB \
	 ./location_outer/OUTER_LOADER \
	./location_cliff_base/CLIFF_BASE_LOADER \
	./location_cliff_heights/CLIFF_HEIGHTS_LOADER \
	./trogdor/TROGDOR ./ending/ENDING \
	./game_over/GAME_OVER \
	sprites_peasant/PEASANT_SPRITES_COMMON \
	map/MAP
	cp $(EMPTY_DISK)/empty.dsk peasant_disk5.dsk
	$(DOS33_RAW) peasant_disk5.dsk   0 0  ./wrong_boot/WBOOT5	0   1
	$(DOS33_RAW) peasant_disk5.dsk   1 0 ./location_cliff_base/CLIFF_BASE_LOADER	0   0
	$(DOS33_RAW) peasant_disk5.dsk   3 0 ./sprites_peasant/PEASANT_SPRITES_COMMON  0   0
	$(DOS33_RAW) peasant_disk5.dsk   4 0 ./game_over/GAME_OVER    0   0
	$(DOS33_RAW) peasant_disk5.dsk   5 0 ./map/MAP          0   0
	$(DOS33_RAW) peasant_disk5.dsk   3 0 ./climb/CLIMB	  	0   0
	$(DOS33_RAW) peasant_disk5.dsk   7 0 ./location_cliff_heights/CLIFF_HEIGHTS_LOADER	  0   0
	$(DOS33_RAW) peasant_disk5.dsk  11 0 ./location_outer/OUTER_LOADER	  	0   0
	$(DOS33_RAW) peasant_disk5.dsk  15 0 ./trogdor/TROGDOR	  	0   0
	$(DOS33_RAW) peasant_disk5.dsk  19 0 ./ending/ENDING	  	0   0



peasant.2mg:  dts_block PROBOOTHD QLOAD_HD \
	./vid_logo/VID_LOGO ./title/TITLE ./intro/INTRO \
	./music/MUSIC ./copy/COPY_CHECK ./inventory/INVENTORY \
	./map/MAP ./archery/ARCHERY \
	./trogdor/TROGDOR ./ending/ENDING ./location_cliff_base/CLIFF_BASE_LOADER \
	./climb/CLIMB ./location_outer/OUTER_LOADER \
	./location_cliff_heights/CLIFF_HEIGHTS_LOADER \
	./saves/SAVE_DATA PARSE_INPUT.ZX02 ./game_over/GAME_OVER \
	./location_inside_lady/INSIDE_LADY_LOADER \
	./location_inside_ned/INSIDE_NED_LOADER \
	./location_hidden_glen/HIDDEN_GLEN_LOADER \
	./location_inside_inn/INSIDE_INN_LOADER \
	./location_jhonka/JHONKA_LOADER \
	./location_cottage/COTTAGE_LOADER \
	./location_lake_west/LAKE_WEST_LOADER \
	./location_lake_east/LAKE_EAST_LOADER \
	./location_outside_inn/OUTSIDE_INN_LOADER \
	./location_gary/GARY_LOADER \
	./location_ned_cottage/NED_COTTAGE_LOADER \
	./location_wavy_tree/WAVY_TREE_LOADER \
	./location_kerrek2/KERREK2_LOADER \
	./location_lady_cottage/LADY_COTTAGE_LOADER \
	./location_burninated/BURNINATED_LOADER \
	./location_kerrek1/KERREK1_LOADER \
	./location_well/WELL_LOADER \
	./location_yellow_tree/YELLOW_TREE_LOADER \
	./location_waterfall/WATERFALL_LOADER \
	./location_knight/KNIGHT_LOADER \
	./location_river/RIVER_LOADER \
	./location_brothers/BROTHERS_LOADER \
	./location_puddle/PUDDLE_LOADER \
	./location_haystack/HAYSTACK_LOADER \
	./sprites_peasant/PEASANT_SPRITES_COMMON
	$(PRODOSDIR)/mkprodosfs peasant.2mg -n PeasantsQ -b 3360 -2
	$(PRODOS_RAW) peasant.2mg 0 PROBOOTHD 0 0
	$(PRODOS_RAW) peasant.2mg `./dts_block 0 1  0`  QLOAD_HD 0 0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 0 12` ./saves/SAVE_DATA      0   1
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 3  0` ./sprites_peasant/PEASANT_SPRITES_COMMON    0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 4  0` ./game_over/GAME_OVER    0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 5  0` ./map/MAP          0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 7  0` ./music/MUSIC       0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 8  0` ./vid_logo/VID_LOGO 0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 10 0` ./title/TITLE       0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 13 0` ./intro/INTRO       0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 17 0` PARSE_INPUT.ZX02  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 18 0` ./inventory/INVENTORY  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 1 30 0` ./copy/COPY_CHECK   0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2  0 0`  ./wrong_boot/WBOOT2      0   1
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 10 0` ./location_gary/GARY_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 12 0` ./location_kerrek1/KERREK1_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 14 0` ./location_well/WELL_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 16 0` ./location_yellow_tree/YELLOW_TREE_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 18 0` ./location_waterfall/WATERFALL_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 20 0` ./location_haystack/HAYSTACK_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 22 0` ./location_puddle/PUDDLE_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 24 0` ./location_brothers/BROTHERS_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 26 0` ./location_river/RIVER_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 2 28 0` ./location_knight/KNIGHT_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 10 0` ./location_jhonka/JHONKA_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 12 0` ./location_cottage/COTTAGE_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 14 0` ./location_lake_west/LAKE_WEST_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 16 0` ./location_lake_east/LAKE_EAST_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 18 0` ./location_outside_inn/OUTSIDE_INN_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 20 0` ./location_ned_cottage/NED_COTTAGE_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 22 0` ./location_wavy_tree/WAVY_TREE_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 24 0` ./location_kerrek2/KERREK2_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 26 0` ./location_lady_cottage/LADY_COTTAGE_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 3 28 0` ./location_burninated/BURNINATED_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 4  0 0` ./wrong_boot/WBOOT3      0   1
	$(PRODOS_RAW) peasant.2mg `./dts_block 4  7 0` ./archery/ARCHERY      0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 4 16 0` ./location_inside_inn/INSIDE_INN_LOADER          0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 4 18 0` ./location_inside_lady/INSIDE_LADY_LOADER          0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 4 20 0` ./location_inside_ned/INSIDE_NED_LOADER          0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 4 22 0` ./location_hidden_glen/HIDDEN_GLEN_LOADER          0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 5  1 0` ./location_cliff_base/CLIFF_BASE_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 5  7 0` ./climb/CLIMB	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 5 11 0` ./location_cliff_heights/CLIFF_HEIGHTS_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 5 15 0` ./location_outer/OUTER_LOADER	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 5 19 0` ./trogdor/TROGDOR	  0   0
	$(PRODOS_RAW) peasant.2mg `./dts_block 5 23 0` ./ending/ENDING	  0   0


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

#		hgr_routines/hgr_1x28_sprite_mask.s \
#		hgr_routines/hgr_partial_save.s \
#		hgr_routines/hgr_copy.s \

QLOAD_HD:       qload_hd.o
	ld65 -o QLOAD_HD qload_hd.o -C $(LINKER_SCRIPTS)/apple2_b00.inc

qload_hd.o:	qload_hd.s qboot.inc \
		zx02_optim.s \
		hgr_routines/hgr_font.s \
		hgr_routines/hgr_draw_box.s \
		hgr_routines/hgr_rectangle.s \
		hgr_routines/hgr_input.s \
		hgr_routines/hgr_tables.s \
		hgr_routines/hgr_text_box.s \
		text/word_list.s \
		clear_bottom.s \
		hgr_routines/hgr_hgr2.s \
		gr_offsets.s \
		qkumba_popwr.s \
		random8.s
	ca65 -o qload_hd.o qload.s -DFLOPPY=0 -l qload_hd.lst

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s	qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst


#		hgr_routines/hgr_1x28_sprite_mask.s \
#		hgr_routines/hgr_partial_save.s \
#		hgr_routines/hgr_copy.s \


###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_b00.inc

qload.o:	qload.s qboot.inc \
		qload_floppy.s \
		zx02_optim.s \
		hgr_routines/hgr_font.s \
		hgr_routines/hgr_draw_box.s \
		hgr_routines/hgr_rectangle.s \
		hgr_routines/hgr_input.s \
		hgr_routines/hgr_tables.s \
		hgr_routines/hgr_text_box.s \
		text/word_list.s \
		clear_bottom.s \
		hgr_routines/hgr_hgr2.s \
		gr_offsets.s \
		qkumba_popwr.s \
		random8.s \
		loadsave_menu.s \
		load_peasant_sprites.s
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
	./generate_common -a 0xb00 -s do_savegame qload.lst >> qload.inc
	./generate_common -a 0xb00 -s requested_sector qload.lst >> qload.inc
	./generate_common -a 0xb00 -s zx02_full_decomp qload.lst >> qload.inc
	./generate_common -a 0xb00 -s zx_src_l qload.lst >> qload.inc
	./generate_common -a 0xb00 -s zx_src_h qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr2 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_make_tables qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_put_string qload.lst >> qload.inc
#	./generate_common -a 0xb00 -s restore_bg_1x28 qload.lst >> qload.inc
#	./generate_common -a 0xb00 -s hgr_draw_sprite_1x28 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s input_buffer qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_text_box qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_text_box_nosave qload.lst >> qload.inc
#	./generate_common -a 0xb00 -s hgr_partial_restore qload.lst >> qload.inc
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
	./generate_common -a 0xb00 -s hgr_rectangle qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_rectangle_color qload.lst >> qload.inc
	./generate_common -a 0xb00 -s peasant_text qload.lst >> qload.inc
	./generate_common -a 0xb00 -s save_menu qload.lst >> qload.inc
	./generate_common -a 0xb00 -s load_menu qload.lst >> qload.inc
	./generate_common -a 0xb00 -s location_names_l qload.lst >> qload.inc
	./generate_common -a 0xb00 -s location_names_h qload.lst >> qload.inc
	./generate_common -a 0xb00 -s wait_until_keypress qload.lst >> qload.inc
	./generate_common -a 0xb00 -s random8 qload.lst >> qload.inc
	./generate_common -a 0xb00 -s score_points qload.lst >> qload.inc
	./generate_common -a 0xb00 -s print_score qload.lst >> qload.inc
	./generate_common -a 0xb00 -s update_score qload.lst >> qload.inc
	./generate_common -a 0xb00 -s speaker_tone qload.lst >> qload.inc
	./generate_common -a 0xb00 -s speaker_duration qload.lst >> qload.inc
	./generate_common -a 0xb00 -s speaker_frequency qload.lst >> qload.inc
	./generate_common -a 0xb00 -s hgr_page_flip qload.lst >> qload.inc
	./generate_common -a 0xb00 -s wait qload.lst >> qload.inc
	./generate_common -a 0xb00 -s load_peasant_sprites qload.lst >> qload.inc
#	echo "hposn_high = \$$BA00" >> qload.inc
#	echo "hposn_low = \$$BB00" >> qload.inc
#	./generate_common -a 0xb00 -s speaker_beep qload.lst >> qload.inc
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

./climb/CLIMB:
	cd climb && make

./archery/ARCHERY:
	cd archery && make

./map/MAP:	
	cd map && make

./game_over/GAME_OVER:
	cd game_over && make



###

#PEASANT3:	peasant3.o
#	ld65 -o PEASANT3 peasant3.o -C $(LINKER_SCRIPTS)/apple2_6000.inc
#
#peasant3.o:	peasant3.s zp.inc ./inventory/inventory.inc \
#		parse_input.inc \
#		peasant3_actions.s \
#		text/DIALOG_PEASANT3.ZX02 text/dialog_peasant3.inc \
#		graphics_peasantry/graphics_peasant3.inc sprites/peasant_sprites.inc \
#		graphics_peasantry/priority_peasant3.inc \
#		location_common/peasant_common.s \
#		animate_bubbles.s \
#		draw_box.s hgr_routines/hgr_rectangle.s hgr_routines/hgr_font.s hgr_routines/hgr_input.s \
#		hgr_routines/hgr_1x28_sprite_mask.s hgr_routines/hgr_save_restore.s \
#		wait_a_bit.s draw_peasant.s hgr_routines/hgr_text_box.s \
#		keyboard.s new_map_location.s \
#		move_peasant.s score.s
#	ca65 -o peasant3.o peasant3.s -l peasant3.lst

###

#PEASANT4:	peasant4.o
#	ld65 -o PEASANT4 peasant4.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

#peasant4.o:	peasant4.s zp.inc ./inventory/inventory.inc \
#		parse_input.inc \
#		sprites/ned_sprites.inc \
#		peasant4_actions.s \
#		text/DIALOG_PEASANT4.ZX02 text/dialog_peasant4.inc \
#		location_kerrek1/kerrek_actions.s location_common/peasant_common.s \
#		graphics_peasantry/graphics_peasant4.inc sprites/peasant_sprites.inc \
#		graphics_peasantry/priority_peasant4.inc \
#		draw_box.s hgr_routines/hgr_rectangle.s hgr_routines/hgr_font.s hgr_routines/hgr_input.s \
#		hgr_routines/hgr_1x28_sprite_mask.s hgr_routines/hgr_save_restore.s \
#		wait_a_bit.s draw_peasant.s hgr_routines/hgr_text_box.s \
#		keyboard.s new_map_location.s \
#		move_peasant.s score.s
#	ca65 -o peasant4.o peasant4.s -l peasant4.lst

###

./trogdor/TROGDOR:	
	cd trogdor && make

./ending/ENDING:	
	cd ending && make

./copy/COPY_CHECK:	
	cd copy && make

./location_brothers/BROTHERS_LOADER:
	cd location_brothers && make

./location_burninated/BURNINATED_LOADER:
	cd location_burninated && make

./location_cliff_base/CLIFF_BASE_LOADER:
	cd location_cliff_base && make

./location_cliff_heights/CLIFF_HEIGHTS_LOADER:
	cd location_cliff_heights && make

./location_cottage/COTTAGE_LOADER:
	cd location_cottage && make

./location_jhonka/JHONKA_LOADER:
	cd location_jhonka && make

./location_gary/GARY_LOADER:
	cd location_gary && make

./location_haystack/HAYSTACK_LOADER:
	cd location_haystack && make

./location_hidden_glen/HIDDEN_GLEN_LOADER:
	cd location_hidden_glen && make

./location_inside_inn/INSIDE_INN_LOADER:
	cd location_inside_inn && make

./location_inside_lady/INSIDE_LADY_LOADER:
	cd location_inside_lady && make

./location_inside_ned/INSIDE_NED_LOADER:
	cd location_inside_ned && make

./location_kerrek1/KERREK1_LOADER:
	cd location_kerrek1 && make

./location_kerrek2/KERREK2_LOADER:
	cd location_kerrek2 && make

./location_knight/KNIGHT_LOADER:
	cd location_knight && make

./location_lady_cottage/LADY_COTTAGE_LOADER:
	cd location_lady_cottage && make

./location_lake_east/LAKE_EAST_LOADER:
	cd location_lake_east && make

./location_lake_west/LAKE_WEST_LOADER:
	cd location_lake_west && make

./location_ned_cottage/NED_COTTAGE_LOADER:
	cd location_ned_cottage && make

./location_outer/OUTER_LOADER:
	cd location_outer && make

./location_outside_inn/OUTSIDE_INN_LOADER:
	cd location_outside_inn && make

./location_puddle/PUDDLE_LOADER:
	cd location_puddle && make

./location_river/RIVER_LOADER:
	cd location_river && make

./location_waterfall/WATERFALL_LOADER:
	cd location_waterfall && make

./location_wavy_tree/WAVY_TREE_LOADER:
	cd location_wavy_tree && make

./location_well/WELL_LOADER:
	cd location_well && make

./location_yellow_tree/YELLOW_TREE_LOADER:
	cd location_yellow_tree && make

./sprites_peasant/PEASANT_SPRITES_COMMON:
	cd sprites_peasant && make

###

./saves/SAVE_DATA:
	cd saves && make

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

PARSE_INPUT.ZX02:	parse_input parse_input.inc
	$(ZX02) -f  parse_input PARSE_INPUT.ZX02

parse_input:	parse_input.o
	ld65 -o parse_input parse_input.o -C ../../linker_scripts/apple2_ee00.inc

parse_input.o:	parse_input.s tokens.inc text/common.inc.lookup
	ca65 -o parse_input.o parse_input.s -l parse_input.lst

###

text/DIALOG_PEASANT3.ZX02:
	cd text && make

text/DIALOG_PEASANT4.ZX02:
	cd text && make

###

text/dialog_peasant3.inc:
	cd text && make

text/dialog_peasant4.inc:
	cd text && make

####

#dialog_test:	dialog_test.o
#	ld65 -o dialog_test dialog_test.o -C ../../linker_scripts/apple2_d000.inc

#dialog_test.o:	dialog_test.s
#	ca65 -o dialog_test.o dialog_test.s -l dialog_test.lst

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

peasant_floppies.zip:	peasant_disk1.dsk peasant_disk2.dsk \
	peasant_disk3.dsk peasant_disk4.dsk peasant_disk5.dsk
	zip peasant_floppies.zip peasant_disk1.dsk peasant_disk2.dsk \
		peasant_disk3.dsk peasant_disk4.dsk peasant_disk5.dsk

peasant.2mg.zip:	peasant.2mg
	zip peasant.2mg.zip peasant.2mg

###

distclean:
	make clean
	cd archery && make distclean
	cd climb && make distclean
	cd copy && make distclean
	cd ending && make distclean
	cd game_over && make distclean
	cd intro && make distclean
	cd inventory && make distclean
	cd location_brothers && make distclean
	cd location_burninated && make distclean
	cd location_cliff_base && make distclean
	cd location_cliff_heights && make distclean
	cd location_cottage && make distclean
	cd location_gary && make distclean
	cd location_haystack && make distclean
	cd location_hidden_glen && make distclean
	cd location_inside_inn && make distclean
	cd location_inside_lady && make distclean
	cd location_inside_ned && make distclean
	cd location_jhonka && make distclean
	cd location_kerrek1 && make distclean
	cd location_kerrek2 && make distclean
	cd location_knight && make distclean
	cd location_lady_cottage && make distclean
	cd location_lake_east && make distclean
	cd location_lake_west && make distclean
	cd location_ned_cottage && make distclean
	cd location_outer && make distclean
	cd location_outside_inn && make distclean
	cd location_puddle && make distclean
	cd location_river && make distclean
	cd location_waterfall && make distclean
	cd location_wavy_tree && make distclean
	cd location_well && make distclean
	cd location_yellow_tree && make distclean
	cd map && make distclean
	cd music && make distclean
	cd saves && make distclean
	cd sprites_peasant && make distclean
	cd text && make distclean
	cd title && make distclean
	cd trogdor && make distclean
	cd vid_logo && make distclean
	cd wrong_boot && make distclean

###

clean:	
	rm -f *~ *.o *.lst qload.inc \
		parse_input.inc \
			*.ZX02 \
			generate_common generate_all_symbols
	cd archery && make clean
	cd climb && make clean
	cd copy && make clean
	cd ending && make clean
	cd game_over && make clean
	cd hgr_routines && make clean
	cd intro && make clean
	cd inventory && make clean
	cd location_brothers && make clean
	cd location_burninated && make clean
	cd location_cliff_base && make clean
	cd location_cliff_heights && make clean
	cd location_common && make clean
	cd location_cottage && make clean
	cd location_gary && make clean
	cd location_haystack && make clean
	cd location_hidden_glen && make clean
	cd location_inside_inn && make clean
	cd location_inside_lady && make clean
	cd location_inside_ned && make clean
	cd location_jhonka && make clean
	cd location_kerrek1 && make clean
	cd location_kerrek2 && make clean
	cd location_knight && make clean
	cd location_lady_cottage && make clean
	cd location_lake_east && make clean
	cd location_lake_west && make clean
	cd location_ned_cottage && make clean
	cd location_outer && make clean
	cd location_outside_inn && make clean
	cd location_puddle && make clean
	cd location_river && make clean
	cd location_waterfall && make clean
	cd location_wavy_tree && make clean
	cd location_well && make clean
	cd location_yellow_tree && make clean
	cd map && make clean
	cd music && make clean
	cd saves && make clean
	cd sprites_peasant && make clean
	cd text && make clean
	cd title && make clean
	cd trogdor && make clean
	cd vid_logo && make clean
	cd wrong_boot && make clean
