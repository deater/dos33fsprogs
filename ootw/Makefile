include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2RLE = ../gr-utils/png2rle


all:	ootw.dsk

ootw.dsk:	HELLO OOTW
	$(DOS33) -y ootw.dsk SAVE A HELLO
	$(DOS33) -y ootw.dsk BSAVE -a 0x1000 OOTW

####

OOTW:	ootw.o
	ld65 -o OOTW ootw.o -C ../linker_scripts/apple2_1000.inc

ootw.o:	ootw.s wait_keypress.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s gr_putsprite.s \
	ootw_backgrounds.inc ootw_sprites.inc
	ca65 -o ootw.o ootw.s -l ootw.lst
####

HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


#####

ootw_backgrounds.inc:	$(PNG2RLE) another.png
	$(PNG2RLE) asm another.png planet_rle > ootw_backgrounds.inc

#####

clean:		
		rm -f *~ *.o *.lst HELLO OOTW



