include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_scanner_door.inc intro_keypad_bg.inc intro_approach.inc intro_hands.inc

#####

intro_scanner_door.inc:	$(PNG2RLE) intro_scanner_door.png
	$(PNG2RLE) asm intro_scanner_door.png scanner_door_rle > intro_scanner_door.inc

intro_keypad_bg.inc:	$(PNG2RLE) intro_keypad_bg.png
	$(PNG2RLE) asm intro_keypad_bg.png keypad_rle > intro_keypad_bg.inc

intro_approach.inc:	$(PNG2RLE) approach01.png approach02.png \
	approach03.png approach04.png approach05.png approach06.png \
	approach07.png
	$(PNG2RLE) asm approach01.png approach01_rle > intro_approach.inc
	$(PNG2RLE) asm approach02.png approach02_rle >> intro_approach.inc
	$(PNG2RLE) asm approach03.png approach03_rle >> intro_approach.inc
	$(PNG2RLE) asm approach04.png approach04_rle >> intro_approach.inc
	$(PNG2RLE) asm approach05.png approach05_rle >> intro_approach.inc
	$(PNG2RLE) asm approach06.png approach06_rle >> intro_approach.inc
	$(PNG2RLE) asm approach07.png approach07_rle >> intro_approach.inc

#####

intro_hands.inc:	$(PNG2RLE) hand04_01.png hand04_02.png \
	hand04_03.png
	$(PNG2RLE) asm hand04_01.png hand04_01_rle > intro_hands.inc
	$(PNG2RLE) asm hand04_02.png hand04_02_rle >> intro_hands.inc
	$(PNG2RLE) asm hand04_03.png hand04_03_rle >> intro_hands.inc


#####


clean:		
		rm -f *~ *.inc
