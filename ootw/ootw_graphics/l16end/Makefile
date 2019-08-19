include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c16_end.inc

#####

ootw_c16_end.inc:	$(PNG2RLE) \
	flying.png rooftop.png sky_bg.png the_end.png
	$(PNG2RLE) asm sky_bg.png sky_bg_rle > ootw_c16_end.inc
	$(PNG2RLE) asm rooftop.png rooftop_rle >> ootw_c16_end.inc
	$(PNG2RLE) asm flying.png flying_rle >> ootw_c16_end.inc
	$(PNG2RLE) asm the_end.png the_end_rle >> ootw_c16_end.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

