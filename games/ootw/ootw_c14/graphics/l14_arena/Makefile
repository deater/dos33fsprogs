include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c14_arena.inc

#####

ootw_c14_arena.inc:	\
	arena.lzsa
	echo "arena_lzsa: .incbin \"arena.lzsa\"" > ootw_c14_arena.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.inc
