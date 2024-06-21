include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK39 \
	LEVEL_OUTSIDE LEVEL_PROJECTOR \
	LEVEL_MAGLEV LEVEL_MAGSTEPS \
	MOVIE_MAGLEV_FLIP MOVIE_MAGLEV_RIDE

####

DISK39:	disk39.o
	ld65 -o DISK39 disk39.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk39.o:	disk39.s ../zp.inc
	ca65 -o disk39.o disk39.s -l disk39.lst


###

LEVEL_OUTSIDE:	level_outside.o
	ld65 -o LEVEL_OUTSIDE level_outside.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_outside.o:	level_outside.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk39_defines.inc \
		leveldata_outside.inc \
		graphics_outside/outside_graphics.inc
	ca65 -o level_outside.o level_outside.s -l level_outside.lst

####

LEVEL_PROJECTOR:	level_projector.o
	ld65 -o LEVEL_PROJECTOR level_projector.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_projector.o:	level_projector.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk39_defines.inc \
		leveldata_projector.inc \
		graphics_projector/projector_graphics.inc
	ca65 -o level_projector.o level_projector.s -l level_projector.lst

####

LEVEL_MAGSTEPS:	level_magsteps.o
	ld65 -o LEVEL_MAGSTEPS level_magsteps.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_magsteps.o:	level_magsteps.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk39_defines.inc \
		leveldata_magsteps.inc \
		graphics_magsteps/magsteps_graphics.inc
	ca65 -o level_magsteps.o level_magsteps.s -l level_magsteps.lst

####

LEVEL_MAGLEV:	level_maglev.o
	ld65 -o LEVEL_MAGLEV level_maglev.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_maglev.o:	level_maglev.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk39_defines.inc \
		leveldata_maglev.inc \
		graphics_maglev/maglev_graphics.inc
	ca65 -o level_maglev.o level_maglev.s -l level_maglev.lst

####

MOVIE_MAGLEV_FLIP:	movie_maglev_flip.o
	ld65 -o MOVIE_MAGLEV_FLIP movie_maglev_flip.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie_maglev_flip.o:	movie_maglev_flip.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../common_defines.inc disk39_defines.inc \
	movie_maglev_flip/movie_maglev_flip.inc \
	movie_maglev_flip/overlays/combined_overlays.zx02
	ca65 -o movie_maglev_flip.o movie_maglev_flip.s -l movie_maglev_flip.lst

####

MOVIE_MAGLEV_RIDE:	movie_maglev_ride.o
	ld65 -o MOVIE_MAGLEV_RIDE movie_maglev_ride.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

movie_maglev_ride.o:	movie_maglev_ride.s \
	../zp.inc ../hardware.inc ../qload.inc \
	../common_defines.inc disk39_defines.inc \
	end_message/end_message.gr.zx02 \
	movie_maglev_ride/movie_maglev_ride.inc \
	movie_maglev_ride/overlays/overlay_combined.zx02
	ca65 -o movie_maglev_ride.o movie_maglev_ride.s -l movie_maglev_ride.lst



####

graphics_sprites/pointer_sprites.inc:
	cd graphics_sprites && make

graphics_title/riven_title.hgr.zx02:	
	cd graphics_title && make

graphics_maglev/maglev_graphics.inc:
	cd graphics_maglev && make

graphics_magsteps/magsteps_graphics.inc:
	cd graphics_magsteps && make

graphics_outside/outside_graphics.inc:
	cd graphics_outside && make

graphics_projector/projector_graphics.inc:
	cd graphics_projector && make

movie_maglev_flip/movie_maglev_flip.inc:	
	cd movie_maglev_flip && make

movie_maglev_flip/overlays/combined_overlays.zx02:	
	cd movie_maglev_flip/overlays && make

movie_maglev_ride/movie_maglev_ride.inc:	
	cd movie_maglev_ride && make

movie_maglev_ride/overlays/overlay_combined.zx02:	
	cd movie_maglev_ride/overlays && make

####

clean:		
	rm -f *~ *.o *.lst \
		LEVEL_PROJECTOR LEVEL_MAGSTEPS LEVEL_MAGLEV LEVEL_OUTSIDE \
		MOVIE_MAGLEV_FLIP MOVIE_MAGLEV_RIDE

####

distclean:
	rm -f *~ *.o *.lst \
		LEVEL_PROJECTOR LEVEL_MAGSTEPS LEVEL_MAGLEV LEVEL_OUTSIDE \
		MOVIE_MAGLEV_FLIP MOVIE_MAGLEV_RIDE
	cd graphics_projector && make clean
	cd graphics_outside && make clean
	cd graphics_magsteps && make clean
	cd graphics_maglev && make clean
	cd movie_maglev_flip && make clean
	cd movie_maglev_ride && make clean

