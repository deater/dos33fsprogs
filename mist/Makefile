include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	mist.dsk mist_side2.dsk mist_side3.dsk

zip:	mist.dsk mist_side2.dsk mist_side3.dsk
	zip mist.zip mist.dsk mist_side2.dsk mist_side3.dsk

mist.dsk:	HELLO LOADER MIST_TITLE MIST OCTAGON VIEWER \
		MECHE SELENA CABIN CHANNEL STONEY DENTIST \
		D\'NI SAVE0 SHIP
	cp empty.dsk mist.dsk
	$(DOS33) -y mist.dsk SAVE A HELLO
	$(DOS33) -y mist.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y mist.dsk BSAVE -a 0x4000 MIST_TITLE
	$(DOS33) -y mist.dsk BSAVE -a 0x2000 MIST
	$(DOS33) -y mist.dsk BSAVE -a 0x2000 OCTAGON
	$(DOS33) -y mist.dsk BSAVE -a 0x2000 VIEWER
	$(DOS33) -y mist.dsk BSAVE -a 0x2000 DENTIST
	$(DOS33) -y mist.dsk BSAVE -a 0x2000 D\'NI
	$(DOS33) -y mist.dsk BSAVE -a 0xe00 SAVE0
	$(DOS33) -y mist.dsk BSAVE -a 0x2000 SHIP
	$(DOS33) -y mist.dsk BSAVE -a 0x9000 ./audio/link_noise.btc LINK_NOISE.BTC

mist_side2.dsk:	HELLO_DISK2 CHANNEL ARBOR NIBEL CABIN
	cp empty.dsk mist_side2.dsk
	$(DOS33) -y mist_side2.dsk SAVE A HELLO_DISK2 HELLO
	$(DOS33) -y mist_side2.dsk BSAVE -a 0x2000 CHANNEL
	$(DOS33) -y mist_side2.dsk BSAVE -a 0x2000 ARBOR
	$(DOS33) -y mist_side2.dsk BSAVE -a 0x2000 NIBEL
	$(DOS33) -y mist_side2.dsk BSAVE -a 0x2000 CABIN



mist_side3.dsk:	HELLO_DISK2 MECHE SELENA STONEY GENERATOR
	cp empty.dsk mist_side3.dsk
	$(DOS33) -y mist_side3.dsk SAVE A HELLO_DISK2 HELLO
	$(DOS33) -y mist_side3.dsk BSAVE -a 0x2000 MECHE
	$(DOS33) -y mist_side3.dsk BSAVE -a 0x2000 SELENA
	$(DOS33) -y mist_side3.dsk BSAVE -a 0x2000 STONEY
	$(DOS33) -y mist_side3.dsk BSAVE -a 0x2000 GENERATOR


###

LOADER: loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1000.inc

loader.o:	loader.s \
	gr_copy.s gr_offsets.s gr_pageflip.s gr_putsprite_crop.s \
	text_print.s gr_fast_clear.s decompress_fast_v2.s \
	keyboard.s draw_pointer.s end_level.s audio.s loadstore.s
	ca65 -o loader.o loader.s -l loader.lst

###

SAVE0: default_save.o
	ld65 -o SAVE0 default_save.o -C ../linker_scripts/apple2_e00.inc

default_save.o:	default_save.s
	ca65 -o default_save.o default_save.s -l default_save.lst


###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

HELLO_DISK2:	hello_disk2.bas
	../asoft_basic-utils/tokenize_asoft < hello_disk2.bas > HELLO_DISK2

####

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

####

common_routines.inc:	loader.lst generate_common
	./generate_common > common_routines.inc

####

MIST_TITLE:	mist_title.o
	ld65 -o MIST_TITLE mist_title.o -C ../linker_scripts/apple2_4000.inc

mist_title.o:	mist_title.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_title/mist_title.lzsa graphics_title/title_graphics.inc \
	gr_copy.s gr_offsets.s gr_pageflip.s gr_putsprite_crop.s \
	text_print.s gr_fast_clear.s decompress_fast_v2.s \
	keyboard.s draw_pointer.s end_level.s audio.s \
	init_state.s \
	link_book_mist_dock.s common_sprites.inc leveldata_title.inc
	ca65 -o mist_title.o mist_title.s -l mist_title.lst

