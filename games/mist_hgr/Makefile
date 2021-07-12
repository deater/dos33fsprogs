include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
B2D = ../../utils/bmp2dhr/b2d
EMPTY_DISK = ../../empty_disk/empty.dsk

TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft


all:	mist_hgr.dsk
# mist_side2.dsk mist_side3.dsk

#zip:	mist_hgr.dsk mist_side2.dsk mist_side3.dsk
#	zip mist.zip mist_hgr.dsk mist_side2.dsk mist_side3.dsk

mist_hgr.dsk:	QBOOT TEXT_TITLE QLOAD \
		MIST_TITLE
#MIST OCTAGON VIEWER \
#		DENTIST D\'NI SHIP GENERATOR \
#		SAVE1 SAVE2 SAVE3 SAVE4 SAVE5
	cp $(EMPTY_DISK) mist_hgr.dsk
	$(DOS33_RAW) mist_hgr.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) mist_hgr.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) mist_hgr.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) mist_hgr.dsk  0  6 TEXT_TITLE 0   3
#	$(DOS33_RAW) mist_hgr.dsk  0 11 SAVE1      0   1
#	$(DOS33_RAW) mist_hgr.dsk  0 12 SAVE2      0   1
#	$(DOS33_RAW) mist_hgr.dsk  0 13 SAVE3      0   1
#	$(DOS33_RAW) mist_hgr.dsk  0 14 SAVE4      0   1
#	$(DOS33_RAW) mist_hgr.dsk  0 15 SAVE5      0   1
	$(DOS33_RAW) mist_hgr.dsk  1  0 QLOAD      0  14
	$(DOS33_RAW) mist_hgr.dsk  2  0 MIST_TITLE 0  0
# 84
#	$(DOS33_RAW) mist_hgr.dsk  8  0 MIST       0 159
#	$(DOS33_RAW) mist_hgr.dsk 18  0 OCTAGON    0 128
#	$(DOS33_RAW) mist_hgr.dsk 26  0 DENTIST    0  31
#	$(DOS33_RAW) mist_hgr.dsk 28  0 D\'NI      0  27
#	$(DOS33_RAW) mist_hgr.dsk 30  0 SHIP       0  20
#	$(DOS33_RAW) mist_hgr.dsk 31  8 VIEWER     0  20
#	$(DOS33_RAW) mist_hgr.dsk 32 13 GENERATOR  0  33


#mist_side2.dsk:	WBOOT2 CHANNEL ARBOR NIBEL CABIN
#	cp extra_empty.dsk mist_side2.dsk
#	$(DOS33_RAW) mist_side2.dsk  0 0 WBOOT2	 0   1
#	$(DOS33_RAW) mist_side2.dsk  1 0 CHANNEL 0 135
#	$(DOS33_RAW) mist_side2.dsk 10 0 ARBOR   0 159
#	$(DOS33_RAW) mist_side2.dsk 20 0 NIBEL   0 109
#	$(DOS33_RAW) mist_side2.dsk 27 0 CABIN   0  61

#mist_side3.dsk:	WBOOT3 MECHE SELENA STONEY SUB
#	cp extra_empty.dsk mist_side3.dsk
#	$(DOS33_RAW) mist_side3.dsk  0 0 WBOOT3	 0   1
#	$(DOS33_RAW) mist_side3.dsk  1 0 MECHE   0 157
#	$(DOS33_RAW) mist_side3.dsk 11 0 STONEY  0 158
#	$(DOS33_RAW) mist_side3.dsk 21 0 SELENA  0 145
#	$(DOS33_RAW) mist_side3.dsk 30 1 SUB     0  78

###

#WBOOT2:	wrong_boot2.o
#	ld65 -o WBOOT2 wrong_boot2.o -C ../../linker_scripts/apple2_800.inc

#wrong_boot2.o:	wrong_boot2.s
#	ca65 -o wrong_boot2.o wrong_boot2.s -l wrong_boot2.lst

###

#WBOOT3:	wrong_boot3.o
#	ld65 -o WBOOT3 wrong_boot3.o -C ../../linker_scripts/apple2_800.inc

#wrong_boot3.o:	wrong_boot3.s
#	ca65 -o wrong_boot3.o wrong_boot3.s -l wrong_boot3.lst


