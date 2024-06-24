include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK41 LEVEL_TUNNEL LEVEL_STAIRS LEVEL_COVE

###

DISK41:	disk41.o
	ld65 -o DISK41 disk41.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk41.o:	disk41.s ../zp.inc
	ca65 -o disk41.o disk41.s -l disk41.lst

####

LEVEL_TUNNEL:	level_tunnel.o
	ld65 -o LEVEL_TUNNEL level_tunnel.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_tunnel.o:	level_tunnel.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk41_defines.inc \
		leveldata_tunnel.inc \
		graphics_tunnel/tunnel_graphics.inc
	ca65 -o level_tunnel.o level_tunnel.s -l level_tunnel.lst

####

LEVEL_STAIRS:	level_stairs.o
	ld65 -o LEVEL_STAIRS level_stairs.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_stairs.o:	level_stairs.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk41_defines.inc \
		leveldata_stairs.inc \
		graphics_stairs/stairs_graphics.inc
	ca65 -o level_stairs.o level_stairs.s -l level_stairs.lst

####

LEVEL_COVE:	level_cove.o
	ld65 -o LEVEL_COVE level_cove.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_cove.o:	level_cove.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk41_defines.inc \
		leveldata_cove.inc \
		graphics_cove/cove_graphics.inc
	ca65 -o level_cove.o level_cove.s -l level_cove.lst



####

graphics_tunnel/tunnel_graphics.inc:
	cd graphics_tunnel && make

graphics_stairs/stairs_graphics.inc:
	cd graphics_stairs && make

graphics_cove/cove_graphics.inc:
	cd graphics_cove && make

####

clean:		
	rm -f *~ *.o *.lst \
		DISK41 LEVEL_TUNNEL LEVEL_STAIRS LEVEL_COVE


####

distclean:
	rm -f *~ *.o *.lst \
		DISK41 LEVEL_TUNNEL LEVEL_STAIRS LEVEL_COVE
	cd graphics_tunnel && make clean
	cd graphics_stairs && make clean
	cd graphics_cove && make clean

