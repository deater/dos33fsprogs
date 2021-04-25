include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c14_arena.inc

#####

ootw_c14_arena.inc:	\
	arena.lzsa inside_bg.lzsa \
	inside03.lzsa inside04.lzsa inside05.lzsa inside06.lzsa \
	inside07.lzsa inside08.lzsa inside09.lzsa inside10.lzsa \
	inside11.lzsa inside12.lzsa inside13.lzsa inside14.lzsa \
	inside15.lzsa inside16.lzsa inside17.lzsa inside18.lzsa
	echo "arena_lzsa: .incbin \"arena.lzsa\"" > ootw_c14_arena.inc
	echo "inside_bg_lzsa: .incbin \"inside_bg.lzsa\"" >> ootw_c14_arena.inc
	echo "inside03_lzsa: .incbin \"inside03.lzsa\"" >> ootw_c14_arena.inc
	echo "inside04_lzsa: .incbin \"inside04.lzsa\"" >> ootw_c14_arena.inc
	echo "inside05_lzsa: .incbin \"inside05.lzsa\"" >> ootw_c14_arena.inc
	echo "inside06_lzsa: .incbin \"inside06.lzsa\"" >> ootw_c14_arena.inc
	echo "inside07_lzsa: .incbin \"inside07.lzsa\"" >> ootw_c14_arena.inc
	echo "inside08_lzsa: .incbin \"inside08.lzsa\"" >> ootw_c14_arena.inc
	echo "inside09_lzsa: .incbin \"inside09.lzsa\"" >> ootw_c14_arena.inc
	echo "inside10_lzsa: .incbin \"inside10.lzsa\"" >> ootw_c14_arena.inc
	echo "inside11_lzsa: .incbin \"inside11.lzsa\"" >> ootw_c14_arena.inc
	echo "inside12_lzsa: .incbin \"inside12.lzsa\"" >> ootw_c14_arena.inc
	echo "inside13_lzsa: .incbin \"inside13.lzsa\"" >> ootw_c14_arena.inc
	echo "inside14_lzsa: .incbin \"inside14.lzsa\"" >> ootw_c14_arena.inc
	echo "inside15_lzsa: .incbin \"inside15.lzsa\"" >> ootw_c14_arena.inc
	echo "inside16_lzsa: .incbin \"inside16.lzsa\"" >> ootw_c14_arena.inc
	echo "inside17_lzsa: .incbin \"inside17.lzsa\"" >> ootw_c14_arena.inc
	echo "inside18_lzsa: .incbin \"inside18.lzsa\"" >> ootw_c14_arena.inc



#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.inc