###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C ../../linker_scripts/apple2_800.inc

qboot_sector.o:	qboot_sector.s qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

TEXT_TITLE:	text_title.o
	ld65 -o TEXT_TITLE text_title.o -C ../../linker_scripts/apple2_800.inc

text_title.o:	text_title.s text_print.s wait_a_bit.s
	ca65 -o text_title.o text_title.s -l text_title.lst


###

QLOAD: qload.o
	ld65 -o QLOAD qload.o -C ../../linker_scripts/apple2_1200.inc

qload.o:	qload.s qboot.inc \
	gr_offsets.s hgr_14x14_sprite.s common_sprites.inc \
	text_print.s gr_fast_clear.s decompress_fast_v2.s \
	keyboard.s audio.s loadstore.s \
	qkumba_popwr.s
	ca65 -o qload.o qload.s -l qload.lst


###

LOADER: loader.o
	ld65 -o LOADER loader.o -C ../../linker_scripts/apple2_1000.inc

loader.o:	loader.s \
	gr_offsets.s \
	text_print.s gr_fast_clear.s decompress_fast_v2.s \
	keyboard.s draw_pointer.s end_level.s audio.s loadstore.s \
	qkumba_popwr.s
	ca65 -o loader.o loader.s -l loader.lst

###

SAVE1: save1.o
	ld65 -o SAVE1 save1.o -C ../../linker_scripts/apple2_e00.inc

save1.o:	save1.s
	ca65 -o save1.o save1.s -l save1.lst

###

SAVE2: save2.o
	ld65 -o SAVE2 save2.o -C ../../linker_scripts/apple2_e00.inc

save2.o:	save2.s
	ca65 -o save2.o save2.s -l save2.lst

###

SAVE3: save3.o
	ld65 -o SAVE3 save3.o -C ../../linker_scripts/apple2_e00.inc

save3.o:	save3.s
	ca65 -o save3.o save3.s -l save3.lst

###

SAVE4: save4.o
	ld65 -o SAVE4 save4.o -C ../../linker_scripts/apple2_e00.inc

save4.o:	save4.s
	ca65 -o save4.o save4.s -l save4.lst

###

SAVE5: save5.o
	ld65 -o SAVE5 save5.o -C ../../linker_scripts/apple2_e00.inc

save5.o:	save5.s
	ca65 -o save5.o save5.s -l save5.lst

####

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

####

common_routines.inc:	qload.lst generate_common
	./generate_common > common_routines.inc

####

MIST_TITLE:	mist_title.o
	ld65 -o MIST_TITLE mist_title.o -C ../../linker_scripts/apple2_4000.inc

mist_title.o:	mist_title.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_title_hgr/mist_title.lzsa graphics_title/title_graphics.inc \
	gr_offsets.s \
	text_print.s gr_fast_clear.s decompress_fast_v2.s \
	keyboard.s audio.s \
	init_state.s wait_a_bit.s \
	link_book_mist_dock.s common_sprites.inc leveldata_title.inc \
	pt3_lib_core.s pt3_lib_init.s pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s pt3_lib_irq_handler.s interrupt_handler.s
	ca65 -o mist_title.o mist_title.s -l mist_title.lst

####

MIST:	mist.o
	ld65 -o MIST mist.o -C ./apple2_2000.inc

mist.o:	mist.s zp.inc hardware.inc common_defines.inc common_routines.inc \
	graphics_mist/mist_graphics.inc \
	common_sprites.inc \
	leveldata_mist.inc \
	clock_bridge_puzzle.s clock_sprites.inc \
	marker_switch.s \
	keyboard.s \
	draw_pointer.s \
	end_level.s \
	mist_puzzles.s \
	handle_pages.s
	ca65 -o mist.o mist.s -l mist.lst

####

GENERATOR:	generator.o
	ld65 -o GENERATOR generator.o -C ./apple2_2000.inc

generator.o:	generator.s zp.inc hardware.inc \
	common_defines.inc common_routines.inc \
	graphics_generator/generator_graphics.inc \
	leveldata_generator.inc \
	generator_puzzle.s
	ca65 -o generator.o generator.s -l generator.lst


####

OCTAGON:	octagon.o
	ld65 -o OCTAGON octagon.o -C ./apple2_2000.inc

octagon.o:	octagon.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_octagon/octagon_graphics.inc \
	books/octagon_books.inc \
	common_sprites.inc page_sprites.inc \
	leveldata_octagon.inc \
	brother_books.s \
	handle_pages.s \
	octagon_bookshelf.s \
	octagon_rotation.s \
	octagon_fireplace.s
	ca65 -o octagon.o octagon.s -l octagon.lst

####

D\'NI:	dni.o
	ld65 -o D\'NI dni.o -C ./apple2_2000.inc

dni.o:	dni.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_dni/dni_graphics.inc \
	leveldata_dni.inc \
	dni_ending.s
	ca65 -o dni.o dni.s -l dni.lst



####

MECHE:	meche.o
	ld65 -o MECHE meche.o -C ./apple2_2000.inc

meche.o:	meche.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_meche/meche_graphics.inc \
	common_sprites.inc \
	page_sprites.inc \
	leveldata_meche.inc \
	link_book_meche.s \
	link_book_mist.s \
	meche_rotation.s \
	handle_pages.s \
	keyboard.s \
	draw_pointer.s \
	audio.s text_print.s decompress_fast_v2.s
	ca65 -o meche.o meche.s -l meche.lst

####

SELENA:	selena.o
	ld65 -o SELENA selena.o -C ./apple2_2000.inc

selena.o:	selena.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_selena/selena_graphics.inc \
	common_sprites.inc \
	leveldata_selena.inc \
	link_book_mist.s \
	end_level.s \
	keyboard.s \
	draw_pointer.s \
	speaker_beeps.s \
	selena_organ_puzzle.s selena_sound_puzzle.s \
	audio.s text_print.s decompress_fast_v2.s
	ca65 -o selena.o selena.s -l selena.lst

####

SUB:	sub.o
	ld65 -o SUB sub.o -C ./apple2_2000.inc

sub.o:	sub.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_sub/sub_graphics.inc \
	common_sprites.inc \
	leveldata_sub.inc \
	link_book_mist.s \
	end_level.s \
	keyboard.s \
	draw_pointer.s \
	sub_puzzle.s \
	audio.s text_print.s decompress_fast_v2.s
	ca65 -o sub.o sub.s -l sub.lst

####

VIEWER:	viewer.o
	ld65 -o VIEWER viewer.o -C ./apple2_2000.inc

viewer.o:	viewer.s zp.inc hardware.inc common_defines.inc \
	graphics_viewer/viewer_graphics.inc \
	common_routines.inc \
	common_sprites.inc \
	page_sprites.inc \
	number_sprites.inc \
	leveldata_viewer.inc \
	viewer_controls.s \
	keyboard.s \
	draw_pointer.s \
	audio.s text_print.s decompress_fast_v2.s
	ca65 -o viewer.o viewer.s -l viewer.lst

####

STONEY:	stoney.o
	ld65 -o STONEY stoney.o -C ./apple2_2000.inc

stoney.o:	stoney.s zp.inc hardware.inc common_defines.inc \
	graphics_stoney/stoney_graphics.inc \
	common_routines.inc \
	common_sprites.inc \
	page_sprites.inc \
	leveldata_stoney.inc \
	keyboard.s \
	draw_pointer.s \
	link_book_stoney.s \
	link_book_mist.s \
	handle_pages.s \
	hlin_list.s \
	lights_off.s stoney_puzzles.s
	ca65 -o stoney.o stoney.s -l stoney.lst

####

SHIP:	ship.o
	ld65 -o SHIP ship.o -C ./apple2_2000.inc

ship.o:	ship.s zp.inc hardware.inc common_defines.inc \
	graphics_ship/ship_graphics.inc \
	common_routines.inc \
	common_sprites.inc \
	page_sprites.inc \
	leveldata_ship.inc \
	keyboard.s \
	draw_pointer.s \
	link_book_stoney.s \
	link_book_mist.s \
	handle_pages.s \
	audio.s text_print.s decompress_fast_v2.s
	ca65 -o ship.o ship.s -l ship.lst

####

CABIN:	cabin.o
	ld65 -o CABIN cabin.o -C ./apple2_2000.inc

