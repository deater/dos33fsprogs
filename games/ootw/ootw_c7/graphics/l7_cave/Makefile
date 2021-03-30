include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c7_cave.inc

#####

ootw_c7_cave.inc:	\
	cave.lzsa
	echo "cave_lzsa: .incbin \"cave.lzsa\"" > ootw_c7_cave.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.inc

