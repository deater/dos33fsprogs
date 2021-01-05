include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_beast_end.inc

#####

ootw_beast_end.inc:	$(PNG2RLE) \
	beast_bg.png \
	beast_slash07.png beast_slash08.png beast_slash09.png \
	beast_slash10.png beast_slash11.png beast_slash12.png \
	beast_slash13.png beast_slash14.png beast_slash15.png \
	beast_slash16.png beast_slash17.png beast_slash18.png \
	beast_slash19.png beast_slash20.png
	$(PNG2RLE) asm beast_bg.png beast_bg_rle > ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash07.png beast_slash07_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash08.png beast_slash08_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash09.png beast_slash09_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash10.png beast_slash10_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash11.png beast_slash11_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash12.png beast_slash12_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash13.png beast_slash13_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash14.png beast_slash14_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash15.png beast_slash15_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash16.png beast_slash16_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash17.png beast_slash17_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash18.png beast_slash18_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash19.png beast_slash19_rle >> ootw_beast_end.inc
	$(PNG2RLE) asm beast_slash20.png beast_slash20_rle >> ootw_beast_end.inc



#####

clean:		
		rm -f *~ *.o *.lst *.lzz ootw_beast_end.inc