cabin.o:	cabin.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_cabin/cabin_graphics.inc \
	common_sprites.inc \
	page_sprites.inc \
	leveldata_cabin.inc \
	keyboard.s \
	draw_pointer.s \
	link_book_channel.s \
	marker_switch.s \
	cabin_boiler_puzzle.s \
	number_sprites.inc
	ca65 -o cabin.o cabin.s -l cabin.lst


####

CHANNEL:	channel.o
	ld65 -o CHANNEL channel.o -C ./apple2_2000.inc

channel.o:	channel.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_channel/channel_graphics.inc \
	common_sprites.inc \
	page_sprites.inc \
	leveldata_channel.inc \
	channel_switches.s \
	keyboard.s \
	draw_pointer.s \
	link_book_channel.s \
	link_book_mist.s \
	audio.s text_print.s decompress_fast_v2.s
	ca65 -o channel.o channel.s -l channel.lst

####

ARBOR:	arbor.o
	ld65 -o ARBOR arbor.o -C ./apple2_2000.inc

arbor.o:	arbor.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_arbor/arbor_graphics.inc \
	leveldata_arbor.inc \
	arbor_switches.s
	ca65 -o arbor.o arbor.s -l arbor.lst

####

NIBEL:	nibel.o
	ld65 -o NIBEL nibel.o -C ./apple2_2000.inc

nibel.o:	nibel.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_nibel/nibel_graphics.inc \
	leveldata_nibel.inc \
	handle_pages.s nibel_switches.s
	ca65 -o nibel.o nibel.s -l nibel.lst

####

DENTIST:	dentist.o
	ld65 -o DENTIST dentist.o -C ./apple2_2000.inc

dentist.o:	dentist.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_dentist/dentist_graphics.inc \
	leveldata_dentist.inc \
	dentist_panel.s \
	marker_switch.s
	ca65 -o dentist.o dentist.s -l dentist.lst


####

graphics_title/title_graphics.inc:
	cd graphics_title && make

graphics_mist/mist_graphics.inc:
	cd graphics_mist && make

graphics_octagon/octagon_graphics.inc:
	cd graphics_octagon && make

books/octagon_books.inc:
	cd books && make

graphics_viewer/viewer_graphics.inc:
	cd graphics_viewer && make

graphics_meche/meche_graphics.inc:
	cd graphics_meche && make

graphics_selena/selena_graphics.inc:
	cd graphics_selena && make

graphics_cabin/cabin_graphics.inc:
	cd graphics_cabin && make

graphics_channel/channel_graphics.inc:
	cd graphics_channel && make

graphics_stoney/stoney_graphics.inc:
	cd graphics_stoney && make

graphics_dentist/dentist_graphics.inc:
	cd graphics_dentist && make

graphics_generator/generator_graphics.inc:
	cd graphics_generator && make

graphics_arbor/arbor_graphics.inc:
	cd graphics_arbor && make

graphics_nibel/nibel_graphics.inc:
	cd graphics_nibel && make

graphics_dni/dni_graphics.inc:
	cd graphics_dni && make

graphics_ship/ship_graphics.inc:
	cd graphics_ship && make

graphics_sub/sub_graphics.inc:
	cd graphics_sub && make


####

clean:		
	rm -f *~ *.o *.lst HELLO HELLO_DISK2 \
			LOADER MIST_TITLE \
			MIST OCTAGON VIEWER DENTIST \
			MECHE SELENA SHIP STONEY CHANNEL ARBOR NIBEL \
			GENERATOR \
			generate_common
	cd graphics_title && make clean
#	cd graphics_mist && make clean
#	cd graphics_octagon && make clean
#	cd books && make clean
#	cd graphics_viewer && make clean
#	cd graphics_meche && make clean
#	cd graphics_selena && make clean
#	cd graphics_cabin && make clean
#	cd graphics_channel && make clean
#	cd graphics_stoney && make clean
#	cd graphics_dentist && make clean
#	cd graphics_generator && make clean
#	cd graphics_arbor && make clean
#	cd graphics_nibel && make clean
#	cd graphics_dni && make clean
#	cd graphics_ship && make clean
#	cd graphics_sub && make clean

