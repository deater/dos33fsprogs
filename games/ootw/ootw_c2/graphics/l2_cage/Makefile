include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c2_cage.inc

#####

ootw_c2_cage.inc:	\
	ootw_c2_nocage.lzsa ootw_c2_cage_fell.lzsa \
	debris1.lzsa debris2.lzsa debris3.lzsa
	echo "cage_fell_lzsa: .incbin \"ootw_c2_cage_fell.lzsa\"" > ootw_c2_cage.inc
	echo "cage_lzsa: .incbin \"ootw_c2_nocage.lzsa\"" >> ootw_c2_cage.inc
	echo "debris1_lzsa: .incbin \"debris1.lzsa\"" >> ootw_c2_cage.inc
	echo "debris2_lzsa: .incbin \"debris2.lzsa\"" >> ootw_c2_cage.inc
	echo "debris3_lzsa: .incbin \"debris3.lzsa\"" >> ootw_c2_cage.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@


#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.gr *.inc

