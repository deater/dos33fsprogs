include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c8_crawl.inc

#####

ootw_c8_crawl.inc:	\
	entry.lzsa
	echo "entry_lzsa: .incbin \"entry.lzsa\"" > ootw_c8_crawl.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.inc

