include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_c2_jail.inc

#####

ootw_c2_jail.inc:	$(PNG2RLE) \
	jail2_bg.png jail3_bg.png jail4_bg.png dome.png \
	room_b2.png room_b3.png room_b4.png
	$(PNG2RLE) asm jail2_bg.png jail2_rle > ootw_c2_jail.inc
	$(PNG2RLE) asm jail3_bg.png jail3_rle >> ootw_c2_jail.inc
	$(PNG2RLE) asm jail4_bg.png jail4_rle >> ootw_c2_jail.inc
	$(PNG2RLE) asm dome.png dome_rle >> ootw_c2_jail.inc
	$(PNG2RLE) asm room_b2.png room_b2_rle >> ootw_c2_jail.inc
	$(PNG2RLE) asm room_b3.png room_b3_rle >> ootw_c2_jail.inc
	$(PNG2RLE) asm room_b4.png room_b4_rle >> ootw_c2_jail.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

