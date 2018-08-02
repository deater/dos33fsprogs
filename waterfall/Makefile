include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_RLE = ../gr-utils/png2rle


all:	waterfall.dsk

waterfall.dsk:	WATERFALL
	$(DOS33) -y waterfall.dsk BSAVE -a 0x1000 WATERFALL



####

WATERFALL:	waterfall.o
	ld65 -o WATERFALL waterfall.o -C ../linker_scripts/apple2_1000.inc

waterfall.o:	waterfall.s gr_copy.s gr_unrolled_copy.s \
	put_sprite.s \
	waterfall_page1.inc waterfall_page2.inc tfv_sprites.inc
	ca65 -o waterfall.o waterfall.s -l waterfall.lst

####

waterfall_page1.inc:	waterfall_page1.png
	$(PNG_TO_RLE) asm ./waterfall_page1.png waterfall_page1 > waterfall_page1.inc

waterfall_page2.inc:	waterfall_page2.png
	$(PNG_TO_RLE) asm ./waterfall_page2.png waterfall_page2 > waterfall_page2.inc

#####

clean:		
		rm -f *~ *.o *.lst waterfall_page*.inc WATERFALL


