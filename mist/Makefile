include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	mist.dsk mist_side2.dsk

zip:	mist.dsk mist_side2.dsk
	zip mist.zip mist.dsk mist_side2.dsk

mist.dsk:	HELLO LOADER MIST_TITLE MIST OCTAGON VIEWER \
		MECHE SELENA CHANNEL STONEY
	cp empty.dsk mist.dsk
	$(DOS33) -y mist.dsk SAVE A HELLO
	$(DOS33) -y mist.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y mist.dsk BSAVE -a 0x4000 MIST_TITLE
	$(DOS33) -y mist.dsk BSAVE -a 0x2000 MIST
	$(DOS33) -y mist.dsk BSAVE -a 0x2000 OCTAGON
#	$(DOS33) -y mist.dsk BSAVE -a 0x2000 MECHE
#	$(DOS33) -y mist.dsk BSAVE -a 0x2000 SELENA
#	$(DOS33) -y mist.dsk BSAVE -a 0x2000 CHANNEL
#	$(DOS33) -y mist.dsk BSAVE -a 0x2000 VIEWER
	$(DOS33) -y mist.dsk BSAVE -a 0x2000 STONEY
	$(DOS33) -y mist.dsk BSAVE -a 0x9000 ./audio/link_noise.btc LINK_NOISE.BTC

mist_side2.dsk:	MECHE SELENA CHANNEL VIEWER
	cp empty.dsk mist_side2.dsk
	$(DOS33) -y mist_side2.dsk BSAVE -a 0x2000 MECHE
	$(DOS33) -y mist_side2.dsk BSAVE -a 0x2000 SELENA
	$(DOS33) -y mist_side2.dsk BSAVE -a 0x2000 CHANNEL
	$(DOS33) -y mist_side2.dsk BSAVE -a 0x2000 VIEWER
	$(DOS33) -y mist_side2.dsk BSAVE -a 0x9000 ./audio/link_noise.btc LINK_NOISE.BTC

###

LOADER: loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1000.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst


###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

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
	letter_cat.s \
	marker_switch.s \
	keyboard.s \
	draw_pointer.s \
	end_level.s \
	generator_puzzle.s \
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o mist.o mist.s -l mist.lst

####

OCTAGON:	octagon.o
	ld65 -o OCTAGON octagon.o -C ../linker_scripts/apple2_2000.inc

octagon.o:	octagon.s zp.inc hardware.inc common_defines.inc \
	common_routines.inc \
	graphics_octagon/octagon_graphics.inc \
	books/octagon_books.inc \
	common_sprites.inc page_sprites.inc \
	leveldata_octagon.inc \
	letter_cat.s \
	marker_switch.s \
	brother_books.s \
	keyboard.s \
	draw_pointer.s \
	end_level.s \
	handle_pages.s \
	octagon_bookshelf.s \
	octagon_rotation.s \
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o octagon.o octagon.s -l octagon.lst


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
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o stoney.o stoney.s -l stoney.lst

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

graphics_island/mist_graphics.inc:
	cd graphics_island && make


####

clean:		
		rm -f *~ *.o *.lst HELLO LOADER MIST_TITLE \
			MIST OCTAGON \
			MECHE SELENA STONEY CHANNEL
