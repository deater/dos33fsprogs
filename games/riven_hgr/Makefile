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
	riven_disk01.dsk riven_disk02.dsk riven_disk03.dsk \
	riven_disk04.dsk riven_disk05.dsk riven_disk06.dsk \
	riven_disk10.dsk \
	riven_disk16.dsk \
	riven_disk38.dsk riven_disk39.dsk \
	riven_disk40.dsk riven_disk41.dsk riven_disk43.dsk riven_disk44.dsk \
	riven_disk50.dsk \
	riven_disk60.dsk \
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
	disk01_files/LEVEL_ARRIVAL \
	disk01_files/LEVEL_ARRIVAL2 \
	disk01_files/LEVEL_TELESCOPE \
	disk01_files/LEVEL_ARRIVAL3 \
	disk01_files/LEVEL_PATH
	cp $(EMPTY_DISK)/empty.dsk riven_disk01.dsk
	$(DOS33_RAW) riven_disk01.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk01.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk01.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk01.dsk  0  1 disk01_files/DISK01  0   0
	$(DOS33_RAW) riven_disk01.dsk  0  8 TITLE_01		 0   0
	$(DOS33_RAW) riven_disk01.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk01.dsk  2  0 disk01_files/LEVEL_ARRIVAL      0   0
	$(DOS33_RAW) riven_disk01.dsk  9  0 disk01_files/LEVEL_ARRIVAL2      0   0
	$(DOS33_RAW) riven_disk01.dsk  13  0 disk01_files/LEVEL_TELESCOPE    0   0
	$(DOS33_RAW) riven_disk01.dsk  19  0 disk01_files/LEVEL_ARRIVAL3    0   0
	$(DOS33_RAW) riven_disk01.dsk  27  0 disk01_files/LEVEL_PATH        0   0

###

riven_disk02.dsk:	QBOOT QLOAD TITLE_02 \
	disk02_files/DISK02 \
	disk02_files/LEVEL_STEPS1 \
	disk02_files/LEVEL_STEPS3 \
	disk02_files/LEVEL_TOP \
	disk02_files/LEVEL_BRIDGE \
	disk02_files/LEVEL_ALCOVE
	cp $(EMPTY_DISK)/empty.dsk riven_disk02.dsk
	$(DOS33_RAW) riven_disk02.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk02.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk02.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk02.dsk  0  1 disk02_files/DISK02  0   0
	$(DOS33_RAW) riven_disk02.dsk  0  8 TITLE_02		 0   0
	$(DOS33_RAW) riven_disk02.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk02.dsk  2  0 disk02_files/LEVEL_STEPS1      0   0
	$(DOS33_RAW) riven_disk02.dsk  8  0 disk02_files/LEVEL_STEPS3      0   0
	$(DOS33_RAW) riven_disk02.dsk  14  0 disk02_files/LEVEL_TOP        0   0
	$(DOS33_RAW) riven_disk02.dsk  18  0 disk02_files/LEVEL_BRIDGE     0   0
	$(DOS33_RAW) riven_disk02.dsk  22  0 disk02_files/LEVEL_ALCOVE     0   0


###

riven_disk03.dsk:	QBOOT QLOAD TITLE_03 \
	disk03_files/DISK03 \
	disk03_files/LEVEL_DOWNSTEPS \
	disk03_files/LEVEL_DOWNSTEPS3 \
	disk03_files/LEVEL_OUTSIDE \
	disk03_files/LEVEL_CAVE \
	disk03_files/LEVEL_DOORWAY
	cp $(EMPTY_DISK)/empty.dsk riven_disk03.dsk
	$(DOS33_RAW) riven_disk03.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk03.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk03.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk03.dsk  0  1 disk03_files/DISK03  0   0
	$(DOS33_RAW) riven_disk03.dsk  0  8 TITLE_03		 0   0
	$(DOS33_RAW) riven_disk03.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk03.dsk  2  0 disk03_files/LEVEL_DOWNSTEPS      0   0
	$(DOS33_RAW) riven_disk03.dsk  9  0 disk03_files/LEVEL_DOWNSTEPS3      0   0
	$(DOS33_RAW) riven_disk03.dsk  15  0 disk03_files/LEVEL_OUTSIDE      0   0
	$(DOS33_RAW) riven_disk03.dsk  22  0 disk03_files/LEVEL_CAVE      0   0
	$(DOS33_RAW) riven_disk03.dsk  28  0 disk03_files/LEVEL_DOORWAY      0   0


###

