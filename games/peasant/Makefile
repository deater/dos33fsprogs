include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts
EMPTY_DISK = ../../empty_disk

all:	peasant.dsk peasant_side2.dsk

peasant.dsk:	QBOOT QLOAD VID_LOGO TITLE INTRO COPY_CHECK \
	PEASANT1 PEASANT2 PEASANT3 PEASANT4 ENDING TROGDOR
	cp $(EMPTY_DISK)/empty.dsk peasant.dsk
#	$(DOS33) -y peasant.dsk BSAVE -a 0x6000 INTRO
	$(DOS33_RAW) peasant.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) peasant.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) peasant.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) peasant.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) peasant.dsk  3  0 VID_LOGO   0   0
	$(DOS33_RAW) peasant.dsk  5  0 TITLE      0   0
	$(DOS33_RAW) peasant.dsk  8  0 INTRO      0   0
	$(DOS33_RAW) peasant.dsk  12 0 COPY_CHECK 0   0
	$(DOS33_RAW) peasant.dsk  14 0 PEASANT1	  0   0
#	$(DOS33_RAW) peasant.dsk  19 0 PEASANT2	  0   0
	$(DOS33_RAW) peasant.dsk  19 0 TROGDOR	  0   0
#	$(DOS33_RAW) peasant.dsk  19 0 ENDING	  0   0
#	$(DOS33_RAW) peasant.dsk  24 0 PEASANT3	  0   0
	$(DOS33_RAW) peasant.dsk  24 0 ENDING	  0   0
	$(DOS33_RAW) peasant.dsk  29 0 PEASANT4	  0   0

peasant_side2.dsk:	TROGDOR ENDING
	cp $(EMPTY_DISK)/empty.dsk peasant_side2.dsk
	$(DOS33_RAW) peasant_side2.dsk  19 0 TROGDOR	  0   0
	$(DOS33_RAW) peasant_side2.dsk  24 0 ENDING	  0   0


###

#HELLO:	hello.bas
#	$(TOKENIZE) < hello.bas > HELLO

###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s	qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_b00.inc

qload.o:	qload.s qboot.inc
	ca65 -o qload.o qload.s -l qload.lst

###

VID_LOGO:	vid_logo.o
	ld65 -o VID_LOGO vid_logo.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

vid_logo.o:	vid_logo.s decompress_fast_v2.s hgr_overlay.s \
		graphics_vid/vid_graphics.inc
	ca65 -o vid_logo.o vid_logo.s -l vid_logo.lst

###

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

title.o:	title.s \
		graphics_title/title_graphics.inc \
		graphics_title/altfire.inc \
		directions.s
	ca65 -o title.o title.s -l title.lst

###

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

intro.o:	intro.s zp.inc \
		graphics/graphics_intro.inc sprites/peasant_sprite.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_7x28_sprite.s hgr_1x5_sprite.s hgr_save_restore.s \
		hgr_partial_save.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		title.s directions.s \
		intro_cottage.s intro_lake_w.s intro_lake_e.s \
		intro_river.s intro_knight.s
	ca65 -o intro.o intro.s -l intro.lst

###

PEASANT1:	peasant1.o
	ld65 -o PEASANT1 peasant1.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant1.o:	peasant1.s zp.inc \
		graphics/graphics_peasant1.inc sprites/peasant_sprite.inc \
		graphics/priority_peasant1.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_7x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o peasant1.o peasant1.s -l peasant1.lst

###

PEASANT2:	peasant2.o
	ld65 -o PEASANT2 peasant2.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant2.o:	peasant2.s zp.inc \
		graphics/graphics_peasant2.inc sprites/peasant_sprite.inc \
		graphics/priority_peasant2.inc \
		sprites/inventory_sprites.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_7x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s inventory.s

	ca65 -o peasant2.o peasant2.s -l peasant2.lst

###

PEASANT3:	peasant3.o
	ld65 -o PEASANT3 peasant3.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant3.o:	peasant3.s zp.inc \
		graphics/graphics_peasant3.inc sprites/peasant_sprite.inc \
		graphics/priority_peasant3.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_7x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s
	ca65 -o peasant3.o peasant3.s -l peasant3.lst

###

PEASANT4:	peasant4.o
	ld65 -o PEASANT4 peasant4.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant4.o:	peasant4.s zp.inc \
		graphics/graphics_peasant4.inc sprites/peasant_sprite.inc \
		graphics/priority_peasant4.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_7x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
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
		hgr_7x28_sprite_mask.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s hgr_text_box.s \
		keyboard.s parse_input.s new_map_location.s \
		peasant_move.s score.s inventory.s

	ca65 -o trogdor.o trogdor.s -l trogdor.lst

###

ENDING:	ending.o
	ld65 -o ENDING ending.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

ending.o:	ending.s zp.inc \
		graphics_end/ending_graphics.inc sprites/peasant_sprite.inc \
		sprites/ending_sprites.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_14x14_sprite_mask.s hgr_1x5_sprite.s \
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

FONT_TEST:	font_test.o
	ld65 -o FONT_TEST font_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_test.o:	font_test.s hgr_font.s hgr_1x8_sprite.s
	ca65 -o font_test.o font_test.s -l font_test.lst


####

graphics_vid/vid_graphics.inc:
	cd graphics_vid && make

graphics_title/title_graphics.inc:
	cd graphics_title && make


graphics/graphics_peasant1.inc:
	cd graphics && make

graphics_copy/copy_graphics.inc:
	cd graphics_copy && make

graphics_trogdor/trogdor_graphics.inc:
	cd graphics_trogdor && make

graphics_end/ending_graphics.inc:
	cd graphics_end && make


sprites/inventory_sprites.inc:
	cd sprites && make

sprites/trogdor_sprites.inc:
	cd sprites && make

###

clean:	
	rm -f *~ *.o *.lst HELLO VID_LOGO TITLE INTRO COPY_CHECK \
			PEASANT1 PEASANT2 PEASANT3 PEASANT4 \
			TROGDOR ENDING

