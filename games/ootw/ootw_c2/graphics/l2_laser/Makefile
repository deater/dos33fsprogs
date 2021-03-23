include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c2_laser.inc

#####

ootw_c2_laser.inc:	$(PNG2RLE) \
	laser_bg.png \
	laserg01.png laserg02.png laserg03.png laserg04.png \
	laserg05.png laserg06.png laserg07.png laserg08.png blank.png
	$(PNG2RLE) asm laser_bg.png laser_bg_rle > ootw_c2_laser.inc
	$(PNG2RLE) asm laserg01.png laserg_01_rle >> ootw_c2_laser.inc
	$(PNG2RLE) asm laserg02.png laserg_02_rle >> ootw_c2_laser.inc
	$(PNG2RLE) asm laserg03.png laserg_03_rle >> ootw_c2_laser.inc
	$(PNG2RLE) asm laserg04.png laserg_04_rle >> ootw_c2_laser.inc
	$(PNG2RLE) asm laserg05.png laserg_05_rle >> ootw_c2_laser.inc
	$(PNG2RLE) asm laserg06.png laserg_06_rle >> ootw_c2_laser.inc
	$(PNG2RLE) asm laserg07.png laserg_07_rle >> ootw_c2_laser.inc
	$(PNG2RLE) asm laserg08.png laserg_08_rle >> ootw_c2_laser.inc
	$(PNG2RLE) asm blank.png laserg_blank_rle >> ootw_c2_laser.inc


#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

