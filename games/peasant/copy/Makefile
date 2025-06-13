include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	COPY_CHECK

###

COPY_CHECK:	copy_check.o
	ld65 -o COPY_CHECK copy_check.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

copy_check.o:	copy_check.s graphics_copy/copy_graphics.inc \
		../hgr_routines/hgr_input.s \
		../hgr_routines/hgr_draw_box.s \
		../hgr_routines/hgr_rectangle.s \
		../hgr_routines/hgr_font.s \
		copy_check.s
	ca65 -o copy_check.o copy_check.s -l copy_check.lst

###

graphics_copy/copy_graphics.inc:
	cd graphics_copy && make

###

distclean:
	make clean
	cd graphics_copy && make clean

###

clean:	
	rm -f *~ *.o *.lst COPY_CHECK
