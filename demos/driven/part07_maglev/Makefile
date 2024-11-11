include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	MOVIE_MAGLEV_RIDE

####

MOVIE_MAGLEV_RIDE:	movie_maglev_ride.o
	ld65 -o MOVIE_MAGLEV_RIDE movie_maglev_ride.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie_maglev_ride.o:	movie_maglev_ride.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc
	ca65 -o movie_maglev_ride.o movie_maglev_ride.s -l movie_maglev_ride.lst


#disk39_defines.inc \
#	movie_maglev_ride/movie_maglev_ride.inc \
#	movie_maglev_ride/overlays/overlay_combined.zx02


movie_maglev_ride/movie_maglev_ride.inc:	
	cd movie_maglev_ride && make

movie_maglev_ride/overlays/overlay_combined.zx02:	
	cd movie_maglev_ride/overlays && make

####

clean:		
	rm -f *~ *.o *.lst DISK39 \
		LEVEL_PROJECTOR LEVEL_MAGSTEPS LEVEL_MAGLEV LEVEL_OUTSIDE \
		MOVIE_MAGLEV_FLIP MOVIE_MAGLEV_RIDE

####

distclean:
	rm -f *~ *.o *.lst DISK39 \
		LEVEL_PROJECTOR LEVEL_MAGSTEPS LEVEL_MAGLEV LEVEL_OUTSIDE \
		MOVIE_MAGLEV_FLIP MOVIE_MAGLEV_RIDE
	cd graphics_projector && make clean
	cd graphics_outside && make clean
	cd graphics_magsteps && make clean
	cd graphics_maglev && make clean
	cd movie_maglev_flip && make clean
	cd movie_maglev_ride && make clean

