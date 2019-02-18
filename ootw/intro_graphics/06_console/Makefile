include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_desktop.inc intro_cursor.inc intro_collider.inc

#####

intro_collider.inc:	$(PNG2RLE) collider_bg.png \
		collider_phase2_00.png collider_phase2_01.png \
		collider_phase2_02.png collider_phase2_03.png
	$(PNG2RLE) asm collider_bg.png collider_rle > intro_collider.inc
	$(PNG2RLE) asm collider_phase2_00.png collider_p200_rle >> intro_collider.inc
	$(PNG2RLE) asm collider_phase2_01.png collider_p201_rle >> intro_collider.inc
	$(PNG2RLE) asm collider_phase2_02.png collider_p202_rle >> intro_collider.inc
	$(PNG2RLE) asm collider_phase2_03.png collider_p203_rle >> intro_collider.inc


#####

intro_desktop.inc:	$(PNG2RLE) intro_desktop.png \
		powerup01.png powerup02.png powerup03.png
	$(PNG2RLE) asm intro_desktop.png desktop_rle > intro_desktop.inc
	$(PNG2RLE) asm powerup01.png powerup01_rle >> intro_desktop.inc
	$(PNG2RLE) asm powerup02.png powerup02_rle >> intro_desktop.inc
	$(PNG2RLE) asm powerup03.png powerup03_rle >> intro_desktop.inc

#####

intro_cursor.inc:	$(PNG2RLE) desktop_bg.png \
	cursor01.png cursor02.png cursor03.png cursor04.png \
	cursor05.png cursor06.png cursor07.png cursor08.png
	$(PNG2RLE) asm desktop_bg.png desktop_bg_rle > intro_cursor.inc
	$(PNG2RLE) asm cursor01.png cursor01_rle >> intro_cursor.inc
	$(PNG2RLE) asm cursor02.png cursor02_rle >> intro_cursor.inc
	$(PNG2RLE) asm cursor03.png cursor03_rle >> intro_cursor.inc
	$(PNG2RLE) asm cursor04.png cursor04_rle >> intro_cursor.inc
	$(PNG2RLE) asm cursor05.png cursor05_rle >> intro_cursor.inc
	$(PNG2RLE) asm cursor06.png cursor06_rle >> intro_cursor.inc
	$(PNG2RLE) asm cursor07.png cursor07_rle >> intro_cursor.inc
	$(PNG2RLE) asm cursor08.png cursor08_rle >> intro_cursor.inc


clean:		
		rm -f *~ *.inc
