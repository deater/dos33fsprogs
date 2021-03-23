include ../../../../../Makefile.inc

#PNG2RLE = ../../../gr-utils/png2rle
#PNG2LZ4 = ../../../gr-utils/png2lz4
PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	intro_scanner_door.inc intro_keypad_bg.inc \
	intro_approach.inc intro_hands.inc intro_opening.inc

#####

intro_scanner_door.inc:	intro_scanner_door.lzsa
	echo "intro_scanner_door_lzsa: .incbin \"intro_scanner_door.lzsa\"" > intro_scanner_door.inc

intro_keypad_bg.inc:	intro_keypad_bg.lzsa
	echo "intro_keypad_bg_lzsa: .incbin \"intro_keypad_bg.lzsa\"" > intro_keypad_bg.inc

intro_approach.inc:	approach01.lzsa approach02.lzsa \
	approach03.lzsa approach04.lzsa approach05.lzsa approach06.lzsa \
	approach07.lzsa
	echo "approach01_lzsa: .incbin \"approach01.lzsa\"" > intro_approach.inc
	echo "approach02_lzsa: .incbin \"approach02.lzsa\"" >> intro_approach.inc
	echo "approach03_lzsa: .incbin \"approach03.lzsa\"" >> intro_approach.inc
	echo "approach04_lzsa: .incbin \"approach04.lzsa\"" >> intro_approach.inc
	echo "approach05_lzsa: .incbin \"approach05.lzsa\"" >> intro_approach.inc
	echo "approach06_lzsa: .incbin \"approach06.lzsa\"" >> intro_approach.inc
	echo "approach07_lzsa: .incbin \"approach07.lzsa\"" >> intro_approach.inc

#####

intro_hands.inc:	hand04_01.lzsa hand04_02.lzsa \
	hand04_03.lzsa hand05_01.lzsa hand05_02.lzsa hand05_03.lzsa \
	hand05_04.lzsa hand01_01.lzsa hand01_02.lzsa hand01_03.lzsa \
	hand09_01.lzsa hand09_02.lzsa hand09_03.lzsa hand09_04.lzsa \
	hand09_05.lzsa hand03_01.lzsa hand03_02.lzsa hand03_03.lzsa \
	hand03_04.lzsa hand02_01.lzsa hand02_02.lzsa hand02_03.lzsa \
	hand02_04.lzsa hand02_05.lzsa
	echo "hand04_01_lzsa: .incbin \"hand04_01.lzsa\"" > intro_hands.inc
	echo "hand04_02_lzsa: .incbin \"hand04_02.lzsa\"" >> intro_hands.inc
	echo "hand04_03_lzsa: .incbin \"hand04_03.lzsa\"" >> intro_hands.inc
	echo "hand05_01_lzsa: .incbin \"hand05_01.lzsa\"" >> intro_hands.inc
	echo "hand05_02_lzsa: .incbin \"hand05_02.lzsa\"" >> intro_hands.inc
	echo "hand05_03_lzsa: .incbin \"hand05_03.lzsa\"" >> intro_hands.inc
	echo "hand05_04_lzsa: .incbin \"hand05_04.lzsa\"" >> intro_hands.inc
	echo "hand01_01_lzsa: .incbin \"hand01_01.lzsa\"" >> intro_hands.inc
	echo "hand01_02_lzsa: .incbin \"hand01_02.lzsa\"" >> intro_hands.inc
	echo "hand01_03_lzsa: .incbin \"hand01_03.lzsa\"" >> intro_hands.inc
	echo "hand09_01_lzsa: .incbin \"hand09_01.lzsa\"" >> intro_hands.inc
	echo "hand09_02_lzsa: .incbin \"hand09_02.lzsa\"" >> intro_hands.inc
	echo "hand09_03_lzsa: .incbin \"hand09_03.lzsa\"" >> intro_hands.inc
	echo "hand09_04_lzsa: .incbin \"hand09_04.lzsa\"" >> intro_hands.inc
	echo "hand09_05_lzsa: .incbin \"hand09_05.lzsa\"" >> intro_hands.inc
	echo "hand03_01_lzsa: .incbin \"hand03_01.lzsa\"" >> intro_hands.inc
	echo "hand03_02_lzsa: .incbin \"hand03_02.lzsa\"" >> intro_hands.inc
	echo "hand03_03_lzsa: .incbin \"hand03_03.lzsa\"" >> intro_hands.inc
	echo "hand03_04_lzsa: .incbin \"hand03_04.lzsa\"" >> intro_hands.inc
	echo "hand02_01_lzsa: .incbin \"hand02_01.lzsa\"" >> intro_hands.inc
	echo "hand02_02_lzsa: .incbin \"hand02_02.lzsa\"" >> intro_hands.inc
	echo "hand02_03_lzsa: .incbin \"hand02_03.lzsa\"" >> intro_hands.inc
	echo "hand02_04_lzsa: .incbin \"hand02_04.lzsa\"" >> intro_hands.inc
	echo "hand02_05_lzsa: .incbin \"hand02_05.lzsa\"" >> intro_hands.inc

