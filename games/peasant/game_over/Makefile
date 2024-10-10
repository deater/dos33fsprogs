include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	GAME_OVER

###

GAME_OVER:	game_over.o
	ld65 -o GAME_OVER game_over.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

game_over.o:	game_over.s \
		../hardware.inc ../zp.inc ../qload.inc \
		graphics_over/game_over_graphics.inc \
		graphics_over/game_over_animation.inc \
		../hgr_sprite.s \
		../wait_a_bit.s ../wait.s
	ca65 -o game_over.o game_over.s -l game_over.lst

###

graphics_over/game_over_graphics.inc:
	cd graphics_over && make

###

distclean:
	make clean
	cd graphics_over && make clean

###

clean:	
	rm -f *~ *.o *.lst GAME_OVER
