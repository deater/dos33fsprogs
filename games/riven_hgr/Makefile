include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/
LINKER_SCRIPTS = ../../linker_scripts/
CADIUS = ~/research/apple2/cadius/bin/release/cadius
PRODOSDIR = ../../utils/prodos-utils/
PRODOS = ../../utils/prodos-utils/prodos
PRODOS_RAW = ../../utils/prodos-utils/prodos_raw

all:	riven_disk00.dsk \
	riven_disk01.dsk \
	riven_disk39.dsk riven_disk40.dsk riven_disk41.dsk \
	riven_disk43.dsk \
	riven_hgr.2mg


####

riven_disk00.dsk:	QBOOT QLOAD TITLE_00 \
	disk00_files/DISK00 \
	disk00_files/ATRUS \
	disk00_files/CYAN \
	disk00_files/CAPTURED \
	disk00_files/CHO \
	disk00_files/LEVEL_START
	cp $(EMPTY_DISK)/empty.dsk riven_disk00.dsk
	$(DOS33_RAW) riven_disk00.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk00.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk00.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk00.dsk  0  1 disk00_files/DISK00  0   0
	$(DOS33_RAW) riven_disk00.dsk  0  8 TITLE_00		 0   0
	$(DOS33_RAW) riven_disk00.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk00.dsk  2  0 disk00_files/CYAN      0   0
	$(DOS33_RAW) riven_disk00.dsk  10  0 disk00_files/ATRUS    0   0
	$(DOS33_RAW) riven_disk00.dsk  18  0 disk00_files/CAPTURED 0   0
	$(DOS33_RAW) riven_disk00.dsk  26  0 disk00_files/CHO      0   0
	$(DOS33_RAW) riven_disk00.dsk  31  0 disk00_files/LEVEL_START      0   0

###

riven_disk01.dsk:	QBOOT QLOAD TITLE_01 \
	disk01_files/DISK01 \
	disk01_files/LEVEL_ARRIVAL
	cp $(EMPTY_DISK)/empty.dsk riven_disk01.dsk
	$(DOS33_RAW) riven_disk01.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk01.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk01.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk01.dsk  0  1 disk01_files/DISK01  0   0
	$(DOS33_RAW) riven_disk01.dsk  0  8 TITLE_01		 0   0
	$(DOS33_RAW) riven_disk01.dsk  1  0 QLOAD                0   0
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
	$(DOS33_RAW) riven_disk39.dsk  0  1 disk39_files/DISK39  0   0
	$(DOS33_RAW) riven_disk39.dsk  0  8 TITLE_39		 0   0
	$(DOS33_RAW) riven_disk39.dsk  1  0 QLOAD                0   0
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
	$(DOS33_RAW) riven_disk40.dsk  0  1 disk40_files/DISK40  0   0
	$(DOS33_RAW) riven_disk40.dsk  0  8 TITLE_40		 0   0
	$(DOS33_RAW) riven_disk40.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk40.dsk  2  0 disk40_files/LEVEL_MAGLEV    0   0
	$(DOS33_RAW) riven_disk40.dsk  10 0 disk40_files/LEVEL_OUTSIDE   0   0
	$(DOS33_RAW) riven_disk40.dsk  15 0 disk40_files/LEVEL_TUNNEL   0   0
	$(DOS33_RAW) riven_disk40.dsk  21 0 disk40_files/LEVEL_ORB   0   0

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
	$(DOS33_RAW) riven_disk41.dsk  0  1 disk41_files/DISK41  0   0
	$(DOS33_RAW) riven_disk41.dsk  0  8 TITLE_41		 0   0
	$(DOS33_RAW) riven_disk41.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk41.dsk  2  0 disk41_files/LEVEL_TUNNEL   0   0
	$(DOS33_RAW) riven_disk41.dsk 10  0 disk41_files/LEVEL_STAIRS   0   0
	$(DOS33_RAW) riven_disk41.dsk 17  0 disk41_files/LEVEL_COVE     0   0
	$(DOS33_RAW) riven_disk41.dsk 24  0 disk41_files/LEVEL_STAIRS2  0   0
	$(DOS33_RAW) riven_disk41.dsk 31  0 disk41_files/MOVIE_COVE  0   0