riven_disk04.dsk:	QBOOT QLOAD TITLE_04 \
	disk04_files/DISK04 \
	disk04_files/LEVEL_BRIDGE1 \
	disk04_files/LEVEL_BRIDGE2 \
	disk04_files/LEVEL_TUNNEL1 \
	disk04_files/LEVEL_TUNNEL3 \
	disk04_files/LEVEL_TUNNEL4 \
	disk04_files/LEVEL_TUNNEL7
	cp $(EMPTY_DISK)/empty.dsk riven_disk04.dsk
	$(DOS33_RAW) riven_disk04.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk04.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk04.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk04.dsk  0  1 disk04_files/DISK04  0   0
	$(DOS33_RAW) riven_disk04.dsk  0  8 TITLE_04		 0   0
	$(DOS33_RAW) riven_disk04.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk04.dsk  2  0 disk04_files/LEVEL_BRIDGE1      0   0
	$(DOS33_RAW) riven_disk04.dsk  7  0 disk04_files/LEVEL_BRIDGE2      0   0
	$(DOS33_RAW) riven_disk04.dsk  12  0 disk04_files/LEVEL_TUNNEL1      0   0
	$(DOS33_RAW) riven_disk04.dsk  17  0 disk04_files/LEVEL_TUNNEL3      0   0
	$(DOS33_RAW) riven_disk04.dsk  22  0 disk04_files/LEVEL_TUNNEL4      0   0
	$(DOS33_RAW) riven_disk04.dsk  28  0 disk04_files/LEVEL_TUNNEL7      0   0

###

riven_disk05.dsk:	QBOOT QLOAD TITLE_05 \
	disk05_files/DISK05 \
	disk05_files/LEVEL_CHAIR \
	disk05_files/LEVEL_CHAIR2 \
	disk05_files/MOVIE_CHAIR
	cp $(EMPTY_DISK)/empty.dsk riven_disk05.dsk
	$(DOS33_RAW) riven_disk05.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk05.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk05.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk05.dsk  0  1 disk05_files/DISK05  0   0
	$(DOS33_RAW) riven_disk05.dsk  0  8 TITLE_05		 0   0
	$(DOS33_RAW) riven_disk05.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk05.dsk  2  0 disk05_files/LEVEL_CHAIR      0   0
	$(DOS33_RAW) riven_disk05.dsk  8  0 disk05_files/LEVEL_CHAIR2      0   0
	$(DOS33_RAW) riven_disk05.dsk  15 0 disk05_files/MOVIE_CHAIR      0   0

###

riven_disk06.dsk:	QBOOT QLOAD TITLE_06 \
	disk06_files/DISK06 \
	disk06_files/ATRUS_JOURNAL
	cp $(EMPTY_DISK)/empty.dsk riven_disk06.dsk
	$(DOS33_RAW) riven_disk06.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk06.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk06.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk06.dsk  0  1 disk06_files/DISK06  0   0
	$(DOS33_RAW) riven_disk06.dsk  0  8 TITLE_06		 0   0
	$(DOS33_RAW) riven_disk06.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk06.dsk  2  0 disk06_files/ATRUS_JOURNAL      0   0




###

riven_disk10.dsk:	QBOOT QLOAD TITLE_10 \
	disk10_files/LEVEL_CENTER \
	disk10_files/LEVEL_PILLARS \
	disk10_files/LEVEL_15 \
	disk10_files/LEVEL_21 \
	disk10_files/LEVEL_32
	cp $(EMPTY_DISK)/empty.dsk riven_disk10.dsk
	$(DOS33_RAW) riven_disk10.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk10.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk10.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk10.dsk  0  1 disk10_files/DISK10  0   0
	$(DOS33_RAW) riven_disk10.dsk  0  8 TITLE_10		 0   0
	$(DOS33_RAW) riven_disk10.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk10.dsk  2  0 disk10_files/LEVEL_CENTER      0   0
	$(DOS33_RAW) riven_disk10.dsk  8  0 disk10_files/LEVEL_15      0   0
	$(DOS33_RAW) riven_disk10.dsk 11  0 disk10_files/LEVEL_21      0   0
	$(DOS33_RAW) riven_disk10.dsk 14  0 disk10_files/LEVEL_32      0   0
	$(DOS33_RAW) riven_disk10.dsk  23 0 disk10_files/LEVEL_PILLARS      0   0

###

