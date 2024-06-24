include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK41 LEVEL_TUNNEL LEVEL_STAIRS LEVEL_COVE LEVEL_STAIRS2 \
	MOVIE_COVE

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

LEVEL_STAIRS2:	level_stairs2.o
	ld65 -o LEVEL_STAIRS2 level_stairs2.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_stairs2.o:	level_stairs2.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk41_defines.inc \
		leveldata_stairs2.inc \
		graphics_stairs2/stairs2_graphics.inc
	ca65 -o level_stairs2.o level_stairs2.s -l level_stairs2.lst


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

####

MOVIE_COVE:	movie_cove.o
	ld65 -o MOVIE_COVE movie_cove.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

movie_cove.o:	movie_cove.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../common_defines.inc disk41_defines.inc \
	movie_cove/combined_cove.zx02
	ca65 -o movie_cove.o movie_cove.s -l movie_cove.lst


####

graphics_tunnel/tunnel_graphics.inc:
	cd graphics_tunnel && make

graphics_stairs/stairs_graphics.inc:
	cd graphics_stairs && make

graphics_stairs2/stairs2_graphics.inc:
	cd graphics_stairs2 && make

graphics_cove/cove_graphics.inc:
	cd graphics_cove && make

movie_cove/combined_cove.zx02:
	cd movie_cove && make

####

clean:		
	rm -f *~ *.o *.lst \
		DISK41 LEVEL_TUNNEL LEVEL_STAIRS LEVEL_COVE \
		MOVIE_COVE LEVEL_STAIRS2


####

distclean:
	rm -f *~ *.o *.lst \
		DISK41 LEVEL_TUNNEL LEVEL_STAIRS LEVEL_COVE \
		MOVIE_COVE LEVEL_STAIRS2
	cd graphics_tunnel && make clean
	cd graphics_stairs && make clean
	cd graphics_cove && make clean
	cd graphics_stairs2 && make clean
	cd movie_cove && make clean
