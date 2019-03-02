include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4


all:	intro_scanner_door.inc intro_keypad_bg.inc \
	intro_approach.inc intro_hands.inc intro_opening.inc \
	intro_scanner_door_lz4.inc intro_keypad_bg_lz4.inc \
	intro_approach_lz4.inc intro_hands_lz4.inc intro_opening_lz4.inc

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
	hand04_03.png hand05_01.png hand05_02.png hand05_03.png \
	hand05_04.png hand01_01.png hand01_02.png hand01_03.png \
	hand09_01.png hand09_02.png hand09_03.png hand09_04.png \
	hand09_05.png hand03_01.png hand03_02.png hand03_03.png \
	hand03_04.png hand02_01.png hand02_02.png hand02_03.png \
	hand02_04.png hand02_05.png
	$(PNG2RLE) asm hand04_01.png hand04_01_rle > intro_hands.inc
	$(PNG2RLE) asm hand04_02.png hand04_02_rle >> intro_hands.inc
	$(PNG2RLE) asm hand04_03.png hand04_03_rle >> intro_hands.inc
	$(PNG2RLE) asm hand05_01.png hand05_01_rle >> intro_hands.inc
	$(PNG2RLE) asm hand05_02.png hand05_02_rle >> intro_hands.inc
	$(PNG2RLE) asm hand05_03.png hand05_03_rle >> intro_hands.inc
	$(PNG2RLE) asm hand05_04.png hand05_04_rle >> intro_hands.inc
	$(PNG2RLE) asm hand01_01.png hand01_01_rle >> intro_hands.inc
	$(PNG2RLE) asm hand01_02.png hand01_02_rle >> intro_hands.inc
	$(PNG2RLE) asm hand01_03.png hand01_03_rle >> intro_hands.inc
	$(PNG2RLE) asm hand09_01.png hand09_01_rle >> intro_hands.inc
	$(PNG2RLE) asm hand09_02.png hand09_02_rle >> intro_hands.inc
	$(PNG2RLE) asm hand09_03.png hand09_03_rle >> intro_hands.inc
	$(PNG2RLE) asm hand09_04.png hand09_04_rle >> intro_hands.inc
	$(PNG2RLE) asm hand09_05.png hand09_05_rle >> intro_hands.inc
	$(PNG2RLE) asm hand03_01.png hand03_01_rle >> intro_hands.inc
	$(PNG2RLE) asm hand03_02.png hand03_02_rle >> intro_hands.inc
	$(PNG2RLE) asm hand03_03.png hand03_03_rle >> intro_hands.inc
	$(PNG2RLE) asm hand03_04.png hand03_04_rle >> intro_hands.inc
	$(PNG2RLE) asm hand02_01.png hand02_01_rle >> intro_hands.inc
	$(PNG2RLE) asm hand02_02.png hand02_02_rle >> intro_hands.inc
	$(PNG2RLE) asm hand02_03.png hand02_03_rle >> intro_hands.inc
	$(PNG2RLE) asm hand02_04.png hand02_04_rle >> intro_hands.inc
	$(PNG2RLE) asm hand02_05.png hand02_05_rle >> intro_hands.inc

####

intro_opening.inc:	$(PNG2RLE) opening01.png opening02.png \
	opening03.png opening04.png opening05.png opening06.png \
	opening07.png opening08.png opening09.png opening10.png \
	opening11.png opening12.png
	$(PNG2RLE) asm opening01.png opening01_rle > intro_opening.inc
	$(PNG2RLE) asm opening02.png opening02_rle >> intro_opening.inc
	$(PNG2RLE) asm opening03.png opening03_rle >> intro_opening.inc
	$(PNG2RLE) asm opening04.png opening04_rle >> intro_opening.inc
	$(PNG2RLE) asm opening05.png opening05_rle >> intro_opening.inc
	$(PNG2RLE) asm opening06.png opening06_rle >> intro_opening.inc
	$(PNG2RLE) asm opening07.png opening07_rle >> intro_opening.inc
	$(PNG2RLE) asm opening08.png opening08_rle >> intro_opening.inc
	$(PNG2RLE) asm opening09.png opening09_rle >> intro_opening.inc
	$(PNG2RLE) asm opening10.png opening10_rle >> intro_opening.inc
	$(PNG2RLE) asm opening11.png opening11_rle >> intro_opening.inc
	$(PNG2RLE) asm opening12.png opening12_rle >> intro_opening.inc


