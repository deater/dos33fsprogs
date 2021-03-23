include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c5_cave.inc

#####

ootw_c5_cave.inc:	entrance_cave.lzsa
	echo "entrance_lzsa: .incbin \"entrance_cave.lzsa\"" > ootw_c5_cave.inc


#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.gr *.inc

