include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK04 LEVEL_BRIDGE1 LEVEL_BRIDGE2 LEVEL_TUNNEL1 \
	LEVEL_TUNNEL3 LEVEL_TUNNEL4 LEVEL_TUNNEL7

####

DISK04:	disk04.o
	ld65 -o DISK04 disk04.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk04.o:	disk04.s ../zp.inc
	ca65 -o disk04.o disk04.s -l disk04.lst

####

LEVEL_BRIDGE1:	level_bridge1.o
	ld65 -o LEVEL_BRIDGE1 level_bridge1.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_bridge1.o:	level_bridge1.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk04_defines.inc \
		leveldata_bridge1.inc \
		graphics_bridge1/bridge1_graphics.inc
	ca65 -o level_bridge1.o level_bridge1.s -l level_bridge1.lst

####

LEVEL_BRIDGE2:	level_bridge2.o
	ld65 -o LEVEL_BRIDGE2 level_bridge2.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_bridge2.o:	level_bridge2.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk04_defines.inc \
		leveldata_bridge2.inc \
		graphics_bridge2/bridge2_graphics.inc
	ca65 -o level_bridge2.o level_bridge2.s -l level_bridge2.lst


####

LEVEL_TUNNEL1:	level_tunnel1.o
	ld65 -o LEVEL_TUNNEL1 level_tunnel1.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_tunnel1.o:	level_tunnel1.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk04_defines.inc \
		leveldata_tunnel1.inc \
		graphics_tunnel1/tunnel1_graphics.inc
	ca65 -o level_tunnel1.o level_tunnel1.s -l level_tunnel1.lst

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

LEVEL_TUNNEL4:	level_tunnel4.o
	ld65 -o LEVEL_TUNNEL4 level_tunnel4.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_tunnel4.o:	level_tunnel4.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk04_defines.inc \
		leveldata_tunnel4.inc \
		graphics_tunnel4/tunnel4_graphics.inc
	ca65 -o level_tunnel4.o level_tunnel4.s -l level_tunnel4.lst

####

LEVEL_TUNNEL7:	level_tunnel7.o
	ld65 -o LEVEL_TUNNEL7 level_tunnel7.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_tunnel7.o:	level_tunnel7.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk04_defines.inc \
		leveldata_tunnel7.inc \
		graphics_tunnel7/tunnel7_graphics.inc
	ca65 -o level_tunnel7.o level_tunnel7.s -l level_tunnel7.lst



####

graphics_bridge1/bridge1_graphics.inc:
	cd graphics_bridge1 && make

graphics_bridge2/bridge2_graphics.inc:
	cd graphics_bridge2 && make

graphics_tunnel1/tunnel1_graphics.inc:
	cd graphics_tunnel1 && make

graphics_tunnel3/tunnel3_graphics.inc:
	cd graphics_tunnel3 && make

graphics_tunnel4/tunnel4_graphics.inc:
	cd graphics_tunnel4 && make

graphics_tunnel7/tunnel7_graphics.inc:
	cd graphics_tunnel7 && make

####

clean:		
	rm -f *~ *.o *.lst DISK04 \
		LEVEL_BRIDGE1 LEVEL_BRIDGE2 \
		LEVEL_TUNNEL1 LEVEL_TUNNEL3 LEVEL_TUNNEL4 LEVEL_TUNNEL7

####

distclean:
	rm -f *~ *.o *.lst DISK04 \
		LEVEL_BRIDGE1 LEVEL_BRIDGE2 \
		LEVEN_TUNNEL1 LEVEL_TUNNEL3 LEVEL_TUNNEL4 LEVEL_TUNNEL7
	cd graphics_bridge1 && make clean
	cd graphics_bridge2 && make clean
	cd graphics_tunnel1 && make clean
	cd graphics_tunnel3 && make clean
	cd graphics_tunnel4 && make clean
	cd graphics_tunnel7 && make clean