####

MIST:	mist.o
	ld65 -o MIST mist.o -C ../linker_scripts/apple2_2000.inc

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
	ld65 -o GENERATOR generator.o -C ../linker_scripts/apple2_2000.inc

generator.o:	generator.s zp.inc hardware.inc \
	common_defines.inc common_routines.inc \
	graphics_generator/generator_graphics.inc \
	leveldata_generator.inc \
	generator_puzzle.s
	ca65 -o generator.o generator.s -l generator.lst


####

OCTAGON:	octagon.o
	ld65 -o OCTAGON octagon.o -C ../linker_scripts/apple2_2000.inc

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
	ld65 -o D\'NI dni.o -C ../linker_scripts/apple2_2000.inc

dni.o:	dni.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_dni/dni_graphics.inc \
	leveldata_dni.inc \
	dni_ending.s
	ca65 -o dni.o dni.s -l dni.lst



####

MECHE:	meche.o
	ld65 -o MECHE meche.o -C ../linker_scripts/apple2_2000.inc

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
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o meche.o meche.s -l meche.lst

####

SELENA:	selena.o
	ld65 -o SELENA selena.o -C ../linker_scripts/apple2_2000.inc

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
	organ_puzzle.s \
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o selena.o selena.s -l selena.lst


####

VIEWER:	viewer.o
	ld65 -o VIEWER viewer.o -C ../linker_scripts/apple2_2000.inc

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
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o viewer.o viewer.s -l viewer.lst

####

STONEY:	stoney.o
	ld65 -o STONEY stoney.o -C ../linker_scripts/apple2_2000.inc

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
	stoney_puzzles.s
	ca65 -o stoney.o stoney.s -l stoney.lst

####

SHIP:	ship.o
	ld65 -o SHIP ship.o -C ../linker_scripts/apple2_2000.inc

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
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o ship.o ship.s -l ship.lst

####

CABIN:	cabin.o
	ld65 -o CABIN cabin.o -C ../linker_scripts/apple2_2000.inc

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
	ld65 -o CHANNEL channel.o -C ../linker_scripts/apple2_2000.inc

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
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o channel.o channel.s -l channel.lst

####

ARBOR:	arbor.o
	ld65 -o ARBOR arbor.o -C ../linker_scripts/apple2_2000.inc

arbor.o:	arbor.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_arbor/arbor_graphics.inc \
	leveldata_arbor.inc \
	arbor_switches.s
	ca65 -o arbor.o arbor.s -l arbor.lst

####

NIBEL:	nibel.o
	ld65 -o NIBEL nibel.o -C ../linker_scripts/apple2_2000.inc

nibel.o:	nibel.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_nibel/nibel_graphics.inc \
	leveldata_nibel.inc \
	handle_pages.s nibel_switches.s
	ca65 -o nibel.o nibel.s -l nibel.lst

####

DENTIST:	dentist.o
	ld65 -o DENTIST dentist.o -C ../linker_scripts/apple2_2000.inc

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


####

clean:		
	rm -f *~ *.o *.lst HELLO HELLO_DISK2 \
			LOADER MIST_TITLE \
			MIST OCTAGON VIEWER DENTIST \
			MECHE SELENA SHIP STONEY CHANNEL ARBOR NIBEL \
			GENERATOR \
			generate_common
	cd graphics_title && make clean
	cd graphics_mist && make clean
	cd graphics_octagon && make clean
	cd books && make clean
	cd graphics_viewer && make clean
	cd graphics_meche && make clean
	cd graphics_selena && make clean
	cd graphics_cabin && make clean
	cd graphics_channel && make clean
	cd graphics_stoney && make clean
	cd graphics_dentist && make clean
	cd graphics_generator && make clean
	cd graphics_arbor && make clean
	cd graphics_nibel && make clean
	cd graphics_dni && make clean
	cd graphics_ship && make clean

