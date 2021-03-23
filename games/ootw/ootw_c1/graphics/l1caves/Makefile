include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_cavern.inc ootw_cavern2.inc ootw_cavern3.inc

#####

ootw_cavern.inc:	another_cave.lzsa
	echo "cavern_lzsa: .incbin \"another_cave.lzsa\"" > ootw_cavern.inc

ootw_cavern2.inc:	another_cave2.lzsa
	echo "cavern2_lzsa: .incbin \"another_cave2.lzsa\"" > ootw_cavern2.inc

ootw_cavern3.inc:	another_cave3.lzsa
	echo "cavern3_lzsa: .incbin \"another_cave3.lzsa\"" > ootw_cavern3.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.gr *.inc *.lzsa

