include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK04 LEVEL_TUNNEL3

####

DISK04:	disk04.o
	ld65 -o DISK04 disk04.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk04.o:	disk04.s ../zp.inc
	ca65 -o disk04.o disk04.s -l disk04.lst

####

LEVEL_TUNNEL3:	level_tunnel3.o
	ld65 -o LEVEL_TUNNEL3 level_tunnel3.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_tunnel3.o:	level_tunnel3.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk04_defines.inc \
		leveldata_tunnel3.inc \
		graphics_tunnel3/tunnel3_graphics.inc
	ca65 -o level_tunnel3.o level_tunnel3.s -l level_tunnel3.lst

####

graphics_tunnel3/tunnel3_graphics.inc:
	cd graphics_tunnel3 && make

####

clean:		
	rm -f *~ *.o *.lst DISK04 \
		LEVEL_TUNNEL3

####

distclean:
	rm -f *~ *.o *.lst DISK04 \
		LEVEL_TUNNEL3
	cd graphics_tunnel3 && make clean



