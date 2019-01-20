include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2RLE = ../gr-utils/png2rle


all:	ootw.dsk

ootw.dsk:	HELLO OOTW
	$(DOS33) -y ootw.dsk SAVE A HELLO
	$(DOS33) -y ootw.dsk BSAVE -a 0x2000 OOTW

####

OOTW:	ootw.o
	ld65 -o OOTW ootw.o -C ../linker_scripts/apple2_2000.inc

ootw.o:	ootw.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s gr_putsprite.s \
	keyboard.s sluggy.s \
	ootw_rope.s \
	ootw_pool.s ootw_cavern.s physicist.s random16.s slug_cutscene.s \
	ootw_pool.inc \
	ootw_cavern.inc ootw_cavern2.inc ootw_cavern3.inc \
	ootw_rope.inc ootw_sprites.inc
	ca65 -o ootw.o ootw.s -l ootw.lst
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

#####

clean:		
		rm -f *~ *.o *.lst HELLO OOTW



