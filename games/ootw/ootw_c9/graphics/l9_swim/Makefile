include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c9_swim.inc

#####

ootw_c9_swim.inc:	\
	pool.lzsa
	echo "pool_lzsa: .incbin \"pool.lzsa\"" > ootw_c9_swim.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.inc

