include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_beast_end.inc

#####

ootw_beast_end.inc:	\
	beast_bg.lzsa \
	beast_slash07.lzsa beast_slash08.lzsa beast_slash09.lzsa \
	beast_slash10.lzsa beast_slash11.lzsa beast_slash12.lzsa \
	beast_slash13.lzsa beast_slash14.lzsa beast_slash15.lzsa \
	beast_slash16.lzsa beast_slash17.lzsa beast_slash18.lzsa \
	beast_slash19.lzsa beast_slash20.lzsa
	echo "beast_bg_lzsa: .incbin \"beast_bg.lzsa\"" > ootw_beast_end.inc
	echo "beast_slash07_lzsa: .incbin \"beast_slash07.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash08_lzsa: .incbin \"beast_slash08.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash09_lzsa: .incbin \"beast_slash09.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash10_lzsa: .incbin \"beast_slash10.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash11_lzsa: .incbin \"beast_slash11.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash12_lzsa: .incbin \"beast_slash12.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash13_lzsa: .incbin \"beast_slash13.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash14_lzsa: .incbin \"beast_slash14.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash15_lzsa: .incbin \"beast_slash15.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash16_lzsa: .incbin \"beast_slash16.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash17_lzsa: .incbin \"beast_slash17.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash18_lzsa: .incbin \"beast_slash18.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash19_lzsa: .incbin \"beast_slash19.lzsa\"" >> ootw_beast_end.inc
	echo "beast_slash20_lzsa: .incbin \"beast_slash20.lzsa\"" >> ootw_beast_end.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.gr *.inc

