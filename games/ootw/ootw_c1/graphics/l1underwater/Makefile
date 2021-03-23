include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_underwater.inc

#####

ootw_underwater.inc:	another_uboot.lzsa ootw_uboot_bg.lzsa \
	ootw_uboot_flash1.lzsa ootw_uboot_flash2.lzsa
	echo "underwater_lzsa: .incbin \"ootw_uboot_bg.lzsa\"" > ootw_underwater.inc
	echo "uboot_flash1_lzsa: .incbin \"ootw_uboot_flash1.lzsa\"" >> ootw_underwater.inc
	echo "uboot_flash2_lzsa: .incbin \"ootw_uboot_flash2.lzsa\"" >> ootw_underwater.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.inc *.gr *.lzsa