riven_disk16.dsk:	QBOOT QLOAD TITLE_16 \
	disk16_files/DISK16 \
	disk16_files/LEVEL_BRIDGE \
	disk16_files/LEVEL_BRIDGE2 \
	disk16_files/LEVEL_DOME
	cp $(EMPTY_DISK)/empty.dsk riven_disk16.dsk
	$(DOS33_RAW) riven_disk16.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk16.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk16.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk16.dsk  0  1 disk16_files/DISK16  0   0
	$(DOS33_RAW) riven_disk16.dsk  0  8 TITLE_16		 0   0
	$(DOS33_RAW) riven_disk16.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk16.dsk  2  0 disk16_files/LEVEL_BRIDGE      0   0
	$(DOS33_RAW) riven_disk16.dsk  9  0 disk16_files/LEVEL_BRIDGE2      0   0
	$(DOS33_RAW) riven_disk16.dsk  15  0 disk16_files/LEVEL_DOME      0   0


###

riven_disk38.dsk:	QBOOT QLOAD TITLE_38 \
	disk38_files/DISK38 \
	disk38_files/LEVEL_PROJECTOR \
	disk38_files/LEVEL_ENTRY \
	disk38_files/LEVEL_CLOSE \
	disk38_files/LEVEL_MID
	cp $(EMPTY_DISK)/empty.dsk riven_disk38.dsk
	$(DOS33_RAW) riven_disk38.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk38.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk38.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk38.dsk  0  1 disk38_files/DISK38  0   0
	$(DOS33_RAW) riven_disk38.dsk  0  8 TITLE_38		 0   0
	$(DOS33_RAW) riven_disk38.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk38.dsk  2  0 disk38_files/LEVEL_PROJECTOR      0   0
	$(DOS33_RAW) riven_disk38.dsk  8  0 disk38_files/LEVEL_ENTRY      0   0
	$(DOS33_RAW) riven_disk38.dsk 14  0 disk38_files/LEVEL_CLOSE      0   0
	$(DOS33_RAW) riven_disk38.dsk 20  0 disk38_files/LEVEL_MID	      0   0

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
	$(DOS33_RAW) riven_disk39.dsk  8  0 disk39_files/LEVEL_OUTSIDE        0   0
	$(DOS33_RAW) riven_disk39.dsk  17 0 disk39_files/LEVEL_MAGSTEPS       0   0
	$(DOS33_RAW) riven_disk39.dsk  21 0 disk39_files/LEVEL_MAGLEV         0   0
	$(DOS33_RAW) riven_disk39.dsk  25 0 disk39_files/MOVIE_MAGLEV_FLIP               0   0
	$(DOS33_RAW) riven_disk39.dsk  27 0 disk39_files/MOVIE_MAGLEV_RIDE               0   0

riven_disk40.dsk:	QBOOT QLOAD TITLE_40 \
	disk40_files/DISK40 \
	disk40_files/LEVEL_MAGLEV \
	disk40_files/LEVEL_OUTSIDE \
	disk40_files/LEVEL_ORB \
	disk40_files/LEVEL_TUNNEL \
	disk40_files/MOVIE_MAGLEV_FLIP \
	disk40_files/MOVIE_MAGLEV_RIDE
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
	$(DOS33_RAW) riven_disk40.dsk  25 0 disk40_files/MOVIE_MAGLEV_FLIP   0   0
	$(DOS33_RAW) riven_disk40.dsk  27 0 disk40_files/MOVIE_MAGLEV_RIDE   0   0


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
	disk43_files/LEVEL_LOGGED3 \
	disk43_files/LEVEL_LOGGED4 \
	disk43_files/LEVEL_LOGGED5 \
	disk43_files/MOVIE_CART_RIDE
	cp $(EMPTY_DISK)/empty.dsk riven_disk43.dsk
	$(DOS33_RAW) riven_disk43.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk43.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk43.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk43.dsk  0  1 disk43_files/DISK43  0   0
	$(DOS33_RAW) riven_disk43.dsk  0  8 TITLE_43		 0   0
	$(DOS33_RAW) riven_disk43.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk43.dsk  2  0 disk43_files/LEVEL_CART     0   0
	$(DOS33_RAW) riven_disk43.dsk  8  0 disk43_files/LEVEL_BRIDGE   0   0
	$(DOS33_RAW) riven_disk43.dsk  13 0 disk43_files/LEVEL_LOGGED   0   0
	$(DOS33_RAW) riven_disk43.dsk  18 0 disk43_files/LEVEL_LOGGED3  0   0
	$(DOS33_RAW) riven_disk43.dsk  23 0 disk43_files/LEVEL_LOGGED4  0   0
	$(DOS33_RAW) riven_disk43.dsk  26 0 disk43_files/LEVEL_LOGGED5  0   0
	$(DOS33_RAW) riven_disk43.dsk  31 0 disk43_files/MOVIE_CART_RIDE  0   0

