include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	ootw_c2_jail.inc

#####

ootw_c2_jail.inc:	\
	jail2_bg.lzsa jail3_bg.lzsa jail4_bg.lzsa dome.lzsa \
	room_b2.lzsa room_b3.lzsa room_b4.lzsa
	echo "jail2_lzsa: .incbin \"jail2_bg.lzsa\"" > ootw_c2_jail.inc
	echo "jail3_lzsa: .incbin \"jail3_bg.lzsa\"" >> ootw_c2_jail.inc
	echo "jail4_lzsa: .incbin \"jail4_bg.lzsa\"" >> ootw_c2_jail.inc
	echo "dome_lzsa: .incbin \"dome.lzsa\"" >> ootw_c2_jail.inc
	echo "room_b2_lzsa: .incbin \"room_b2.lzsa\"" >> ootw_c2_jail.inc
	echo "room_b3_lzsa: .incbin \"room_b3.lzsa\"" >> ootw_c2_jail.inc
	echo "room_b4_lzsa: .incbin \"room_b4.lzsa\"" >> ootw_c2_jail.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.gr *.inc

