include ../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	sb.dsk

####

sb.dsk:	QBOOT QLOAD TITLE ./duck_pond/DUCK_POND ROOF ASPLODE BACK_OFF \
	./fish/FISH ./rat/RAT ./dating/DATING_XR
	cp $(EMPTY_DISK) sb.dsk
	$(DOS33_RAW) sb.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) sb.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) sb.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) sb.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) sb.dsk  2  0 TITLE      0   0
	$(DOS33_RAW) sb.dsk  5  0 ./duck_pond/DUCK_POND  0   0
	$(DOS33_RAW) sb.dsk  8  0 ROOF       0   0
	$(DOS33_RAW) sb.dsk  9  0 ASPLODE    0   0
#	$(DOS33_RAW) sb.dsk  20 0 TARGET     0   0
	$(DOS33_RAW) sb.dsk  14 0 ./fish/FISH      0   0
	$(DOS33_RAW) sb.dsk  20 0 ./rat/RAT        0   0
	$(DOS33_RAW) sb.dsk  22 0 BACK_OFF   0   0
	$(DOS33_RAW) sb.dsk  24 0 ../peasant_mini/cliff/CLIMB   0   0
	$(DOS33_RAW) sb.dsk  28 0 ./dating/DATING_XR  0   0

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	qload.s qboot.inc
	ca65 -o qload.o qload.s -l qload.lst

####

ROOF:	roof.o
	ld65 -o ROOF roof.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

roof.o:	roof.s zx02_optim.s \
		roof_graphics/strongbad_sample.hgr.zx02 \
		zp.inc hardware.inc
	ca65 -o roof.o roof.s -l roof.lst

roof_graphics/strongbad_sample.hgr.zx02:	
	cd roof_graphics && make

####

ASPLODE:	asplode.o
	ld65 -o ASPLODE asplode.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

asplode.o:	asplode.s zx02_optim.s \
		asplode_graphics/sb_title.hgr.zx02 \
		asplode_graphics/sb_zone.hgr.zx02 \
		asplode_graphics/sb_sprites.inc \
		asplode_sound/asplode_sound.btc.zx02 \
		audio.s play_asplode.s asplode_head.s \
		hgr_sprite_big.s cycle_colors.s \
		zp.inc hardware.inc
	ca65 -o asplode.o asplode.s -l asplode.lst

asplode_graphics/sb_sprites.inc:	
	cd asplode_graphics && make

asplode_graphics/sb_title.hgr.zx02:	
	cd asplode_graphics && make

asplode_sound/asplode.btc.zx02:	
	cd asplode_sound && make


####

BACK_OFF:	back_off.o
	ld65 -o BACK_OFF back_off.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

back_off.o:	back_off.s zx02_optim.s \
		asplode_graphics/bob_bg.hgr.zx02 \
		asplode_graphics/bob_sprites.inc \
		asplode_sound/back_off.btc.zx02 \
		audio.s play_back_off.s \
		hgr_sprite_big.s \
		zp.inc hardware.inc
	ca65 -o back_off.o back_off.s -l back_off.lst

####

#./cliff/CLIFF:	
#	cd cliff && make

####

./fish/FISH:	
	cd fish && make

####

./dating/DATING_XR:	
	cd dating && make


####

TARGET:	target.o
	ld65 -o TARGET target.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

target.o:	target.s zx02_optim.s \
		target_graphics/target.hgr.zx02 \
		zp.inc hardware.inc
	ca65 -o target.o target.s -l target.lst

target_graphics/target.hgr.zx02:	
	cd target_graphics && make


####

./rat/RAT:	
	cd rat && make

####

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

title.o:	title.s zx02_optim.s \
		zp.inc hardware.inc \
		hgr_logo_scroll.s audio.s hgr_sprite.s \
		hgr_sprite_big.s hgr_copy_fast.s \
		play_purple.s lc_detect.s hgr_tables.s \
		title_sound/purple.btc.zx02 \
		title_graphics/czmg4ap_title.hgr.zx02 \
		title_graphics/videlectrix_top.hgr.zx02 \
		title_graphics/the_cheat_loading.hgr.zx02 \
		title_graphics/title_sprites.inc
	ca65 -o title.o title.s -l title.lst

title_sound/purple.btc.zx02:
	cd title_sound && make

title_graphics/czmg4ap_title.hgr.zx02:	
	cd title_graphics && make

####

./duck_pond/DUCK_POND:	
	cd duck_pond && make

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
	rm -f *.lst *.o *~ QBOOT QLOAD TITLE ROOF ASPLODE
	cd duck_pond && make clean
	cd rat && make clean
	cd asplode_sound && make clean
	cd dating && make clean
	cd rat_sound && make clean
	cd title_sound && make clean
	cd asplode_graphics && make clean
	cd roof_graphics && make clean
	cd title_graphics && make clean

distclean:
	rm -f *.lst *.o *~ QBOOT QLOAD TITLE ROOF ASPLODE
	cd duck_pond && make distclean
	cd rat && make distclean
