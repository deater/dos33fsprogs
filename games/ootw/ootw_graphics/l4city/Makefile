include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c4_city.inc

#####

ootw_c4_city.inc:	$(PNG2RLE) \
	recharge.png hallway.png causeway1.png causeway2.png pit.png
	$(PNG2RLE) asm recharge.png recharge_rle > ootw_c4_city.inc
	$(PNG2RLE) asm hallway.png hallway_rle >> ootw_c4_city.inc
	$(PNG2RLE) asm causeway1.png causeway1_rle >> ootw_c4_city.inc
	$(PNG2RLE) asm causeway2.png causeway2_rle >> ootw_c4_city.inc
	$(PNG2RLE) asm pit.png pit_rle >> ootw_c4_city.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