riven_disk43.dsk:	QBOOT QLOAD TITLE_43 \
	disk43_files/DISK43 \
	disk43_files/LEVEL_CART \
	disk43_files/LEVEL_BRIDGE \
	disk43_files/LEVEL_LOGGED \
	disk43_files/LEVEL_LOGGED2
	cp $(EMPTY_DISK)/empty.dsk riven_disk43.dsk
	$(DOS33_RAW) riven_disk43.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk43.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk43.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk43.dsk  0  1 disk43_files/DISK43  0   0
	$(DOS33_RAW) riven_disk43.dsk  0  8 TITLE_43		 0   0
	$(DOS33_RAW) riven_disk43.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk43.dsk  2  0 disk43_files/LEVEL_CART     0   0
	$(DOS33_RAW) riven_disk43.dsk  9  0 disk43_files/LEVEL_BRIDGE   0   0
	$(DOS33_RAW) riven_disk43.dsk  16 0 disk43_files/LEVEL_LOGGED   0   0
	$(DOS33_RAW) riven_disk43.dsk  22 0 disk43_files/LEVEL_LOGGED2  0   0



###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1600.inc

qload.o:	qload.s qload_floppy.s qboot.inc \
		zx02_optim.s wait.s wait_a_bit.s \
		gr_offsets.s text_print.s \
		draw_pointer.s log_table.s \
		disk40_files/disk40_defines.inc \
		graphics_sprites/pointer_sprites.inc \
		hgr_14x14_sprite.s \
		keyboard.s
	ca65 -o qload.o qload.s -DFLOPPY=1 -l qload.lst

###

QLOAD_HD:	qload_hd.o
	ld65 -o QLOAD_HD qload_hd.o -C $(LINKER_SCRIPTS)/apple2_1600.inc

qload_hd.o:	qload.s qload_floppy.s qboot.inc \
		zx02_optim.s wait.s wait_a_bit.s \
		gr_offsets.s text_print.s \
		draw_pointer.s log_table.s \
		disk40_files/disk40_defines.inc \
		graphics_sprites/pointer_sprites.inc \
		hgr_14x14_sprite.s \
		keyboard.s
	ca65 -o qload_hd.o qload.s -DFLOPPY=0 -l qload.lst


####

TITLE_00:	title_00.o
	ld65 -o TITLE_00 title_00.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_00.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_00.o title.s -DDISK=00 -l title_00.lst

####

TITLE_01:	title_01.o
	ld65 -o TITLE_01 title_01.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_01.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_01.o title.s -DDISK=01 -l title_01.lst

####

TITLE_39:	title_39.o
	ld65 -o TITLE_39 title_39.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_39.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_39.o title.s -DDISK=39 -l title_39.lst

####

TITLE_40:	title_40.o
	ld65 -o TITLE_40 title_40.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_40.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_40.o title.s -DDISK=40 -l title_40.lst

####

TITLE_41:	title_41.o
	ld65 -o TITLE_41 title_41.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_41.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_41.o title.s -DDISK=41 -l title_41.lst



####

TITLE_43:	title_43.o
	ld65 -o TITLE_43 title_43.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_43.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_43.o title.s -DDISK=43 -l title_43.lst


####

disk01_files/LEVEL_ARRIVAL:	
	cd disk01_files && make

####
disk00_files/DISK00:	
	cd disk00_files && make

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
	rm -f *~ *.o *.lst dts_block generate_common \
	QBOOT QLOAD QLOAD_HD \
	TITLE_00 TITLE_01 TITLE_39 TITLE_40 TITLE_41 TITLE_43
	cd disk00_files && make clean
	cd disk01_files && make clean
	cd disk39_files && make clean
	cd disk40_files && make clean
	cd disk41_files && make clean
	cd disk43_files && make clean

