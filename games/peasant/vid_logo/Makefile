include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	VID_LOGO

###

VID_LOGO:	vid_logo.o
	ld65 -o VID_LOGO vid_logo.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

vid_logo.o:	vid_logo.s ../qload.inc \
		../hgr_routines/hgr_overlay.s ../redbook_sound.s \
		../init_vars.s \
		graphics_vid/vid_graphics.inc
	ca65 -o vid_logo.o vid_logo.s -l vid_logo.lst


graphics_vid/vid_graphics.inc:
	cd graphics_vid && make

distclean:
	make clean
	cd graphics_vid && make clean

###

clean:	
	rm -f *~ *.o *.lst VID_LOGO

