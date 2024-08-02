include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK40 LEVEL_MAGLEV LEVEL_OUTSIDE LEVEL_ORB LEVEL_TUNNEL \
	MOVIE_MAGLEV_FLIP MOVIE_MAGLEV_RIDE

###

DISK40:	disk40.o
	ld65 -o DISK40 disk40.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk40.o:	disk40.s ../zp.inc
	ca65 -o disk40.o disk40.s -l disk40.lst

####

LEVEL_MAGLEV:	level_maglev.o
	ld65 -o LEVEL_MAGLEV level_maglev.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_maglev.o:	level_maglev.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_maglev.inc \
		graphics_maglev/maglev_graphics.inc
	ca65 -o level_maglev.o level_maglev.s -l level_maglev.lst


####

LEVEL_OUTSIDE:	level_outside.o
	ld65 -o LEVEL_OUTSIDE level_outside.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_outside.o:	level_outside.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_outside.inc \
		graphics_outside/outside_graphics.inc
	ca65 -o level_outside.o level_outside.s -l level_outside.lst

####

LEVEL_ORB:	level_orb.o
	ld65 -o LEVEL_ORB level_orb.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_orb.o:	level_orb.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_orb.inc \
		graphics_orb1/orb1_graphics.inc \
		audio/ball1.btc.zx02
	ca65 -o level_orb.o level_orb.s -l level_orb.lst

####

LEVEL_TUNNEL:	level_tunnel.o
	ld65 -o LEVEL_TUNNEL level_tunnel.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_tunnel.o:	level_tunnel.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk40_defines.inc \
		leveldata_tunnel.inc \
		graphics_tunnel/tunnel_graphics.inc
	ca65 -o level_tunnel.o level_tunnel.s -l level_tunnel.lst


####

MOVIE_MAGLEV_FLIP:	movie_maglev_flip.o
	ld65 -o MOVIE_MAGLEV_FLIP movie_maglev_flip.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie_maglev_flip.o:	movie_maglev_flip.s \
	../flip_pages.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../common_defines.inc disk40_defines.inc \
	movie_maglev_flip/movie_maglev_flip.inc \
	../disk39_files/movie_maglev_flip/overlays/combined_overlays.zx02
	ca65 -o movie_maglev_flip.o movie_maglev_flip.s -l movie_maglev_flip.lst

####

MOVIE_MAGLEV_RIDE:	movie_maglev_ride.o
	ld65 -o MOVIE_MAGLEV_RIDE movie_maglev_ride.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie_maglev_ride.o:	movie_maglev_ride.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../common_defines.inc disk40_defines.inc \
	movie_maglev_ride/movie_maglev_ride.inc \
	../disk39_files/movie_maglev_ride/overlays/overlay_combined.zx02
	ca65 -o movie_maglev_ride.o movie_maglev_ride.s -l movie_maglev_ride.lst

####

audio/ball1.btc.zx02:
	cd audio && make

graphics_maglev/maglev_graphics.inc:
	cd graphics_maglev && make

graphics_outside/outside_graphics.inc:
	cd graphics_outside && make

graphics_orb1/orb1_graphics.inc:
	cd graphics_orb1 && make

graphics_tunnel/tunnel_graphics.inc:
	cd graphics_tunnel && make

movie_maglev_flip/movie_maglev_flip.inc:
	cd movie_maglev_flip && make

movie_maglev_ride/movie_maglev_ride.inc:
	cd movie_maglev_ride && make

####

clean:		
	rm -f *~ *.o *.lst DISK40 \
		LEVEL_MAGLEV LEVEL_OUTSIDE LEVEL_ORB LEVEL_TUNNEL


####

distclean:
	rm -f *~ *.o *.lst DISK40 \
		LEVEL_MAGLEV LEVEL_OUTSIDE LEVEL_ORB LEVEL_TUNNEL
	cd graphics_maglev && make clean
	cd graphics_outside && make clean
	cd graphics_orb1 && make clean
	cd graphics_tunnel && make clean
	cd movie_maglev_flip && make clean
	cd movie_maglev_ride && make clean
