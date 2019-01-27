include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2RLE = ../gr-utils/png2rle


all:	ootw.dsk

ootw.dsk:	HELLO OOTW INTRO
	$(DOS33) -y ootw.dsk SAVE A HELLO
	$(DOS33) -y ootw.dsk BSAVE -a 0x2000 OOTW
	$(DOS33) -y ootw.dsk BSAVE -a 0x2000 INTRO

####

OOTW:	ootw.o
	ld65 -o OOTW ootw.o -C ../linker_scripts/apple2_2000.inc

ootw.o:	ootw.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s gr_putsprite.s \
	keyboard.s sluggy.s \
	ootw_rope.s earthquake.s ootw_mesa.s \
	ootw_pool.s ootw_cavern.s physicist.s random16.s \
	cutscene_slug.s cutscene_beast.s \
	ootw_pool.inc \
	ootw_cavern.inc ootw_cavern2.inc ootw_cavern3.inc ootw_underwater.inc \
	ootw_rope.inc \
	sprites_physicist.inc sprites_slugs.inc \
	sprites_ootw.inc sprites_beast.inc
	ca65 -o ootw.o ootw.s -l ootw.lst
####

INTRO:	intro.o
	ld65 -o INTRO intro.o -C ../linker_scripts/apple2_2000.inc

intro.o:	intro.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s gr_putsprite.s \
	keyboard.s random16.s \
	intro_building.inc
	ca65 -o intro.o intro.s -l intro.lst
####


HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


#####

ootw_pool.inc:	$(PNG2RLE) another.png
	$(PNG2RLE) asm another.png pool_rle > ootw_pool.inc

ootw_cavern.inc:	$(PNG2RLE) another_cave.png
	$(PNG2RLE) asm another_cave.png cavern_rle > ootw_cavern.inc

ootw_cavern2.inc:	$(PNG2RLE) another_cave2.png
	$(PNG2RLE) asm another_cave2.png cavern2_rle > ootw_cavern2.inc

ootw_cavern3.inc:	$(PNG2RLE) another_cave3.png
	$(PNG2RLE) asm another_cave3.png cavern3_rle > ootw_cavern3.inc

ootw_rope.inc:	$(PNG2RLE) another_rope.png
	$(PNG2RLE) asm another_rope.png rope_rle > ootw_rope.inc

ootw_underwater.inc:	$(PNG2RLE) another_uboot.png
	$(PNG2RLE) asm another_uboot.png underwater_rle > ootw_underwater.inc


#####

intro_building.inc:	$(PNG2RLE) intro1_building.png
	$(PNG2RLE) asm intro1_building.png building_rle > intro_building.inc

#####

clean:		
		rm -f *~ *.o *.lst HELLO OOTW



