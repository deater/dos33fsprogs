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

sb.dsk:	QBOOT QLOAD TITLE DUCK_POND SB FN
	cp $(EMPTY_DISK) sb.dsk
	$(DOS33_RAW) sb.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) sb.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) sb.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) sb.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) sb.dsk  2  0 TITLE      0   0
	$(DOS33_RAW) sb.dsk  5  0 DUCK_POND  0   0
	$(DOS33_RAW) sb.dsk  8  0 SB         0   0
	$(DOS33_RAW) sb.dsk 11  0 FN         0   0
#	$(DOS33) -y sb.dsk BSAVE -a 0x1000 DUCK_POND
#	$(DOS33) -y sb.dsk BSAVE -a 0x0c00 SB
#	$(DOS33) -y sb.dsk BSAVE -a 0x6000 FN

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


SB:	sb.o
	ld65 -o SB sb.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

sb.o:	sb.s zx02_optim.s \
		zp.inc hardware.inc
	ca65 -o sb.o sb.s -l sb.lst


####

FN:	fn.o
	ld65 -o FN fn.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

fn.o:	fn.s zx02_optim.s duet.s hgr_sprite_mask.s hgr_sprite.s hgr_tables.s \
		zp.inc hardware.inc \
		fn_sound/fortnight.ed \
		fn_graphics/a2_fortnight.hgr.zx02 \
		fn_graphics/a2_fortnight_99.hgr.zx02 \
		fn_graphics/a2_fortnight_100.hgr.zx02 \
		fn_graphics/a2_fortnight_rat1.hgr.zx02 \
		fn_graphics/a2_fortnight_rat2.hgr.zx02 \
		fn_graphics/a2_break.hgr.zx02 \
		fn_graphics/disk_sprites.inc
	ca65 -o fn.o fn.s -l fn.lst


####

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

title.o:	title.s zx02_optim.s \
		zp.inc hardware.inc \
		hgr_vscroll.s \
		graphics/czmg4ap_title.hgr.zx02 \
		graphics/videlectrix_top.hgr.zx02
	ca65 -o title.o title.s -l title.lst


####

DUCK_POND:	duck_pond.o
	ld65 -o DUCK_POND duck_pond.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

duck_pond.o:	duck_pond.s zx02_optim.s \
		zp.inc hardware.inc \
		gr_copy.s duck_score.s gr_putsprite_mask.s \
		draw_ducks.s move_ducks.s \
		graphics/duck_sprites.inc graphics/num_sprites.inc
	ca65 -o duck_pond.o duck_pond.s -l duck_pond.lst


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
	rm -f *.lst *.o TITLE SB FN DUCK_POND *~
