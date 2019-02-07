include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_scanner_door.inc intro_keypad.inc intro_approach.inc

#####

intro_scanner_door.inc:	$(PNG2RLE) intro_scanner_door.png
	$(PNG2RLE) asm intro_scanner_door.png scanner_door_rle > intro_scanner_door.inc

intro_keypad.inc:	$(PNG2RLE) intro_keypad.png
	$(PNG2RLE) asm intro_keypad.png keypad_rle > intro_keypad.inc

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

clean:		
		rm -f *~ *.inc
