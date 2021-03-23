include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	intro_scanner.inc intro_scanning.inc intro_ai_bg.inc intro_ai.inc


#####

intro_ai_bg.inc:	ai_background.lzsa
	echo "ai_bg_lzsa: .incbin \"ai_background.lzsa\"" > intro_ai_bg.inc

#####

intro_ai.inc:	ai01.lzsa ai02.lzsa ai03.lzsa ai04.lzsa ai05.lzsa \
	static01.lzsa static02.lzsa static03.lzsa
	echo "ai01_lzsa: .incbin \"ai01.lzsa\"" > intro_ai.inc
	echo "ai02_lzsa: .incbin \"ai02.lzsa\"" >> intro_ai.inc
	echo "ai03_lzsa: .incbin \"ai03.lzsa\"" >> intro_ai.inc
	echo "ai04_lzsa: .incbin \"ai04.lzsa\"" >> intro_ai.inc
	echo "ai05_lzsa: .incbin \"ai05.lzsa\"" >> intro_ai.inc
	echo "static01_lzsa: .incbin \"static01.lzsa\"" >> intro_ai.inc
	echo "static02_lzsa: .incbin \"static02.lzsa\"" >> intro_ai.inc
	echo "static03_lzsa: .incbin \"static03.lzsa\"" >> intro_ai.inc

#####

intro_scanner.inc:	intro_scanner.lzsa
	echo "intro_scanner_lzsa: .incbin \"intro_scanner.lzsa\"" > intro_scanner.inc

#####

intro_scanning.inc:	\
	scan01.lzsa scan02.lzsa scan03.lzsa \
	scan04.lzsa scan05.lzsa scan06.lzsa \
	scan07.lzsa scan08.lzsa scan09.lzsa \
	scan10.lzsa scan11.lzsa scan12.lzsa \
	scan13.lzsa scan14.lzsa scan15.lzsa \
	scan16.lzsa scan17.lzsa scan18.lzsa \
	scan19.lzsa
	echo "scan01_lzsa: .incbin \"scan01.lzsa\"" > intro_scanning.inc
	echo "scan02_lzsa: .incbin \"scan02.lzsa\"" >> intro_scanning.inc
	echo "scan03_lzsa: .incbin \"scan03.lzsa\"" >> intro_scanning.inc
	echo "scan04_lzsa: .incbin \"scan04.lzsa\"" >> intro_scanning.inc
	echo "scan05_lzsa: .incbin \"scan05.lzsa\"" >> intro_scanning.inc
	echo "scan06_lzsa: .incbin \"scan06.lzsa\"" >> intro_scanning.inc
	echo "scan07_lzsa: .incbin \"scan07.lzsa\"" >> intro_scanning.inc
	echo "scan08_lzsa: .incbin \"scan08.lzsa\"" >> intro_scanning.inc
	echo "scan09_lzsa: .incbin \"scan09.lzsa\"" >> intro_scanning.inc
	echo "scan10_lzsa: .incbin \"scan10.lzsa\"" >> intro_scanning.inc
	echo "scan11_lzsa: .incbin \"scan11.lzsa\"" >> intro_scanning.inc
	echo "scan12_lzsa: .incbin \"scan12.lzsa\"" >> intro_scanning.inc
	echo "scan13_lzsa: .incbin \"scan13.lzsa\"" >> intro_scanning.inc
	echo "scan14_lzsa: .incbin \"scan14.lzsa\"" >> intro_scanning.inc
	echo "scan15_lzsa: .incbin \"scan15.lzsa\"" >> intro_scanning.inc
	echo "scan16_lzsa: .incbin \"scan16.lzsa\"" >> intro_scanning.inc
	echo "scan17_lzsa: .incbin \"scan17.lzsa\"" >> intro_scanning.inc
	echo "scan18_lzsa: .incbin \"scan18.lzsa\"" >> intro_scanning.inc
	echo "scan19_lzsa: .incbin \"scan19.lzsa\"" >> intro_scanning.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@


####

clean:		
		rm -f *~ *.inc *.lzsa *.gr
