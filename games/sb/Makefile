include ../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	sb.dsk

####

sb.dsk:	HELLO TITLE DUCK_POND SB FN
	cp $(EMPTY_DISK) sb.dsk
	$(DOS33) -y sb.dsk SAVE A HELLO
	$(DOS33) -y sb.dsk BSAVE -a 0x0c00 TITLE
	$(DOS33) -y sb.dsk BSAVE -a 0x1000 DUCK_POND
	$(DOS33) -y sb.dsk BSAVE -a 0x0c00 SB
	$(DOS33) -y sb.dsk BSAVE -a 0x6000 FN

####

SB:	sb.o
	ld65 -o SB sb.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

sb.o:	sb.s zx02_optim.s \
		zp.inc hardware.inc
	ca65 -o sb.o sb.s -l sb.lst


####

FN:	fn.o
	ld65 -o FN fn.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

fn.o:	fn.s zx02_optim.s duet.s hgr_sprite_mask.s hgr_tables.s \
		zp.inc hardware.inc \
		fn_sound/fortnight.ed \
		fn_graphics/a2_fortnight.hgr.zx02 \
		fn_graphics/a2_fortnight_rat1.hgr.zx02 \
		fn_graphics/a2_fortnight_rat2.hgr.zx02 \
		fn_graphics/disk_sprites.inc
	ca65 -o fn.o fn.s -l fn.lst


####

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

title.o:	title.s zx02_optim.s \
		zp.inc hardware.inc
	ca65 -o title.o title.s -l title.lst


####

DUCK_POND:	duck_pond.o
	ld65 -o DUCK_POND duck_pond.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

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