riven_disk44.dsk:	QBOOT QLOAD TITLE_44 \
	disk44_files/DISK44 \
	disk44_files/LEVEL_PATH \
	disk44_files/LEVEL_FISH
	cp $(EMPTY_DISK)/empty.dsk riven_disk44.dsk
	$(DOS33_RAW) riven_disk44.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk44.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk44.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk44.dsk  0  1 disk44_files/DISK44  0   0
	$(DOS33_RAW) riven_disk44.dsk  0  8 TITLE_44		 0   0
	$(DOS33_RAW) riven_disk44.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk44.dsk  2  0 disk44_files/LEVEL_FISH     0   0
	$(DOS33_RAW) riven_disk44.dsk  8  0 disk44_files/LEVEL_PATH     0   0

riven_disk50.dsk:	QBOOT QLOAD TITLE_50 \
	disk50_files/DISK50 \
	disk50_files/LEVEL_CHIPPER
	cp $(EMPTY_DISK)/empty.dsk riven_disk50.dsk
	$(DOS33_RAW) riven_disk50.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk50.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk50.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk50.dsk  0  1 disk50_files/DISK50  0   0
	$(DOS33_RAW) riven_disk50.dsk  0  8 TITLE_50		 0   0
	$(DOS33_RAW) riven_disk50.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk50.dsk  2  0 disk50_files/LEVEL_CHIPPER     0   0

riven_disk60.dsk:	QBOOT QLOAD TITLE_60 \
	disk60_files/DISK60 \
	disk60_files/LEVEL_SPIRES
	cp $(EMPTY_DISK)/empty.dsk riven_disk60.dsk
	$(DOS33_RAW) riven_disk60.dsk  0  0 QBOOT                0   1
	$(DOS33_RAW) riven_disk60.dsk  0  2 QBOOT                1   1
	$(DOS33_RAW) riven_disk60.dsk  0  4 QBOOT                2   1
	$(DOS33_RAW) riven_disk60.dsk  0  1 disk60_files/DISK60  0   0
	$(DOS33_RAW) riven_disk60.dsk  0  8 TITLE_60		 0   0
	$(DOS33_RAW) riven_disk60.dsk  1  0 QLOAD                0   0
	$(DOS33_RAW) riven_disk60.dsk  2  0 disk60_files/LEVEL_SPIRES     0   0


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

qload_hd.o:	qload.s qload_hd.s qboot.inc \
		zx02_optim.s wait.s wait_a_bit.s \
		gr_offsets.s text_print.s \
		draw_pointer.s log_table.s \
		disk40_files/disk40_defines.inc \
		graphics_sprites/pointer_sprites.inc \
		hgr_14x14_sprite.s \
		keyboard.s
	ca65 -o qload_hd.o qload.s -DFLOPPY=0 -l qload_hd.lst


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

TITLE_02:	title_02.o
	ld65 -o TITLE_02 title_02.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_02.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_02.o title.s -DDISK=02 -l title_02.lst

####

TITLE_03:	title_03.o
	ld65 -o TITLE_03 title_03.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_03.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_03.o title.s -DDISK=03 -l title_03.lst

####

TITLE_04:	title_04.o
	ld65 -o TITLE_04 title_04.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_04.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_04.o title.s -DDISK=04 -l title_04.lst

####

TITLE_05:	title_05.o
	ld65 -o TITLE_05 title_05.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_05.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_05.o title.s -DDISK=05 -l title_05.lst

####

TITLE_06:	title_06.o
	ld65 -o TITLE_06 title_06.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_06.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_06.o title.s -DDISK=06 -l title_06.lst


####

TITLE_10:	title_10.o
	ld65 -o TITLE_10 title_10.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_10.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_10.o title.s -DDISK=10 -l title_10.lst


####

TITLE_16:	title_16.o
	ld65 -o TITLE_16 title_16.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_16.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_16.o title.s -DDISK=16 -l title_16.lst


####

TITLE_38:	title_38.o
	ld65 -o TITLE_38 title_38.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_38.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_38.o title.s -DDISK=38 -l title_38.lst

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

TITLE_44:	title_44.o
	ld65 -o TITLE_44 title_44.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_44.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_44.o title.s -DDISK=44 -l title_44.lst


####

TITLE_50:	title_50.o
	ld65 -o TITLE_50 title_50.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_50.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_50.o title.s -DDISK=50 -l title_50.lst


####