####

distclean:
	rm -f *~ *.o *.lst generate_common \
	QBOOT QLOAD QLOAD_HD \
	TITLE_00 TITLE_01 TITLE_39 TITLE_40 TITLE_41 TITLE_43
	cd graphics_title && make clean
	cd graphics_sprites && make clean
	cd disk00_files && make distclean
	cd disk01_files && make distclean
	cd disk39_files && make distclean
	cd disk40_files && make distclean
	cd disk41_files && make distclean
	cd disk43_files && make distclean

###

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

####

qload.inc:	generate_common QLOAD
	./generate_common -a 0x1600 -s full_decomp qload.lst > qload.inc
	./generate_common -a 0x1600 -s wait qload.lst >> qload.inc
	./generate_common -a 0x1600 -s wait_50xms qload.lst >> qload.inc
	./generate_common -a 0x1600 -s wait_a_bit qload.lst >> qload.inc
	./generate_common -a 0x1600 -s draw_pointer qload.lst >> qload.inc
	./generate_common -a 0x1600 -s save_bg_14x14 qload.lst >> qload.inc
	./generate_common -a 0x1600 -s handle_keypress qload.lst >> qload.inc
	./generate_common -a 0x1600 -s change_location qload.lst >> qload.inc
	./generate_common -a 0x1600 -s move_and_print qload.lst >> qload.inc
	./generate_common -a 0x1600 -s move_and_print_list qload.lst >> qload.inc
	./generate_common -a 0x1600 -s clear_bottom qload.lst >> qload.inc
	./generate_common -a 0x1600 -s set_normal qload.lst >> qload.inc
	./generate_common -a 0x1600 -s force_uppercase qload.lst >> qload.inc
	./generate_common -a 0x1600 -s gr_offsets qload.lst >> qload.inc
	./generate_common -a 0x1600 -s clear_gr_all qload.lst >> qload.inc

submit:	riven_disk00.dsk riven_disk01.dsk \
	riven_disk39.dsk \
	riven_disk40.dsk riven_disk41.dsk riven_disk43.dsk
	zip riven_hgr.zip riven_disk00.dsk riven_disk01.dsk \
			riven_disk39.dsk \
		riven_disk40.dsk riven_disk41.dsk riven_disk43.dsk


###

dts_block:	dts_block.o
	$(CC) $(LFLAGS) -o dts_block dts_block.o

dts_block.o:	dts_block.c
	$(CC) $(CFLAGS) -c dts_block.c

####

riven_hgr.2mg:	dts_block PROBOOTHD QLOAD_HD \
	TITLE_00 \
	disk00_files/DISK00 \
	disk00_files/ATRUS \
	disk00_files/CYAN \
	disk00_files/CAPTURED \
	disk00_files/CHO \
	disk00_files/LEVEL_START
	$(PRODOSDIR)/mkprodosfs riven_hgr.2mg -n Riven -b 65535 -2
	$(PRODOS_RAW) riven_hgr.2mg 0 PROBOOTHD 0 0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 0 1  0`  QLOAD_HD 0 0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 0 0  2` disk00_files/DISK00  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 0 0  8` TITLE_00		 0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 0 2  0` disk00_files/CYAN      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 0 10 0` disk00_files/ATRUS    0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 0 18 0` disk00_files/CAPTURED 0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 0 26 0` disk00_files/CHO      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 0 31 0` disk00_files/LEVEL_START      0   0

###

PROBOOTHD:	proboothd.o
	ld65 -o PROBOOTHD proboothd.o -C $(LINKER_SCRIPTS)/apple2_800.inc

proboothd.o:	proboothd.s
	ca65 -o proboothd.o proboothd.s -l proboothd.lst
