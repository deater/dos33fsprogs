include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	TITLE

###

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

title.o:	title.s ../qload.inc \
		../music/music.inc ../music/duet.s \
		graphics_title/title_graphics.inc \
		graphics_title/altfire.inc \
		sprites_title/title_sprites.inc \
		tips.s title_mockingboard.s title_duet.s \
		../pt3_lib/pt3_lib_mockingboard_patch.s
	ca65 -o title.o title.s -l title.lst

###

graphics_title/title_graphics.inc:
	cd graphics_title && make

sprites_title/title_sprites.inc:
	cd sprites_title && make

###

distclean:
	make clean
	cd sprites_title && make clean
	cd graphics_title && make clean

###

clean:	
	rm -f *~ *.o *.lst TITLE