#####
#####

intro_scanner_door_lz4.inc:	$(PNG2LZ4) intro_scanner_door.png
	$(PNG2LZ4) asm intro_scanner_door.png scanner_door_rle > intro_scanner_door_lz4.inc

intro_keypad_bg_lz4.inc:	$(PNG2LZ4) intro_keypad_bg.png
	$(PNG2LZ4) asm intro_keypad_bg.png keypad_rle > intro_keypad_bg_lz4.inc

intro_approach_lz4.inc:	$(PNG2LZ4) approach01.png approach02.png \
	approach03.png approach04.png approach05.png approach06.png \
	approach07.png
	$(PNG2LZ4) asm approach01.png approach01_rle > intro_approach_lz4.inc
	$(PNG2LZ4) asm approach02.png approach02_rle >> intro_approach_lz4.inc
	$(PNG2LZ4) asm approach03.png approach03_rle >> intro_approach_lz4.inc
	$(PNG2LZ4) asm approach04.png approach04_rle >> intro_approach_lz4.inc
	$(PNG2LZ4) asm approach05.png approach05_rle >> intro_approach_lz4.inc
	$(PNG2LZ4) asm approach06.png approach06_rle >> intro_approach_lz4.inc
	$(PNG2LZ4) asm approach07.png approach07_rle >> intro_approach_lz4.inc

#####

intro_hands_lz4.inc:	$(PNG2LZ4) hand04_01.png hand04_02.png \
	hand04_03.png hand05_01.png hand05_02.png hand05_03.png \
	hand05_04.png hand01_01.png hand01_02.png hand01_03.png \
	hand09_01.png hand09_02.png hand09_03.png hand09_04.png \
	hand09_05.png hand03_01.png hand03_02.png hand03_03.png \
	hand03_04.png hand02_01.png hand02_02.png hand02_03.png \
	hand02_04.png hand02_05.png
	$(PNG2LZ4) asm hand04_01.png hand04_01_rle > intro_hands_lz4.inc
	$(PNG2LZ4) asm hand04_02.png hand04_02_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand04_03.png hand04_03_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand05_01.png hand05_01_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand05_02.png hand05_02_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand05_03.png hand05_03_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand05_04.png hand05_04_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand01_01.png hand01_01_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand01_02.png hand01_02_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand01_03.png hand01_03_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand09_01.png hand09_01_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand09_02.png hand09_02_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand09_03.png hand09_03_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand09_04.png hand09_04_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand09_05.png hand09_05_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand03_01.png hand03_01_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand03_02.png hand03_02_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand03_03.png hand03_03_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand03_04.png hand03_04_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand02_01.png hand02_01_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand02_02.png hand02_02_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand02_03.png hand02_03_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand02_04.png hand02_04_rle >> intro_hands_lz4.inc
	$(PNG2LZ4) asm hand02_05.png hand02_05_rle >> intro_hands_lz4.inc

####

intro_opening_lz4.inc:	$(PNG2LZ4) opening01.png opening02.png \
	opening03.png opening04.png opening05.png opening06.png \
	opening07.png opening08.png opening09.png opening10.png \
	opening11.png opening12.png
	$(PNG2LZ4) asm opening01.png opening01_rle > intro_opening_lz4.inc
	$(PNG2LZ4) asm opening02.png opening02_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening03.png opening03_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening04.png opening04_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening05.png opening05_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening06.png opening06_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening07.png opening07_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening08.png opening08_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening09.png opening09_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening10.png opening10_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening11.png opening11_rle >> intro_opening_lz4.inc
	$(PNG2LZ4) asm opening12.png opening12_rle >> intro_opening_lz4.inc


#####


clean:		
		rm -f *~ *.inc
