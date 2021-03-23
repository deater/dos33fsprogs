include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_rope.inc ootw_swing.inc

#####

ootw_rope.inc:	another_rope.lzsa another_norope.lzsa another_brokerope.lzsa
	echo "rope_lzsa: .incbin \"another_rope.lzsa\"" > ootw_rope.inc
	echo "no_rope_lzsa: .incbin \"another_norope.lzsa\"" >> ootw_rope.inc
	echo "broke_rope_lzsa: .incbin \"another_brokerope.lzsa\"" >> ootw_rope.inc

#####

ootw_swing.inc:	\
	another_swing01.lzsa another_swing02.lzsa another_swing03.lzsa \
	another_swing04.lzsa another_swing05.lzsa another_swing06.lzsa \
	another_swing08.lzsa \
	another_swing10.lzsa another_swing11.lzsa another_swing12.lzsa \
	another_swing13.lzsa another_swing14.lzsa another_swing15.lzsa \
	another_swing16.lzsa another_swing17.lzsa another_swing18.lzsa \
	another_swing19.lzsa another_swing20.lzsa another_swing21.lzsa \
	another_swing22.lzsa another_swing23.lzsa another_swing24.lzsa \
	another_swing25.lzsa
	echo "swing01_lzsa: .incbin \"another_swing01.lzsa\"" > ootw_swing.inc
	echo "swing02_lzsa: .incbin \"another_swing02.lzsa\"" >> ootw_swing.inc
	echo "swing03_lzsa: .incbin \"another_swing03.lzsa\"" >> ootw_swing.inc
	echo "swing04_lzsa: .incbin \"another_swing04.lzsa\"" >> ootw_swing.inc
	echo "swing05_lzsa: .incbin \"another_swing05.lzsa\"" >> ootw_swing.inc
	echo "swing06_lzsa: .incbin \"another_swing06.lzsa\"" >> ootw_swing.inc
	echo "swing08_lzsa: .incbin \"another_swing08.lzsa\"" >> ootw_swing.inc
	echo "swing10_lzsa: .incbin \"another_swing10.lzsa\"" >> ootw_swing.inc
	echo "swing11_lzsa: .incbin \"another_swing11.lzsa\"" >> ootw_swing.inc
	echo "swing12_lzsa: .incbin \"another_swing12.lzsa\"" >> ootw_swing.inc
	echo "swing13_lzsa: .incbin \"another_swing13.lzsa\"" >> ootw_swing.inc
	echo "swing14_lzsa: .incbin \"another_swing14.lzsa\"" >> ootw_swing.inc
	echo "swing15_lzsa: .incbin \"another_swing15.lzsa\"" >> ootw_swing.inc
	echo "swing16_lzsa: .incbin \"another_swing16.lzsa\"" >> ootw_swing.inc
	echo "swing17_lzsa: .incbin \"another_swing17.lzsa\"" >> ootw_swing.inc
	echo "swing18_lzsa: .incbin \"another_swing18.lzsa\"" >> ootw_swing.inc
	echo "swing19_lzsa: .incbin \"another_swing19.lzsa\"" >> ootw_swing.inc
	echo "swing20_lzsa: .incbin \"another_swing20.lzsa\"" >> ootw_swing.inc
	echo "swing21_lzsa: .incbin \"another_swing21.lzsa\"" >> ootw_swing.inc
	echo "swing22_lzsa: .incbin \"another_swing22.lzsa\"" >> ootw_swing.inc
	echo "swing23_lzsa: .incbin \"another_swing23.lzsa\"" >> ootw_swing.inc
	echo "swing24_lzsa: .incbin \"another_swing24.lzsa\"" >> ootw_swing.inc
	echo "swing25_lzsa: .incbin \"another_swing25.lzsa\"" >> ootw_swing.inc

#####

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.inc *.gr *.lzsa

