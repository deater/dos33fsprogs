include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	starbase.inc ship_flames.inc star_wipe.inc

#####

starbase.inc:	$(PNG2RLE) \
	jail.png hallway.png window.png ship.png
	$(PNG2RLE) asm jail.png jail_rle > starbase.inc
	$(PNG2RLE) asm hallway.png hallway_rle >> starbase.inc
	$(PNG2RLE) asm window.png window_rle >> starbase.inc
	$(PNG2RLE) asm ship.png ship_rle >> starbase.inc

ship_flames.inc:	$(PNG2RLE) \
	ship_flame0.png ship_flame1.png ship_flame2.png ship_flame3.png \
	ship_flame4.png ship_flame5.png
	$(PNG2RLE) asm ship_flame0.png ship_flame0_rle > ship_flames.inc
	$(PNG2RLE) asm ship_flame1.png ship_flame1_rle >> ship_flames.inc
	$(PNG2RLE) asm ship_flame2.png ship_flame2_rle >> ship_flames.inc
	$(PNG2RLE) asm ship_flame3.png ship_flame3_rle >> ship_flames.inc
	$(PNG2RLE) asm ship_flame4.png ship_flame4_rle >> ship_flames.inc
	$(PNG2RLE) asm ship_flame5.png ship_flame5_rle >> ship_flames.inc

star_wipe.inc:	$(PNG2RLE) \
	star1.png star2.png star3.png star4.png star5.png empty.png
	$(PNG2RLE) asm star1.png star_wipe1_rle > star_wipe.inc
	$(PNG2RLE) asm star2.png star_wipe2_rle >> star_wipe.inc
	$(PNG2RLE) asm star3.png star_wipe3_rle >> star_wipe.inc
	$(PNG2RLE) asm star4.png star_wipe4_rle >> star_wipe.inc
	$(PNG2RLE) asm star5.png star_wipe5_rle >> star_wipe.inc
	$(PNG2RLE) asm empty.png empty_rle >> star_wipe.inc


#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

