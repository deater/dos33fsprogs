include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
DOS33_RAW = ../dos33fs-utils/dos33_raw
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	monkey.dsk

monkey.dsk:	HELLO LOADER TITLE MONKEY
	cp empty.dsk monkey.dsk
	$(DOS33) -y monkey.dsk SAVE A HELLO
	$(DOS33) -y monkey.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y monkey.dsk BSAVE -a 0x2000 TITLE
	$(DOS33) -y monkey.dsk BSAVE -a 0x2000 MONKEY

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

###

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1000.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst

###

TITLE:	title.o
	ld65 -o TITLE title.o -C ../linker_scripts/apple2_2000.inc

title.o:	title.s
	ca65 -o title.o title.s -l title.lst


####


MONKEY:	monkey.o
	ld65 -o MONKEY monkey.o -C ../linker_scripts/apple2_2000.inc

monkey.o:	monkey.s zp.inc hardware.inc common_defines.inc \
	graphics/graphics.inc \
	draw_pointer.s \
	common_sprites.inc \
	keyboard.s joystick.s \
	leveldata_monkey.inc \
	monkey_actions.s update_bottom.s \
	guy.brush
	ca65 -o monkey.o monkey.s -l monkey.lst

graphics/graphics.inc:
	cd graphics && make

####

clean:		
	rm -f *~ *.o *.lst HELLO MONKEY
	cd graphics && make clean