TITLE_60:	title_60.o
	ld65 -o TITLE_60 title_60.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title_60.o:	title.s zp.inc hardware.inc \
		qload.inc \
		hgr_tables.s \
		graphics_title/riven_title.hgr.zx02
	ca65 -o title_60.o title.s -DDISK=60 -l title_60.lst





####

disk00_files/DISK00:	
	cd disk00_files && make

disk01_files/DISK01:	
	cd disk01_files && make

disk02_files/DISK02:	
	cd disk02_files && make

disk03_files/DISK03:	
	cd disk03_files && make

disk04_files/DISK04:	
	cd disk04_files && make

disk05_files/DISK05:	
	cd disk05_files && make

disk06_files/DISK06:	
	cd disk06_files && make

disk10_files/DISK10:	
	cd disk10_files && make

disk16_files/DISK16:	
	cd disk16_files && make

disk38_files/DISK38:	
	cd disk38_files && make

disk39_files/DISK39:	
	cd disk39_files && make

disk40_files/DISK40:	
	cd disk40_files && make

disk41_files/DISK41:	
	cd disk41_files && make

disk43_files/DISK43:	
	cd disk43_files && make

disk44_files/DISK44:	
	cd disk44_files && make

disk50_files/DISK50:	
	cd disk50_files && make

disk60_files/DISK60:	
	cd disk60_files && make


####

disk01_files/LEVEL_ARRIVAL:	
	cd disk01_files && make

disk01_files/LEVEL_ARRIVAL2:	
	cd disk01_files && make

disk01_files/LEVEL_ARRIVAL3:	
	cd disk01_files && make

disk01_files/LEVEL_PATH:	
	cd disk01_files && make

####

disk02_files/LEVEL_STEPS1:	
	cd disk02_files && make

disk02_files/LEVEL_STEPS3:	
	cd disk02_files && make

disk02_files/LEVEL_TOP:	
	cd disk02_files && make

disk02_files/LEVEL_BRIDGE:	
	cd disk02_files && make

disk02_files/LEVEL_ALCOVE:	
	cd disk02_files && make

####

disk03_files/LEVEL_DOWNSTEPS:	
	cd disk03_files && make

disk03_files/LEVEL_DOWNSTEPS3:	
	cd disk03_files && make

disk03_files/LEVEL_OUTSIDE:	
	cd disk03_files && make

disk03_files/LEVEL_CAVE:	
	cd disk03_files && make

disk03_files/LEVEL_DOORWAY:	
	cd disk03_files && make

####

disk04_files/LEVEL_BRIDGE1:	
	cd disk04_files && make

disk04_files/LEVEL_BRIDGE2:	
	cd disk04_files && make

disk04_files/LEVEL_TUNNEL1:	
	cd disk04_files && make

disk04_files/LEVEL_TUNNEL3:	
	cd disk04_files && make

disk04_files/LEVEL_TUNNEL4:	
	cd disk04_files && make

disk04_files/LEVEL_TUNNEL7:	
	cd disk07_files && make

####

disk05_files/LEVEL_CHAIR:	
	cd disk05_files && make

disk05_files/LEVEL_CHAIR2:	
	cd disk05_files && make

disk05_files/MOVIE_CHAIR:	
	cd disk05_files && make

####

disk06_files/ATRUS_JOURNAL:	
	cd disk06_files && make

####

disk10_files/LEVEL_CENTER:	
	cd disk10_files && make

disk10_files/LEVEL_PILLARS:	
	cd disk10_files && make

disk10_files/LEVEL_15:	
	cd disk10_files && make

disk10_files/LEVEL_21:	
	cd disk10_files && make

disk10_files/LEVEL_32:	
	cd disk10_files && make

####

disk16_files/LEVEL_BRIDGE:	
	cd disk16_files && make

disk16_files/LEVEL_BRIDGE2:	
	cd disk16_files && make

disk16_files/LEVEL_DOME:	
	cd disk16_files && make

####

disk38_files/LEVEL_PROJECTOR:	
	cd disk38_files && make

disk38_files/LEVEL_ENTRY:	
	cd disk38_files && make

disk38_files/LEVEL_CLOSE:	
	cd disk38_files && make

disk38_files/LEVEL_MID:	
	cd disk38_files && make

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

disk43_files/LEVEL_LOGGED:
	cd disk43_files && make

disk43_files/LEVEL_LOGGED3:
	cd disk43_files && make

disk43_files/LEVEL_LOGGED4:
	cd disk43_files && make

disk43_files/LEVEL_LOGGED5:
	cd disk43_files && make

####

disk44_files/LEVEL_PATH:
	cd disk44_files && make

