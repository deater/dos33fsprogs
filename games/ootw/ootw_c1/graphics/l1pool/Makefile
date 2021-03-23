include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_pool.inc

#####

ootw_pool.inc:	another_pool.lzsa
	echo "pool_lzsa: .incbin \"another_pool.lzsa\"" > ootw_pool.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.inc *.gr *.lzsa