####

intro_opening.inc:	opening01.lzsa opening02.lzsa \
	opening03.lzsa opening04.lzsa opening05.lzsa opening06.lzsa \
	opening07.lzsa opening08.lzsa opening09.lzsa opening10.lzsa \
	opening11.lzsa opening12.lzsa
	echo "opening01_lzsa: .incbin \"opening01.lzsa\"" > intro_opening.inc
	echo "opening02_lzsa: .incbin \"opening02.lzsa\"" >> intro_opening.inc
	echo "opening03_lzsa: .incbin \"opening03.lzsa\"" >> intro_opening.inc
	echo "opening04_lzsa: .incbin \"opening04.lzsa\"" >> intro_opening.inc
	echo "opening05_lzsa: .incbin \"opening05.lzsa\"" >> intro_opening.inc
	echo "opening06_lzsa: .incbin \"opening06.lzsa\"" >> intro_opening.inc
	echo "opening07_lzsa: .incbin \"opening07.lzsa\"" >> intro_opening.inc
	echo "opening08_lzsa: .incbin \"opening08.lzsa\"" >> intro_opening.inc
	echo "opening09_lzsa: .incbin \"opening09.lzsa\"" >> intro_opening.inc
	echo "opening10_lzsa: .incbin \"opening10.lzsa\"" >> intro_opening.inc
	echo "opening11_lzsa: .incbin \"opening11.lzsa\"" >> intro_opening.inc
	echo "opening12_lzsa: .incbin \"opening12.lzsa\"" >> intro_opening.inc

####

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@


#####
#
#intro_scanner_door.inc:	$(PNG2RLE) intro_scanner_door.png
#	$(PNG2RLE) asm intro_scanner_door.png scanner_door_rle > intro_scanner_door.inc
#
#intro_keypad_bg.inc:	$(PNG2RLE) intro_keypad_bg.png
#	$(PNG2RLE) asm intro_keypad_bg.png keypad_rle > intro_keypad_bg.inc
#
#intro_approach.inc:	$(PNG2RLE) approach01.png approach02.png \
#	approach03.png approach04.png approach05.png approach06.png \
#	approach07.png
#	$(PNG2RLE) asm approach01.png approach01_rle > intro_approach.inc
#	$(PNG2RLE) asm approach02.png approach02_rle >> intro_approach.inc
#	$(PNG2RLE) asm approach03.png approach03_rle >> intro_approach.inc
#	$(PNG2RLE) asm approach04.png approach04_rle >> intro_approach.inc
#	$(PNG2RLE) asm approach05.png approach05_rle >> intro_approach.inc
#	$(PNG2RLE) asm approach06.png approach06_rle >> intro_approach.inc
#	$(PNG2RLE) asm approach07.png approach07_rle >> intro_approach.inc

#####

#intro_hands.inc:	$(PNG2RLE) hand04_01.png hand04_02.png \
#	hand04_03.png hand05_01.png hand05_02.png hand05_03.png \
#	hand05_04.png hand01_01.png hand01_02.png hand01_03.png \
#	hand09_01.png hand09_02.png hand09_03.png hand09_04.png \
#	hand09_05.png hand03_01.png hand03_02.png hand03_03.png \
#	hand03_04.png hand02_01.png hand02_02.png hand02_03.png \
#	hand02_04.png hand02_05.png
#	$(PNG2RLE) asm hand04_01.png hand04_01_rle > intro_hands.inc
#	$(PNG2RLE) asm hand04_02.png hand04_02_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand04_03.png hand04_03_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand05_01.png hand05_01_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand05_02.png hand05_02_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand05_03.png hand05_03_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand05_04.png hand05_04_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand01_01.png hand01_01_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand01_02.png hand01_02_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand01_03.png hand01_03_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand09_01.png hand09_01_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand09_02.png hand09_02_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand09_03.png hand09_03_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand09_04.png hand09_04_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand09_05.png hand09_05_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand03_01.png hand03_01_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand03_02.png hand03_02_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand03_03.png hand03_03_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand03_04.png hand03_04_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand02_01.png hand02_01_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand02_02.png hand02_02_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand02_03.png hand02_03_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand02_04.png hand02_04_rle >> intro_hands.inc
#	$(PNG2RLE) asm hand02_05.png hand02_05_rle >> intro_hands.inc

