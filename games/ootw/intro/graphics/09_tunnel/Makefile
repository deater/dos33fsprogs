include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	intro_tunnel1.inc intro_tunnel2.inc

#####

intro_tunnel1.inc:	\
	intro_tunnel1.lzsa \
	tunnel1_01.lzsa tunnel1_02.lzsa tunnel1_03.lzsa tunnel1_04.lzsa \
	tunnel1_05.lzsa tunnel1_06.lzsa tunnel1_07.lzsa tunnel1_08.lzsa \
	tunnel1_09.lzsa tunnel1_10.lzsa tunnel1_11.lzsa tunnel1_12.lzsa \
	tunnel1_13.lzsa tunnel1_14.lzsa tunnel1_15.lzsa tunnel1_16.lzsa \
	tunnel1_17.lzsa tunnel1_18.lzsa tunnel1_19.lzsa
	echo "tunnel1_lzsa: .incbin \"intro_tunnel1.lzsa\"" > intro_tunnel1.inc
	echo "tunnel1_01_lzsa: .incbin \"tunnel1_01.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_02_lzsa: .incbin \"tunnel1_02.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_03_lzsa: .incbin \"tunnel1_03.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_04_lzsa: .incbin \"tunnel1_04.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_05_lzsa: .incbin \"tunnel1_05.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_06_lzsa: .incbin \"tunnel1_06.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_07_lzsa: .incbin \"tunnel1_07.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_08_lzsa: .incbin \"tunnel1_08.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_09_lzsa: .incbin \"tunnel1_09.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_10_lzsa: .incbin \"tunnel1_10.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_11_lzsa: .incbin \"tunnel1_11.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_12_lzsa: .incbin \"tunnel1_12.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_13_lzsa: .incbin \"tunnel1_13.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_14_lzsa: .incbin \"tunnel1_14.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_15_lzsa: .incbin \"tunnel1_15.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_16_lzsa: .incbin \"tunnel1_16.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_17_lzsa: .incbin \"tunnel1_17.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_18_lzsa: .incbin \"tunnel1_18.lzsa\"" >> intro_tunnel1.inc
	echo "tunnel1_19_lzsa: .incbin \"tunnel1_19.lzsa\"" >> intro_tunnel1.inc

#####

intro_tunnel2.inc:	\
	intro_tunnel2.lzsa \
	tunnel2_01.lzsa tunnel2_02.lzsa tunnel2_03.lzsa tunnel2_04.lzsa \
	tunnel2_05.lzsa tunnel2_06.lzsa tunnel2_07.lzsa tunnel2_08.lzsa \
	tunnel2_09.lzsa tunnel2_10.lzsa tunnel2_11.lzsa tunnel2_12.lzsa \
	tunnel2_13.lzsa tunnel2_14.lzsa tunnel2_15.lzsa tunnel2_16.lzsa \
	tunnel2_17.lzsa
	echo "tunnel2_lzsa: .incbin \"intro_tunnel2.lzsa\"" > intro_tunnel2.inc
	echo "tunnel2_01_lzsa: .incbin \"tunnel2_01.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_02_lzsa: .incbin \"tunnel2_02.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_03_lzsa: .incbin \"tunnel2_03.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_04_lzsa: .incbin \"tunnel2_04.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_05_lzsa: .incbin \"tunnel2_05.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_06_lzsa: .incbin \"tunnel2_06.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_07_lzsa: .incbin \"tunnel2_07.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_08_lzsa: .incbin \"tunnel2_08.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_09_lzsa: .incbin \"tunnel2_09.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_10_lzsa: .incbin \"tunnel2_10.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_11_lzsa: .incbin \"tunnel2_11.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_12_lzsa: .incbin \"tunnel2_12.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_13_lzsa: .incbin \"tunnel2_13.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_14_lzsa: .incbin \"tunnel2_14.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_15_lzsa: .incbin \"tunnel2_15.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_16_lzsa: .incbin \"tunnel2_16.lzsa\"" >> intro_tunnel2.inc
	echo "tunnel2_17_lzsa: .incbin \"tunnel2_17.lzsa\"" >> intro_tunnel2.inc

#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa

