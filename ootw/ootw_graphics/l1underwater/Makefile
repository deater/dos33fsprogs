include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	ootw_underwater.inc

#####

ootw_underwater.inc:	$(PNG2RLE) another_uboot.png
	$(PNG2RLE) asm ootw_uboot_bg.png underwater_rle > ootw_underwater.inc
	$(PNG2RLE) asm ootw_uboot_flash1.png uboot_flash1_rle >> ootw_underwater.inc
	$(PNG2RLE) asm ootw_uboot_flash2.png uboot_flash2_rle >> ootw_underwater.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lzz *.inc

