include ../../../../../Makefile.inc

#PNG2RLE = ../../../gr-utils/png2rle
#PNG2LZ4 = ../../../gr-utils/png2lz4
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
#
#intro_tunnel1.inc:	$(PNG2RLE) \
#	intro_tunnel1.png \
#	tunnel1_01.png tunnel1_02.png tunnel1_03.png tunnel1_04.png \
#	tunnel1_05.png tunnel1_06.png tunnel1_07.png tunnel1_08.png \
#	tunnel1_09.png tunnel1_10.png tunnel1_11.png tunnel1_12.png \
#	tunnel1_13.png tunnel1_14.png tunnel1_15.png tunnel1_16.png \
#	tunnel1_17.png tunnel1_18.png tunnel1_19.png
#	$(PNG2RLE) asm intro_tunnel1.png tunnel1_rle > intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_01.png tunnel1_01_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_02.png tunnel1_02_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_03.png tunnel1_03_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_04.png tunnel1_04_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_05.png tunnel1_05_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_06.png tunnel1_06_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_07.png tunnel1_07_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_08.png tunnel1_08_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_09.png tunnel1_09_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_10.png tunnel1_10_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_11.png tunnel1_11_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_12.png tunnel1_12_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_13.png tunnel1_13_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_14.png tunnel1_14_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_15.png tunnel1_15_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_16.png tunnel1_16_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_17.png tunnel1_17_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_18.png tunnel1_18_rle >> intro_tunnel1.inc
#	$(PNG2RLE) asm tunnel1_19.png tunnel1_19_rle >> intro_tunnel1.inc

#####

#intro_tunnel2.inc:	$(PNG2RLE) \
#	intro_tunnel2.png \
#	tunnel2_01.png tunnel2_02.png tunnel2_03.png tunnel2_04.png \
#	tunnel2_05.png tunnel2_06.png tunnel2_07.png tunnel2_08.png \
#	tunnel2_09.png tunnel2_10.png tunnel2_11.png tunnel2_12.png \
#	tunnel2_13.png tunnel2_14.png tunnel2_15.png tunnel2_16.png \
#	tunnel2_17.png
#	$(PNG2RLE) asm intro_tunnel2.png tunnel2_rle > intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_01.png tunnel2_01_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_02.png tunnel2_02_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_03.png tunnel2_03_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_04.png tunnel2_04_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_05.png tunnel2_05_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_06.png tunnel2_06_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_07.png tunnel2_07_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_08.png tunnel2_08_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_09.png tunnel2_09_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_10.png tunnel2_10_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_11.png tunnel2_11_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_12.png tunnel2_12_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_13.png tunnel2_13_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_14.png tunnel2_14_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_15.png tunnel2_15_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_16.png tunnel2_16_rle >> intro_tunnel2.inc
#	$(PNG2RLE) asm tunnel2_17.png tunnel2_17_rle >> intro_tunnel2.inc


#####
#####

#intro_tunnel1_lz4.inc:	$(PNG2LZ4) \
#	intro_tunnel1.png \
#	tunnel1_01.png tunnel1_02.png tunnel1_03.png tunnel1_04.png \
#	tunnel1_05.png tunnel1_06.png tunnel1_07.png tunnel1_08.png \
#	tunnel1_09.png tunnel1_10.png tunnel1_11.png tunnel1_12.png \
#	tunnel1_13.png tunnel1_14.png tunnel1_15.png tunnel1_16.png \
#	tunnel1_17.png tunnel1_18.png tunnel1_19.png
#	$(PNG2LZ4) asm intro_tunnel1.png tunnel1_rle > intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_01.png tunnel1_01_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_02.png tunnel1_02_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_03.png tunnel1_03_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_04.png tunnel1_04_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_05.png tunnel1_05_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_06.png tunnel1_06_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_07.png tunnel1_07_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_08.png tunnel1_08_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_09.png tunnel1_09_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_10.png tunnel1_10_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_11.png tunnel1_11_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_12.png tunnel1_12_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_13.png tunnel1_13_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_14.png tunnel1_14_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_15.png tunnel1_15_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_16.png tunnel1_16_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_17.png tunnel1_17_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_18.png tunnel1_18_rle >> intro_tunnel1_lz4.inc
#	$(PNG2LZ4) asm tunnel1_19.png tunnel1_19_rle >> intro_tunnel1_lz4.inc
#
#####

#intro_tunnel2_lz4.inc:	$(PNG2LZ4) \
#	intro_tunnel2.png \
#	tunnel2_01.png tunnel2_02.png tunnel2_03.png tunnel2_04.png \
#	tunnel2_05.png tunnel2_06.png tunnel2_07.png tunnel2_08.png \
#	tunnel2_09.png tunnel2_10.png tunnel2_11.png tunnel2_12.png \
#	tunnel2_13.png tunnel2_14.png tunnel2_15.png tunnel2_16.png \
#	tunnel2_17.png
#	$(PNG2LZ4) asm intro_tunnel2.png tunnel2_rle > intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_01.png tunnel2_01_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_02.png tunnel2_02_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_03.png tunnel2_03_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_04.png tunnel2_04_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_05.png tunnel2_05_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_06.png tunnel2_06_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_07.png tunnel2_07_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_08.png tunnel2_08_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_09.png tunnel2_09_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_10.png tunnel2_10_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_11.png tunnel2_11_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_12.png tunnel2_12_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_13.png tunnel2_13_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_14.png tunnel2_14_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_15.png tunnel2_15_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_16.png tunnel2_16_rle >> intro_tunnel2_lz4.inc
#	$(PNG2LZ4) asm tunnel2_17.png tunnel2_17_rle >> intro_tunnel2_lz4.inc



#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa

