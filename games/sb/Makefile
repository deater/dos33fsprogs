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

sb.dsk:	QBOOT QLOAD TITLE DUCK_POND ROOF ASPLODE TARGET CLIFF RAT
	cp $(EMPTY_DISK) sb.dsk
	$(DOS33_RAW) sb.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) sb.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) sb.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) sb.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) sb.dsk  2  0 TITLE      0   0
	$(DOS33_RAW) sb.dsk  5  0 DUCK_POND  0   0
	$(DOS33_RAW) sb.dsk  10 0 ROOF       0   0
	$(DOS33_RAW) sb.dsk  15 0 ASPLODE    0   0
	$(DOS33_RAW) sb.dsk  20 0 TARGET     0   0
	$(DOS33_RAW) sb.dsk  25 0 CLIFF      0   0
	$(DOS33_RAW) sb.dsk  30 0 RAT        0   0

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
		zp.inc hardware.inc
	ca65 -o roof.o roof.s -l roof.lst


####

ASPLODE:	asplode.o
	ld65 -o ASPLODE asplode.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

asplode.o:	asplode.s zx02_optim.s \
		asplode_graphics/sb_title.hgr.zx02 \
		asplode_graphics/sb_zone.hgr.zx02 \
		asplode_graphics/sb_sprites.inc \
		hgr_sprite_big.s \
		zp.inc hardware.inc
	ca65 -o asplode.o asplode.s -l asplode.lst



####

CLIFF:	cliff.o
	ld65 -o CLIFF cliff.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

cliff.o:	cliff.s zx02_optim.s \
		cliff_graphics/cliff_base.hgr.zx02 \
		zp.inc hardware.inc
	ca65 -o cliff.o cliff.s -l cliff.lst

####

TARGET:	target.o
	ld65 -o TARGET target.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

target.o:	target.s zx02_optim.s \
		target_graphics/target.hgr.zx02 \
		zp.inc hardware.inc
	ca65 -o target.o target.s -l target.lst




####

RAT:	rat.o
	ld65 -o RAT rat.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

rat.o:	rat.s zx02_optim.s duet.s hgr_sprite_mask.s hgr_sprite.s hgr_tables.s \
		zp.inc hardware.inc \
		rat_sound/fortnight.ed \
		rat_graphics/a2_fortnight.hgr.zx02 \
		rat_graphics/a2_fortnight_99.hgr.zx02 \
		rat_graphics/a2_fortnight_100.hgr.zx02 \
		rat_graphics/a2_fortnight_rat1.hgr.zx02 \
		rat_graphics/a2_fortnight_rat2.hgr.zx02 \
		rat_graphics/a2_break.hgr.zx02 \
		rat_graphics/disk_sprites.inc
	ca65 -o rat.o rat.s -l rat.lst


####

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

title.o:	title.s zx02_optim.s \
		zp.inc hardware.inc \
		hgr_logo_scroll.s audio.s hgr_sprite.s \
		purple.s lc_detect.s \
		title_sound/purple.btc.zx02 \
		title_graphics/czmg4ap_title.hgr.zx02 \
		title_graphics/videlectrix_top.hgr.zx02 \
		title_graphics/the_cheat_loading.hgr.zx02 \
		title_graphics/title_sprites.inc
	ca65 -o title.o title.s -l title.lst


####

DUCK_POND:	duck_pond.o
	ld65 -o DUCK_POND duck_pond.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

duck_pond.o:	duck_pond.s zx02_optim.s \
		zp.inc hardware.inc \
		gr_copy.s duck_score.s gr_putsprite_mask.s \
		draw_ducks.s move_ducks.s \
		duck_graphics/duck_sprites.inc duck_graphics/num_sprites.inc
	ca65 -o duck_pond.o duck_pond.s -l duck_pond.lst


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
	rm -f *.lst *.o QBOOT QLOAD TITLE DUCK_POND ROOF ASPLODE TARGET CLIFF RAT *~
