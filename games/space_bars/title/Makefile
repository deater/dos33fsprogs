include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/

#########

all:	TITLE

#########

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

title.o:	title.s \
	../zp.inc ../hardware.inc ../qload.inc \
	instructions.s \
	../gr_copy.s \
	graphics/sb_title_high.zx02 graphics/sb_title_low.zx02
	ca65 -o title.o title.s -l title.lst

####

graphics/sb_title_high.zx02:	
	cd graphics && make

####

clean:	
		rm -f *~ *.o *.lst TITLE
		cd graphics && make clean


