include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
B2D = ../../utils/bmp2dhr/b2d
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft


all:	monkey.dsk

monkey.dsk:	HELLO LOADER TITLE MONKEY
	cp empty.dsk monkey.dsk
	$(DOS33) -y monkey.dsk SAVE A HELLO
	$(DOS33) -y monkey.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y monkey.dsk BSAVE -a 0x2000 TITLE
	$(DOS33) -y monkey.dsk BSAVE -a 0x2000 MONKEY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

###

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../../linker_scripts/apple2_1000.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst

###

TITLE:	title.o
	ld65 -o TITLE title.o -C ../../linker_scripts/apple2_2000.inc

title.o:	title.s \
	graphics_intro/title_graphics.inc \
	music/theme.inc \
	interrupt_handler.s mockingboard.s ym_play.s gr_overlay.s
	ca65 -o title.o title.s -l title.lst


####


MONKEY:	monkey.o
	ld65 -o MONKEY monkey.o -C ../../linker_scripts/apple2_2000.inc

monkey.o:	monkey.s zp.inc hardware.inc common_defines.inc \
	graphics/graphics.inc \
	draw_pointer.s \
	common_sprites.inc \
	keyboard.s joystick.s \
	leveldata_monkey.inc \
	monkey_actions.s update_bottom.s \
	guy.brush \
	monkey_lookout.s monkey_poster.s monkey_dock.s monkey_bar.s \
	monkey_town.s monkey_map.s monkey_church.s monkey_mansion_path.s \
	monkey_mansion.s monkey_zipline.s \
	monkey_bar_inside1.s monkey_bar_inside2.s monkey_bar_inside3.s \
	monkey_voodoo1.s monkey_voodoo2.s \
	cutscene_lechuck.s chapter1.s \
	music/chapter.pt3
	ca65 -o monkey.o monkey.s -l monkey.lst

graphics/graphics.inc:
	cd graphics && make

graphics_intro/title_graphics.inc:
	cd graphics_intro && make

music/theme.inc:
	cd music && make

####

clean:		
	rm -f *~ *.o *.lst HELLO MONKEY
	cd graphics && make clean
	cd graphics_intro && make clean
	cd music && make clean


