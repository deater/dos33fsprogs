include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_tunnel1.inc intro_tunnel2.inc

#####

intro_tunnel1.inc:	$(PNG2RLE) \
	intro_tunnel1.png \
	tunnel1_01.png tunnel1_02.png tunnel1_03.png tunnel1_04.png \
	tunnel1_05.png tunnel1_06.png tunnel1_07.png tunnel1_08.png \
	tunnel1_09.png tunnel1_10.png tunnel1_11.png tunnel1_12.png \
	tunnel1_13.png tunnel1_14.png tunnel1_15.png tunnel1_16.png \
	tunnel1_17.png tunnel1_18.png tunnel1_19.png
	$(PNG2RLE) asm intro_tunnel1.png tunnel1_rle > intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_01.png tunnel1_01_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_02.png tunnel1_02_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_03.png tunnel1_03_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_04.png tunnel1_04_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_05.png tunnel1_05_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_06.png tunnel1_06_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_07.png tunnel1_07_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_08.png tunnel1_08_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_09.png tunnel1_09_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_10.png tunnel1_10_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_11.png tunnel1_11_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_12.png tunnel1_12_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_13.png tunnel1_13_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_14.png tunnel1_14_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_15.png tunnel1_15_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_16.png tunnel1_16_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_17.png tunnel1_17_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_18.png tunnel1_18_rle >> intro_tunnel1.inc
	$(PNG2RLE) asm tunnel1_19.png tunnel1_19_rle >> intro_tunnel1.inc

#####

intro_tunnel2.inc:	$(PNG2RLE) \
	intro_tunnel2.png \
	tunnel2_01.png tunnel2_02.png tunnel2_03.png tunnel2_04.png \
	tunnel2_05.png tunnel2_06.png tunnel2_07.png tunnel2_08.png \
	tunnel2_09.png tunnel2_10.png tunnel2_11.png tunnel2_12.png \
	tunnel2_13.png tunnel2_14.png tunnel2_15.png tunnel2_16.png \
	tunnel2_17.png
	$(PNG2RLE) asm intro_tunnel2.png tunnel2_rle > intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_01.png tunnel2_01_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_02.png tunnel2_02_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_03.png tunnel2_03_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_04.png tunnel2_04_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_05.png tunnel2_05_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_06.png tunnel2_06_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_07.png tunnel2_07_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_08.png tunnel2_08_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_09.png tunnel2_09_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_10.png tunnel2_10_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_11.png tunnel2_11_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_12.png tunnel2_12_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_13.png tunnel2_13_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_14.png tunnel2_14_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_15.png tunnel2_15_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_16.png tunnel2_16_rle >> intro_tunnel2.inc
	$(PNG2RLE) asm tunnel2_17.png tunnel2_17_rle >> intro_tunnel2.inc


#####

clean:		
		rm -f *~ *.inc

