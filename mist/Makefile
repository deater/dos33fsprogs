include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	mist.dsk

mist.dsk:	HELLO LOADER MIST_TITLE MIST MECHE
	cp empty.dsk mist.dsk
	$(DOS33) -y mist.dsk SAVE A HELLO
	$(DOS33) -y mist.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y mist.dsk BSAVE -a 0x4000 MIST_TITLE
	$(DOS33) -y mist.dsk BSAVE -a 0x1400 MIST
	$(DOS33) -y mist.dsk BSAVE -a 0x1400 MECHE

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

mist_title.o:	mist_title.s zp.inc hardware.inc \
	graphics_title/mist_title.lzsa
	ca65 -o mist_title.o mist_title.s -l mist_title.lst

####

MIST:	mist.o
	ld65 -o MIST mist.o -C ../linker_scripts/apple2_1400.inc

mist.o:	mist.s zp.inc hardware.inc \
	graphics_island/mist_graphics.inc \
	common_sprites.inc \
	leveldata_island.inc \
	clock_bridge_puzzle.s clock_sprites.inc \
	link_book_mist.s \
	letter_cat.s \
	marker_switch.s \
	brother_books.s \
	keyboard.s \
	draw_pointer.s \
	end_level.s \
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o mist.o mist.s -l mist.lst

####

MECHE:	meche.o
	ld65 -o MECHE meche.o -C ../linker_scripts/apple2_1400.inc

meche.o:	meche.s zp.inc hardware.inc \
	graphics_meche/meche_graphics.inc \
	common_sprites.inc \
	leveldata_meche.inc \
	link_book_meche.s \
	keyboard.s \
	draw_pointer.s \
	gr_copy.s audio.s text_print.s decompress_fast_v2.s
	ca65 -o meche.o meche.s -l meche.lst


####

graphics_island/mist_graphics.inc:
	cd graphics_island && make


####

clean:		
		rm -f *~ *.o *.lst HELLO LOADER MIST_TITLE MIST MECHE