disk44_files/LEVEL_FISH:
	cd disk44_files && make


####

disk50_files/LEVEL_CHIPPER:
	cd disk50_files && make

####

disk60_files/LEVEL_SPIRES:
	cd disk60_files && make


####

graphics_sprites/pointer_sprites.inc:
	cd graphics_sprites && make

graphics_title/riven_title.hgr.zx02:	
	cd graphics_title && make

####

clean:		
	rm -f *~ *.o *.lst dts_block generate_common \
	QBOOT QLOAD QLOAD_HD \
	TITLE_00 TITLE_01 TITLE_02 TITLE_03 TITLE_04 TITLE_05 \
	TITLE_06 TITLE_10 \
	TITLE_16 \
	TITLE_38 TITLE_39 \
	TITLE_40 TITLE_41 TITLE_43 TITLE_44 TITLE_50 \
	TITLE_60
	cd disk00_files && make clean
	cd disk01_files && make clean
	cd disk02_files && make clean
	cd disk03_files && make clean
	cd disk04_files && make clean
	cd disk05_files && make clean
	cd disk06_files && make clean
	cd disk10_files && make clean
	cd disk16_files && make clean
	cd disk38_files && make clean
	cd disk39_files && make clean
	cd disk40_files && make clean
	cd disk41_files && make clean
	cd disk43_files && make clean
	cd disk44_files && make clean
	cd disk50_files && make clean
	cd disk60_files && make clean

####

distclean:
	rm -f *~ *.o *.lst generate_common \
	QBOOT QLOAD QLOAD_HD \
	TITLE_00 TITLE_01 TITLE_02 TITLE_03 TITLE_04 TITLE_05 \
	TITLE_06 TITLE_10 \
	TITLE_16 \
	TITLE_38 TITLE_39 \
	TITLE_40 TITLE_41 TITLE_43 TITLE_44 TITLE_50 \
	TITLE_60
	cd graphics_title && make clean
	cd graphics_sprites && make clean
	cd disk00_files && make distclean
	cd disk01_files && make distclean
	cd disk02_files && make distclean
	cd disk03_files && make distclean
	cd disk04_files && make distclean
	cd disk05_files && make distclean
	cd disk06_files && make distclean
	cd disk10_files && make distclean
	cd disk16_files && make distclean
	cd disk38_files && make distclean
	cd disk39_files && make distclean
	cd disk40_files && make distclean
	cd disk41_files && make distclean
	cd disk43_files && make distclean
	cd disk44_files && make distclean
	cd disk50_files && make distclean
	cd disk60_files && make distclean

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
	./generate_common -a 0x1600 -s clear_bottom_loop_outer qload.lst >> qload.inc
	./generate_common -a 0x1600 -s clear_value_smc qload.lst >> qload.inc
	./generate_common -a 0x1600 -s set_inverse qload.lst >> qload.inc
	./generate_common -a 0x1600 -s ps_smc1 qload.lst >> qload.inc

