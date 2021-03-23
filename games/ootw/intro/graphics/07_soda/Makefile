include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa


all:	intro_open_soda.inc intro_drinking.inc


#####

intro_open_soda.inc:	soda_bg.lzsa \
		soda01.lzsa soda02.lzsa soda03.lzsa \
		soda04.lzsa soda05.lzsa soda06.lzsa \
		soda07.lzsa soda08.lzsa soda09.lzsa
	echo "soda_bg_lzsa: .incbin \"soda_bg.lzsa\"" > intro_open_soda.inc
	echo "soda01_lzsa: .incbin \"soda01.lzsa\"" >> intro_open_soda.inc
	echo "soda02_lzsa: .incbin \"soda02.lzsa\"" >> intro_open_soda.inc
	echo "soda03_lzsa: .incbin \"soda03.lzsa\"" >> intro_open_soda.inc
	echo "soda04_lzsa: .incbin \"soda04.lzsa\"" >> intro_open_soda.inc
	echo "soda05_lzsa: .incbin \"soda05.lzsa\"" >> intro_open_soda.inc
	echo "soda06_lzsa: .incbin \"soda06.lzsa\"" >> intro_open_soda.inc
	echo "soda07_lzsa: .incbin \"soda07.lzsa\"" >> intro_open_soda.inc
	echo "soda08_lzsa: .incbin \"soda08.lzsa\"" >> intro_open_soda.inc
	echo "soda09_lzsa: .incbin \"soda09.lzsa\"" >> intro_open_soda.inc

#####


intro_drinking.inc:	\
	drinking02.lzsa drinking03.lzsa drinking04.lzsa drinking05.lzsa
	echo "drinking02_lzsa: .incbin \"drinking02.lzsa\"" > intro_drinking.inc
	echo "drinking03_lzsa: .incbin \"drinking03.lzsa\"" >> intro_drinking.inc
	echo "drinking04_lzsa: .incbin \"drinking04.lzsa\"" >> intro_drinking.inc
	echo "drinking05_lzsa: .incbin \"drinking05.lzsa\"" >> intro_drinking.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa
