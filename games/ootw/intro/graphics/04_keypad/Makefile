include ../../../../../Makefile.inc

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


clean:		
		rm -f *~ *.inc *.gr *.lzsa