submit:	riven_disk00.dsk riven_disk01.dsk riven_disk02.dsk riven_disk03.dsk \
	riven_disk04.dsk riven_disk05.dsk riven_disk06.dsk \
	riven_disk10.dsk \
	riven_disk16.dsk \
	riven_disk38.dsk riven_disk39.dsk \
	riven_disk40.dsk riven_disk41.dsk riven_disk43.dsk riven_disk44.dsk \
	riven_disk50.dsk \
	riven_disk60.dsk \
	riven_hgr.2mg
	zip riven_hgr.zip riven_disk00.dsk riven_disk01.dsk \
		riven_disk02.dsk riven_disk03.dsk riven_disk04.dsk \
		riven_disk05.dsk riven_disk06.dsk \
		riven_disk10.dsk \
		riven_disk16.dsk \
		riven_disk38.dsk riven_disk39.dsk \
		riven_disk40.dsk riven_disk41.dsk riven_disk43.dsk \
		riven_disk44.dsk \
		riven_disk50.dsk \
		riven_disk60.dsk
	zip riven_hgr.2mg.zip riven_hgr.2mg

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
	disk00_files/LEVEL_START \
	disk01_files/DISK01 \
	disk01_files/LEVEL_ARRIVAL \
	disk01_files/LEVEL_ARRIVAL2 \
	disk01_files/LEVEL_TELESCOPE \
	disk01_files/LEVEL_ARRIVAL3 \
	disk01_files/LEVEL_PATH \
	disk02_files/DISK02 \
	disk02_files/LEVEL_STEPS1 \
	disk02_files/LEVEL_STEPS3 \
	disk02_files/LEVEL_TOP \
	disk02_files/LEVEL_BRIDGE \
	disk02_files/LEVEL_ALCOVE \
	disk03_files/DISK03 \
	disk03_files/LEVEL_DOWNSTEPS \
	disk03_files/LEVEL_DOWNSTEPS3 \
	disk03_files/LEVEL_OUTSIDE \
	disk03_files/LEVEL_CAVE \
	disk03_files/LEVEL_DOORWAY \
	disk04_files/DISK04 \
	disk04_files/LEVEL_BRIDGE1 \
	disk04_files/LEVEL_BRIDGE2 \
	disk04_files/LEVEL_TUNNEL1 \
	disk04_files/LEVEL_TUNNEL3 \
	disk04_files/LEVEL_TUNNEL4 \
	disk04_files/LEVEL_TUNNEL7 \
	disk05_files/DISK05 \
	disk05_files/LEVEL_CHAIR \
	disk05_files/LEVEL_CHAIR2 \
	disk05_files/MOVIE_CHAIR \
	disk06_files/DISK06 \
	disk06_files/ATRUS_JOURNAL \
	disk10_files/DISK10 \
	disk10_files/LEVEL_CENTER \
	disk10_files/LEVEL_PILLARS \
	disk10_files/LEVEL_15 \
	disk10_files/LEVEL_21 \
	disk10_files/LEVEL_32 \
	disk16_files/DISK16 \
	disk16_files/LEVEL_BRIDGE \
	disk16_files/LEVEL_BRIDGE2 \
	disk16_files/LEVEL_DOME \
	disk38_files/DISK38 \
	disk38_files/LEVEL_PROJECTOR \
	disk38_files/LEVEL_ENTRY \
	disk38_files/LEVEL_CLOSE \
	disk38_files/LEVEL_MID \
	disk39_files/DISK39 \
	disk39_files/LEVEL_MAGSTEPS \
	disk39_files/LEVEL_MAGLEV \
	disk39_files/LEVEL_OUTSIDE \
	disk39_files/LEVEL_PROJECTOR \
	disk39_files/MOVIE_MAGLEV_FLIP \
	disk39_files/MOVIE_MAGLEV_RIDE \
	disk40_files/DISK40 \
	disk40_files/LEVEL_MAGLEV \
	disk40_files/LEVEL_OUTSIDE \
	disk40_files/LEVEL_ORB \
	disk40_files/LEVEL_TUNNEL \
	disk40_files/MOVIE_MAGLEV_FLIP \
	disk40_files/MOVIE_MAGLEV_RIDE \
	disk41_files/DISK41 \
	disk41_files/LEVEL_TUNNEL \
	disk41_files/LEVEL_STAIRS \
	disk41_files/LEVEL_COVE \
	disk41_files/LEVEL_STAIRS2 \
	disk41_files/MOVIE_COVE \
	disk43_files/DISK43 \
	disk43_files/LEVEL_CART \
	disk43_files/LEVEL_BRIDGE \
	disk43_files/LEVEL_LOGGED \
	disk43_files/LEVEL_LOGGED3 \
	disk43_files/LEVEL_LOGGED4 \
	disk43_files/LEVEL_LOGGED5 \
	disk43_files/MOVIE_CART_RIDE \
	disk44_files/DISK44 \
	disk44_files/LEVEL_PATH \
	disk44_files/LEVEL_FISH \
	disk50_files/DISK50 \
	disk50_files/LEVEL_CHIPPER \
	disk60_files/DISK60 \
	disk60_files/LEVEL_SPIRES
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
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 1 0  2` disk01_files/DISK01  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 1 2  0` disk01_files/LEVEL_ARRIVAL      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 1 9  0` disk01_files/LEVEL_ARRIVAL2      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 1 13 0` disk01_files/LEVEL_TELESCOPE    0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 1 19 0` disk01_files/LEVEL_ARRIVAL3      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 1 27 0` disk01_files/LEVEL_PATH      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 2 0  2` disk02_files/DISK02  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 2 2  0` disk02_files/LEVEL_STEPS1      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 2 8  0` disk02_files/LEVEL_STEPS3      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 2 14 0` disk02_files/LEVEL_TOP      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 2 18 0` disk02_files/LEVEL_BRIDGE      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 2 22 0` disk02_files/LEVEL_ALCOVE     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 3 0  2` disk03_files/DISK03  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 3 2  0` disk03_files/LEVEL_DOWNSTEPS     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 3 9  0` disk03_files/LEVEL_DOWNSTEPS3     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 3 15 0` disk03_files/LEVEL_OUTSIDE     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 3 22 0` disk03_files/LEVEL_CAVE     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 3 28 0` disk03_files/LEVEL_DOORWAY     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 4 0  2` disk04_files/DISK04  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 4 2 0` disk04_files/LEVEL_BRIDGE1     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 4 7 0` disk04_files/LEVEL_BRIDGE2     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 4 12 0` disk04_files/LEVEL_TUNNEL1     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 4 17 0` disk04_files/LEVEL_TUNNEL3     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 4 22 0` disk04_files/LEVEL_TUNNEL4     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 4 28 0` disk04_files/LEVEL_TUNNEL7     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 5 0  2` disk05_files/DISK05  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 5 2  0` disk05_files/LEVEL_CHAIR     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 5 8  0` disk05_files/LEVEL_CHAIR2     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 5 15 0` disk05_files/MOVIE_CHAIR     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 6 0  2` disk06_files/DISK06  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 6 2  0` disk06_files/ATRUS_JOURNAL  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 10 0  2` disk10_files/DISK10  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 10 2  0` disk10_files/LEVEL_CENTER     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 10 8  0` disk10_files/LEVEL_15     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 10 11  0` disk10_files/LEVEL_21     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 10 14  0` disk10_files/LEVEL_32     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 10 23  0` disk10_files/LEVEL_PILLARS     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 16 0  2` disk16_files/DISK16  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 16 2  0` disk16_files/LEVEL_BRIDGE      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 16 9  0` disk16_files/LEVEL_BRIDGE2      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 16 15 0` disk16_files/LEVEL_DOME      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 38 0  2` disk38_files/DISK38  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 38 2  0` disk38_files/LEVEL_PROJECTOR      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 38 8  0` disk38_files/LEVEL_ENTRY      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 38 14 0` disk38_files/LEVEL_CLOSE      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 38 20 0` disk38_files/LEVEL_MID      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 39 0  2` disk39_files/DISK39  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 39 2  0` disk39_files/LEVEL_PROJECTOR      0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 39 8  0` disk39_files/LEVEL_OUTSIDE        0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 39 17 0` disk39_files/LEVEL_MAGSTEPS       0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 39 21 0` disk39_files/LEVEL_MAGLEV         0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 39 25 0` disk39_files/MOVIE_MAGLEV_FLIP               0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 39 27 0` disk39_files/MOVIE_MAGLEV_RIDE               0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 40 0  2` disk40_files/DISK40  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 40 2  0` disk40_files/LEVEL_MAGLEV    0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 40 10 0` disk40_files/LEVEL_OUTSIDE   0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 40 15 0` disk40_files/LEVEL_TUNNEL   0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 40 21 0` disk40_files/LEVEL_ORB   0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 40 25 0` disk40_files/MOVIE_MAGLEV_FLIP   0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 40 27 0` disk40_files/MOVIE_MAGLEV_RIDE   0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 41 0  2` disk41_files/DISK41  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 41 2  0` disk41_files/LEVEL_TUNNEL   0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 41 10 0` disk41_files/LEVEL_STAIRS   0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 41 17 0` disk41_files/LEVEL_COVE     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 41 24 0` disk41_files/LEVEL_STAIRS2  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 41 31 0` disk41_files/MOVIE_COVE  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 43 0  2` disk43_files/DISK43  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 43 2  0` disk43_files/LEVEL_CART     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 43 8  0` disk43_files/LEVEL_BRIDGE   0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 43 13 0` disk43_files/LEVEL_LOGGED   0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 43 18 0` disk43_files/LEVEL_LOGGED3  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 43 23 0` disk43_files/LEVEL_LOGGED4  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 43 26 0` disk43_files/LEVEL_LOGGED5  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 43 31 0` disk43_files/MOVIE_CART_RIDE  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 44 0  2` disk44_files/DISK44  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 44 2  0` disk44_files/LEVEL_FISH     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 44 8  0` disk44_files/LEVEL_PATH     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 50 0  2` disk50_files/DISK50  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 50 2  0` disk50_files/LEVEL_CHIPPER     0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 60 0  2` disk60_files/DISK60  0   0
	$(PRODOS_RAW) riven_hgr.2mg `./dts_block 60 2  0` disk60_files/LEVEL_SPIRES     0   0

###

PROBOOTHD:	proboothd.o
	ld65 -o PROBOOTHD proboothd.o -C $(LINKER_SCRIPTS)/apple2_800.inc

proboothd.o:	proboothd.s
	ca65 -o proboothd.o proboothd.s -l proboothd.lst