####

#intro_opening.inc:	$(PNG2RLE) opening01.png opening02.png \
#	opening03.png opening04.png opening05.png opening06.png \
#	opening07.png opening08.png opening09.png opening10.png \
#	opening11.png opening12.png
#	$(PNG2RLE) asm opening01.png opening01_rle > intro_opening.inc
#	$(PNG2RLE) asm opening02.png opening02_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening03.png opening03_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening04.png opening04_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening05.png opening05_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening06.png opening06_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening07.png opening07_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening08.png opening08_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening09.png opening09_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening10.png opening10_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening11.png opening11_rle >> intro_opening.inc
#	$(PNG2RLE) asm opening12.png opening12_rle >> intro_opening.inc



#####
#####

#intro_scanner_door_lz4.inc:	$(PNG2LZ4) intro_scanner_door.png
#	$(PNG2LZ4) asm intro_scanner_door.png scanner_door_rle > intro_scanner_door_lz4.inc

#intro_keypad_bg_lz4.inc:	$(PNG2LZ4) intro_keypad_bg.png
#	$(PNG2LZ4) asm intro_keypad_bg.png keypad_rle > intro_keypad_bg_lz4.inc

#intro_approach_lz4.inc:	$(PNG2LZ4) approach01.png approach02.png \
#	approach03.png approach04.png approach05.png approach06.png \
#	approach07.png
#	$(PNG2LZ4) asm approach01.png approach01_rle > intro_approach_lz4.inc
#	$(PNG2LZ4) asm approach02.png approach02_rle >> intro_approach_lz4.inc
#	$(PNG2LZ4) asm approach03.png approach03_rle >> intro_approach_lz4.inc
#	$(PNG2LZ4) asm approach04.png approach04_rle >> intro_approach_lz4.inc
#	$(PNG2LZ4) asm approach05.png approach05_rle >> intro_approach_lz4.inc
#	$(PNG2LZ4) asm approach06.png approach06_rle >> intro_approach_lz4.inc
#	$(PNG2LZ4) asm approach07.png approach07_rle >> intro_approach_lz4.inc

#####

#intro_hands_lz4.inc:	$(PNG2LZ4) hand04_01.png hand04_02.png \
#	hand04_03.png hand05_01.png hand05_02.png hand05_03.png \
#	hand05_04.png hand01_01.png hand01_02.png hand01_03.png \
#	hand09_01.png hand09_02.png hand09_03.png hand09_04.png \
#	hand09_05.png hand03_01.png hand03_02.png hand03_03.png \
#	hand03_04.png hand02_01.png hand02_02.png hand02_03.png \
#	hand02_04.png hand02_05.png
#	$(PNG2LZ4) asm hand04_01.png hand04_01_rle > intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand04_02.png hand04_02_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand04_03.png hand04_03_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand05_01.png hand05_01_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand05_02.png hand05_02_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand05_03.png hand05_03_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand05_04.png hand05_04_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand01_01.png hand01_01_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand01_02.png hand01_02_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand01_03.png hand01_03_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand09_01.png hand09_01_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand09_02.png hand09_02_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand09_03.png hand09_03_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand09_04.png hand09_04_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand09_05.png hand09_05_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand03_01.png hand03_01_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand03_02.png hand03_02_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand03_03.png hand03_03_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand03_04.png hand03_04_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand02_01.png hand02_01_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand02_02.png hand02_02_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand02_03.png hand02_03_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand02_04.png hand02_04_rle >> intro_hands_lz4.inc
#	$(PNG2LZ4) asm hand02_05.png hand02_05_rle >> intro_hands_lz4.inc

####

#intro_opening_lz4.inc:	$(PNG2LZ4) opening01.png opening02.png \
#	opening03.png opening04.png opening05.png opening06.png \
#	opening07.png opening08.png opening09.png opening10.png \
#	opening11.png opening12.png
#	$(PNG2LZ4) asm opening01.png opening01_rle > intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening02.png opening02_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening03.png opening03_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening04.png opening04_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening05.png opening05_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening06.png opening06_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening07.png opening07_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening08.png opening08_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening09.png opening09_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening10.png opening10_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening11.png opening11_rle >> intro_opening_lz4.inc
#	$(PNG2LZ4) asm opening12.png opening12_rle >> intro_opening_lz4.inc


#####


clean:		
		rm -f *~ *.inc *.gr *.lzsa
