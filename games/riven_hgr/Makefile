include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/
LINKER_SCRIPTS = ../../linker_scripts/


all:	riven_disk01.dsk \
	riven_disk39.dsk riven_disk40.dsk riven_disk43.dsk

###

riven_disk01.dsk:	QBOOT QLOAD_01 TITLE_01 \
	disk01_files/LEVEL_ARRIVAL
	cp $(EMPTY_DISK)/empty.dsk riven_disk01.dsk
	$(DOS33_RAW) riven_disk01.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk01.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk01.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk01.dsk  1  0 QLOAD_01             0   0
	$(DOS33_RAW) riven_disk01.dsk  1  8 TITLE_01		 0   0
	$(DOS33_RAW) riven_disk01.dsk  2  0 disk01_files/LEVEL_ARRIVAL      0   0

###

riven_disk39.dsk:	QBOOT QLOAD_39 TITLE_39 \
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
	$(DOS33_RAW) riven_disk39.dsk  1  0 QLOAD_39             0   0
	$(DOS33_RAW) riven_disk39.dsk  1  8 TITLE_39		 0   0
	$(DOS33_RAW) riven_disk39.dsk  2  0 disk39_files/LEVEL_PROJECTOR      0   0
	$(DOS33_RAW) riven_disk39.dsk  9  0 disk39_files/LEVEL_OUTSIDE        0   0
	$(DOS33_RAW) riven_disk39.dsk  17 0 disk39_files/LEVEL_MAGSTEPS       0   0
	$(DOS33_RAW) riven_disk39.dsk  21 0 disk39_files/LEVEL_MAGLEV         0   0
	$(DOS33_RAW) riven_disk39.dsk  25 0 disk39_files/MOVIE_MAGLEV_FLIP               0   0
	$(DOS33_RAW) riven_disk39.dsk  27 0 disk39_files/MOVIE_MAGLEV_RIDE               0   0

riven_disk40.dsk:	QBOOT QLOAD_40 TITLE_40 \
	disk40_files/LEVEL_MAGLEV \
	disk40_files/LEVEL_OUTSIDE
	cp $(EMPTY_DISK)/empty.dsk riven_disk40.dsk
	$(DOS33_RAW) riven_disk40.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk40.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk40.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk40.dsk  1  0 QLOAD_40             0   0
	$(DOS33_RAW) riven_disk40.dsk  1  8 TITLE_40		 0   0
	$(DOS33_RAW) riven_disk40.dsk  2  0 disk40_files/LEVEL_MAGLEV    0   0
	$(DOS33_RAW) riven_disk40.dsk  9  0 disk40_files/LEVEL_OUTSIDE   0   0

riven_disk43.dsk:	QBOOT QLOAD_43 TITLE_43 \
	disk43_files/LEVEL_CART
	cp $(EMPTY_DISK)/empty.dsk riven_disk43.dsk
	$(DOS33_RAW) riven_disk43.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk43.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk43.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk43.dsk  1  0 QLOAD_43             0   0
	$(DOS33_RAW) riven_disk43.dsk  1  8 TITLE_43		 0   0
	$(DOS33_RAW) riven_disk43.dsk  2  0 disk43_files/LEVEL_CART      0   0

###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

QLOAD_01:	qload_01.o
	ld65 -o QLOAD_01 qload_01.o -C $(LINKER_SCRIPTS)/apple2_1800.inc

qload_01.o:	qload.s qboot.inc \
		zx02_optim.s wait.s \
		draw_pointer.s log_table.s \
		disk01_files/disk01_qload.inc \
		disk01_files/disk01_defines.inc \
		graphics_sprites/pointer_sprites.inc \
		hgr_14x14_sprite.s \
		keyboard.s
	ca65 -o qload_01.o qload.s -DDISK=01 -l qload_01.lst

###

QLOAD_39:	qload_39.o
	ld65 -o QLOAD_39 qload_39.o -C $(LINKER_SCRIPTS)/apple2_1800.inc

qload_39.o:	qload.s qboot.inc \
		zx02_optim.s wait.s \
		draw_pointer.s log_table.s \
		disk39_files/disk39_qload.inc \
		disk39_files/disk39_defines.inc \
		graphics_sprites/pointer_sprites.inc \
		hgr_14x14_sprite.s \
		keyboard.s
	ca65 -o qload_39.o qload.s -DDISK=39 -l qload_39.lst

###

QLOAD_40:	qload_40.o
	ld65 -o QLOAD_40 qload_40.o -C $(LINKER_SCRIPTS)/apple2_1800.inc

qload_40.o:	qload.s qboot.inc \
		zx02_optim.s wait.s \
		draw_pointer.s log_table.s \
		disk40_files/disk40_qload.inc \
		disk40_files/disk40_defines.inc \
		graphics_sprites/pointer_sprites.inc \
		hgr_14x14_sprite.s \
		keyboard.s
	ca65 -o qload_40.o qload.s -DDISK=40 -l qload_40.lst


####

QLOAD_43:	qload_43.o
	ld65 -o QLOAD_43 qload_43.o -C $(LINKER_SCRIPTS)/apple2_1800.inc

qload_43.o:	qload.s qboot.inc \
		zx02_optim.s wait.s \
		draw_pointer.s log_table.s \
		disk43_files/disk43_qload.inc \
		disk43_files/disk43_defines.inc \
		graphics_sprites/pointer_sprites.inc \
		hgr_14x14_sprite.s \
		keyboard.s
	ca65 -o qload_43.o qload.s -DDISK=43 -l qload_43.lst

####

TITLE_01:	title_01.o
	ld65 -o TITLE_01 title_01.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_01.o:	title.s zp.inc hardware.inc \
		qload.inc wait_a_bit.s \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_01.o title.s -DDISK=01 -l title_01.lst

####

TITLE_39:	title_39.o
	ld65 -o TITLE_39 title_39.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_39.o:	title.s zp.inc hardware.inc \
		qload.inc wait_a_bit.s \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_39.o title.s -DDISK=39 -l title_39.lst

####

TITLE_40:	title_40.o
	ld65 -o TITLE_40 title_40.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_40.o:	title.s zp.inc hardware.inc \
		qload.inc wait_a_bit.s \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_40.o title.s -DDISK=40 -l title_40.lst


####

TITLE_43:	title_43.o
	ld65 -o TITLE_43 title_43.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_43.o:	title.s zp.inc hardware.inc \
		qload.inc wait_a_bit.s \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_43.o title.s -DDISK=43 -l title_43.lst


####

disk01_files/LEVEL_ARRIVAL:	
	cd disk01_files && make

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

####

disk40_files/LEVEL_MAGLEV:
	cd disk40_files && make

disk40_files/LEVEL_OUTSIDE:
	cd disk40_files && make

####

disk43_files/LEVEL_CART:
	cd disk43_files && make


####

graphics_sprites/pointer_sprites.inc:
	cd graphics_sprites && make

graphics_title/riven_title.hgr.zx02:	
	cd graphics_title && make

####

clean:		
	rm -f *~ *.o *.lst QLOAD \
	QBOOT_39 QBOOT_40 QBOOT_43 \
	TITLE_39 TITLE_40 TITLE_43
	cd disk39_files && make clean
	cd disk40_files && make clean
	cd disk43_files && make clean

####

distclean:
	rm -f *~ *.o *.lst QLOAD \
	QBOOT_39 QBOOT_40 QBOOT_43 \
	TITLE_39 TITLE_40 TITLE_43
	cd graphics_title && make clean
	cd graphics_sprites && make clean
	cd disk39_files && make distclean
	cd disk40_files && make distclean
	cd disk43_files && make distclean

