include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/
LINKER_SCRIPTS = ../../linker_scripts/


all:	riven_disk01.dsk \
	riven_disk39.dsk riven_disk40.dsk riven_disk41.dsk \
	riven_disk43.dsk

###

riven_disk01.dsk:	QBOOT QLOAD TITLE_01 \
	disk01_files/DISK01 \
	disk01_files/LEVEL_ARRIVAL
	cp $(EMPTY_DISK)/empty.dsk riven_disk01.dsk
	$(DOS33_RAW) riven_disk01.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk01.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk01.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk01.dsk  0  8 disk01_files/DISK01  0   0
	$(DOS33_RAW) riven_disk01.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk01.dsk  1  9 TITLE_01		 0   0
	$(DOS33_RAW) riven_disk01.dsk  2  0 disk01_files/LEVEL_ARRIVAL      0   0

###

riven_disk39.dsk:	QBOOT QLOAD TITLE_39 \
	disk39_files/DISK39 \
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
	$(DOS33_RAW) riven_disk39.dsk  0  8 disk39_files/DISK39  0   0
	$(DOS33_RAW) riven_disk39.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk39.dsk  1  9 TITLE_39		 0   0
	$(DOS33_RAW) riven_disk39.dsk  2  0 disk39_files/LEVEL_PROJECTOR      0   0
	$(DOS33_RAW) riven_disk39.dsk  9  0 disk39_files/LEVEL_OUTSIDE        0   0
	$(DOS33_RAW) riven_disk39.dsk  17 0 disk39_files/LEVEL_MAGSTEPS       0   0
	$(DOS33_RAW) riven_disk39.dsk  21 0 disk39_files/LEVEL_MAGLEV         0   0
	$(DOS33_RAW) riven_disk39.dsk  25 0 disk39_files/MOVIE_MAGLEV_FLIP               0   0
	$(DOS33_RAW) riven_disk39.dsk  27 0 disk39_files/MOVIE_MAGLEV_RIDE               0   0

riven_disk40.dsk:	QBOOT QLOAD TITLE_40 \
	disk40_files/DISK40 \
	disk40_files/LEVEL_MAGLEV \
	disk40_files/LEVEL_OUTSIDE \
	disk40_files/LEVEL_ORB \
	disk40_files/LEVEL_TUNNEL
	cp $(EMPTY_DISK)/empty.dsk riven_disk40.dsk
	$(DOS33_RAW) riven_disk40.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk40.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk40.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk40.dsk  0  8 disk40_files/DISK40  0   0
	$(DOS33_RAW) riven_disk40.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk40.dsk  1  9 TITLE_40		 0   0
	$(DOS33_RAW) riven_disk40.dsk  2  0 disk40_files/LEVEL_MAGLEV    0   0
	$(DOS33_RAW) riven_disk40.dsk  10  0 disk40_files/LEVEL_OUTSIDE   0   0
	$(DOS33_RAW) riven_disk40.dsk  15  0 disk40_files/LEVEL_TUNNEL   0   0
	$(DOS33_RAW) riven_disk40.dsk  21  0 disk40_files/LEVEL_ORB   0   0

riven_disk41.dsk:	QBOOT QLOAD TITLE_41 \
	disk41_files/DISK41 \
	disk41_files/LEVEL_TUNNEL \
	disk41_files/LEVEL_STAIRS \
	disk41_files/LEVEL_COVE \
	disk41_files/LEVEL_STAIRS2 \
	disk41_files/MOVIE_COVE
	cp $(EMPTY_DISK)/empty.dsk riven_disk41.dsk
	$(DOS33_RAW) riven_disk41.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk41.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk41.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk41.dsk  0  8 disk41_files/DISK41  0   0
	$(DOS33_RAW) riven_disk41.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk41.dsk  1  9 TITLE_41		 0   0
	$(DOS33_RAW) riven_disk41.dsk  2  0 disk41_files/LEVEL_TUNNEL   0   0
	$(DOS33_RAW) riven_disk41.dsk 10  0 disk41_files/LEVEL_STAIRS   0   0
	$(DOS33_RAW) riven_disk41.dsk 17  0 disk41_files/LEVEL_COVE     0   0
	$(DOS33_RAW) riven_disk41.dsk 24  0 disk41_files/LEVEL_STAIRS2  0   0
	$(DOS33_RAW) riven_disk41.dsk 31  0 disk41_files/MOVIE_COVE  0   0

riven_disk43.dsk:	QBOOT QLOAD TITLE_43 \
	disk43_files/DISK43 \
	disk43_files/LEVEL_CART \
	disk43_files/LEVEL_BRIDGE
	cp $(EMPTY_DISK)/empty.dsk riven_disk43.dsk
	$(DOS33_RAW) riven_disk43.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk43.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk43.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk43.dsk  0  8 disk43_files/DISK43  0   0
	$(DOS33_RAW) riven_disk43.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk43.dsk  1  9 TITLE_43		 0   0
	$(DOS33_RAW) riven_disk43.dsk  2  0 disk43_files/LEVEL_CART      0   0
	$(DOS33_RAW) riven_disk43.dsk  9  0 disk43_files/LEVEL_BRIDGE      0   0

###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

qload.o:	qload.s qboot.inc \
		zx02_optim.s wait.s \
		draw_pointer.s log_table.s \
		disk40_files/disk40_defines.inc \
		graphics_sprites/pointer_sprites.inc \
		hgr_14x14_sprite.s \
		keyboard.s
	ca65 -o qload.o qload.s -l qload.lst


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

TITLE_41:	title_41.o
	ld65 -o TITLE_41 title_41.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_41.o:	title.s zp.inc hardware.inc \
		qload.inc wait_a_bit.s \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_41.o title.s -DDISK=41 -l title_41.lst



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

disk01_files/DISK01:	
	cd disk01_files && make

disk39_files/DISK39:	
	cd disk39_files && make

disk40_files/DISK40:	
	cd disk40_files && make

disk41_files/DISK41:	
	cd disk41_files && make

disk43_files/DISK43:	
	cd disk43_files && make

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

###

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

####

#qload_start	=	$1700

#full_decomp	=	qload_start+$DB
#wait		=	qload_start+$161
#wait_50xms	=	qload_start+$16f
#draw_pointer	=	qload_start+$178
#save_bg_14x14	=	qload_start+$44f
#handle_keypress	=	qload_start+$4b9
#change_location	=	qload_start+$5f9


qload.inc:	generate_common QLOAD
	./generate_common -a 0x1700 -s full_decomp qload.lst > qload.inc
	./generate_common -a 0x1700 -s wait qload.lst >> qload.inc
	./generate_common -a 0x1700 -s wait_50xms qload.lst >> qload.inc
	./generate_common -a 0x1700 -s draw_pointer qload.lst >> qload.inc
	./generate_common -a 0x1700 -s save_bg_14x14 qload.lst >> qload.inc
	./generate_common -a 0x1700 -s handle_keypress qload.lst >> qload.inc
	./generate_common -a 0x1700 -s change_location qload.lst >> qload.inc
	./generate_common -a 0x1700 -s move_and_print qload.lst >> qload.inc
	./generate_common -a 0x1700 -s set_normal qload.lst >> qload.inc


