include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/
LINKER_SCRIPTS = ../../linker_scripts/


all:	riven_disk39.dsk

riven_disk39.dsk:	QBOOT QLOAD TITLE \
	disk39_files/LEVEL_MAGSTEPS \
	disk39_files/LEVEL_MAGLEV \
	disk39_files/LEVEL_OUTSIDE \
	disk39_files/LEVEL_PROJECTOR \
	disk39_files/MOVIE_MAGLEV_FLIP \
	disk39_files/MOVIE_MAGLEV_RIDE
	cp $(EMPTY_DISK)/empty.dsk riven_disk39.dsk
	$(DOS33_RAW) riven_disk39.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk39.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk39.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk39.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk39.dsk  1  8 TITLE		      0   0
	$(DOS33_RAW) riven_disk39.dsk  2  0 disk39_files/LEVEL_PROJECTOR      0   0
	$(DOS33_RAW) riven_disk39.dsk  9  0 disk39_files/LEVEL_OUTSIDE        0   0
	$(DOS33_RAW) riven_disk39.dsk  17 0 disk39_files/LEVEL_MAGSTEPS       0   0
	$(DOS33_RAW) riven_disk39.dsk  21 0 disk39_files/LEVEL_MAGLEV         0   0
	$(DOS33_RAW) riven_disk39.dsk  25 0 disk39_files/MOVIE_MAGLEV_FLIP               0   0
	$(DOS33_RAW) riven_disk39.dsk  27 0 disk39_files/MOVIE_MAGLEV_RIDE               0   0


###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1800.inc

qload.o:	qload.s qboot.inc \
		zx02_optim.s wait.s \
		draw_pointer.s log_table.s \
		graphics_sprites/pointer_sprites.inc \
		hgr_14x14_sprite.s \
		keyboard.s
	ca65 -o qload.o qload.s -l qload.lst

####

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title.o:	title.s zp.inc hardware.inc \
		qload.inc wait_a_bit.s \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title.o title.s -l title.lst

####

disk39_files/LEVEL_OUTSIDE:	
	cd disk39_files && make

disk39_files/LEVEL_PROJECTOR:	
	cd disk39_files && make

disk39_files/LEVEL_MAGLEV:	
	cd disk39_files && make

disk39_files/LEVEL_MAGSTEPS:	
	cd disk39_files && make

disk39_files/MOVIE_MAGLEV_FLIP:
	cd disk39_files && make

disk39_files/MOVIE_MAGLEV_RIDE:
	cd disk39_files && make

#LEVEL_OUTSIDE:	level_outside.o
#	ld65 -o LEVEL_OUTSIDE level_outside.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

#level_outside.o:	level_outside.s zp.inc hardware.inc \
#		qload.inc \
#		disk39_files/leveldata_outside.inc \
#		graphics_outside/outside_graphics.inc
#	ca65 -o level_outside.o level_outside.s -l level_outside.lst

####

#LEVEL_PROJECTOR:	level_projector.o
#	ld65 -o LEVEL_PROJECTOR level_projector.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

#level_projector.o:	level_projector.s zp.inc hardware.inc \
#		qload.inc \
#		disk39_files/leveldata_projector.inc \
#		graphics_projector/projector_graphics.inc
#	ca65 -o level_projector.o level_projector.s -l level_projector.lst

####

#LEVEL_MAGSTEPS:	level_magsteps.o
#	ld65 -o LEVEL_MAGSTEPS level_magsteps.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

#level_magsteps.o:	level_magsteps.s zp.inc hardware.inc \
#		qload.inc \
#		disk39_files/leveldata_magsteps.inc \
#		graphics_magsteps/magsteps_graphics.inc
#	ca65 -o level_magsteps.o level_magsteps.s -l level_magsteps.lst

####

#LEVEL_MAGLEV:	level_maglev.o
#	ld65 -o LEVEL_MAGLEV level_maglev.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

#level_maglev.o:	level_maglev.s zp.inc hardware.inc \
#		qload.inc \
#		disk39_files/leveldata_maglev.inc \
#		graphics_maglev/maglev_graphics.inc
#	ca65 -o level_maglev.o level_maglev.s -l level_maglev.lst

####

#MOVIE_MAGLEV_FLIP:	movie_maglev_flip.o
#	ld65 -o MOVIE_MAGLEV_FLIP movie_maglev_flip.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

#movie_maglev_flip.o:	movie_maglev_flip.s \
#	zp.inc hardware.inc \
#	qload.inc \
#	movie_maglev_flip/movie_maglev_flip.inc
#	ca65 -o movie_maglev_flip.o movie_maglev_flip.s -l movie_maglev_flip.lst

####

#MOVIE_MAGLEV_RIDE:	movie_maglev_ride.o
#	ld65 -o MOVIE_MAGLEV_RIDE movie_maglev_ride.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

#movie_maglev_ride.o:	movie_maglev_ride.s \
#	zp.inc hardware.inc \
#	qload.inc \
#	end_message/end_message.gr.zx02 \
#	movie_maglev_ride/movie_maglev_ride.inc
#	ca65 -o movie_maglev_ride.o movie_maglev_ride.s -l movie_maglev_ride.lst



####

graphics_sprites/pointer_sprites.inc:
	cd graphics_sprites && make

graphics_title/riven_title.hgr.zx02:	
	cd graphics_title && make

####

clean:		
	rm -f *~ *.o *.lst QLOAD QBOOT TITLE
	cd disk39_files && make clean

####

distclean:
	rm -f *~ *.o *.lst QLOAD QBOOT TITLE
	cd graphics_title && make clean
	cd graphics_sprites && make clean
	cd disk39_files && make distclean

