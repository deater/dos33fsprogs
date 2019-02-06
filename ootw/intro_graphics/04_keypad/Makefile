include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_scanner_door.inc intro_keypad.inc

#####

intro_scanner_door.inc:	$(PNG2RLE) intro_scanner_door.png
	$(PNG2RLE) asm intro_scanner_door.png scanner_door_rle > intro_scanner_door.inc

intro_keypad.inc:	$(PNG2RLE) intro_keypad.png
	$(PNG2RLE) asm intro_keypad.png keypad_rle > intro_keypad.inc

#####

clean:		
		rm -f *~ *.inc
