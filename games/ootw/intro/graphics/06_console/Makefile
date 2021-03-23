include ../../../../../Makefile.inc

#PNG2RLE = ../../../gr-utils/png2rle
#PNG2LZ4 = ../../../gr-utils/png2lz4
PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa


all:	intro_desktop.inc intro_cursor.inc intro_collider.inc

#####

intro_collider.inc:	collider_bg.lzsa \
		collider_phase2_00.lzsa collider_phase2_01.lzsa \
		collider_phase2_02.lzsa collider_phase2_03.lzsa
	echo "collider_lzsa: .incbin \"collider_bg.lzsa\"" > intro_collider.inc
	echo "collider_p200_lzsa: .incbin \"collider_phase2_00.lzsa\"" >> intro_collider.inc
	echo "collider_p201_lzsa: .incbin \"collider_phase2_01.lzsa\"" >> intro_collider.inc
	echo "collider_p202_lzsa: .incbin \"collider_phase2_02.lzsa\"" >> intro_collider.inc
	echo "collider_p203_lzsa: .incbin \"collider_phase2_03.lzsa\"" >> intro_collider.inc

#####

intro_desktop.inc:	intro_desktop.lzsa \
		powerup01.lzsa powerup02.lzsa powerup03.lzsa
	echo "desktop_lzsa: .incbin \"intro_desktop.lzsa\"" > intro_desktop.inc
	echo "powerup01_lzsa: .incbin \"powerup01.lzsa\"" >> intro_desktop.inc
	echo "powerup02_lzsa: .incbin \"powerup02.lzsa\"" >> intro_desktop.inc
	echo "powerup03_lzsa: .incbin \"powerup03.lzsa\"" >> intro_desktop.inc

#####

intro_cursor.inc:	desktop_bg.lzsa \
	cursor01.lzsa cursor02.lzsa cursor03.lzsa cursor04.lzsa \
	cursor05.lzsa cursor06.lzsa cursor07.lzsa cursor08.lzsa
	echo "desktop_bg_lzsa: .incbin \"desktop_bg.lzsa\"" > intro_cursor.inc
	echo "cursor01_lzsa: .incbin \"cursor01.lzsa\"" >> intro_cursor.inc
	echo "cursor02_lzsa: .incbin \"cursor02.lzsa\"" >> intro_cursor.inc
	echo "cursor03_lzsa: .incbin \"cursor03.lzsa\"" >> intro_cursor.inc
	echo "cursor04_lzsa: .incbin \"cursor04.lzsa\"" >> intro_cursor.inc
	echo "cursor05_lzsa: .incbin \"cursor05.lzsa\"" >> intro_cursor.inc
	echo "cursor06_lzsa: .incbin \"cursor06.lzsa\"" >> intro_cursor.inc
	echo "cursor07_lzsa: .incbin \"cursor07.lzsa\"" >> intro_cursor.inc
	echo "cursor08_lzsa: .incbin \"cursor08.lzsa\"" >> intro_cursor.inc


####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@



#
#intro_collider.inc:	collider_bg.png \
#		collider_phase2_00.png collider_phase2_01.png \
#		collider_phase2_02.png collider_phase2_03.png
#	$(PNG2RLE) asm collider_bg.png collider_rle > intro_collider.inc
#	$(PNG2RLE) asm collider_phase2_00.png collider_p200_rle >> intro_collider.inc
#	$(PNG2RLE) asm collider_phase2_01.png collider_p201_rle >> intro_collider.inc
#	$(PNG2RLE) asm collider_phase2_02.png collider_p202_rle >> intro_collider.inc
#	$(PNG2RLE) asm collider_phase2_03.png collider_p203_rle >> intro_collider.inc
#
#
######
#
#intro_desktop.inc:	$(PNG2RLE) intro_desktop.png \
#		powerup01.png powerup02.png powerup03.png
#	$(PNG2RLE) asm intro_desktop.png desktop_rle > intro_desktop.inc
#	$(PNG2RLE) asm powerup01.png powerup01_rle >> intro_desktop.inc
#	$(PNG2RLE) asm powerup02.png powerup02_rle >> intro_desktop.inc
#	$(PNG2RLE) asm powerup03.png powerup03_rle >> intro_desktop.inc
#
######
#
#intro_cursor.inc:	$(PNG2RLE) desktop_bg.png \
#	cursor01.png cursor02.png cursor03.png cursor04.png \
#	cursor05.png cursor06.png cursor07.png cursor08.png
#	$(PNG2RLE) asm desktop_bg.png desktop_bg_rle > intro_cursor.inc
#	$(PNG2RLE) asm cursor01.png cursor01_rle >> intro_cursor.inc
#	$(PNG2RLE) asm cursor02.png cursor02_rle >> intro_cursor.inc
#	$(PNG2RLE) asm cursor03.png cursor03_rle >> intro_cursor.inc
#	$(PNG2RLE) asm cursor04.png cursor04_rle >> intro_cursor.inc
#	$(PNG2RLE) asm cursor05.png cursor05_rle >> intro_cursor.inc
#	$(PNG2RLE) asm cursor06.png cursor06_rle >> intro_cursor.inc
#	$(PNG2RLE) asm cursor07.png cursor07_rle >> intro_cursor.inc
#	$(PNG2RLE) asm cursor08.png cursor08_rle >> intro_cursor.inc
#
#



#####
#####

#intro_collider_lz4.inc:	$(PNG2LZ4) collider_bg.png \
#		collider_phase2_00.png collider_phase2_01.png \
#		collider_phase2_02.png collider_phase2_03.png
#	$(PNG2LZ4) asm collider_bg.png collider_rle > intro_collider_lz4.inc
#	$(PNG2LZ4) asm collider_phase2_00.png collider_p200_rle >> intro_collider_lz4.inc
#	$(PNG2LZ4) asm collider_phase2_01.png collider_p201_rle >> intro_collider_lz4.inc
#	$(PNG2LZ4) asm collider_phase2_02.png collider_p202_rle >> intro_collider_lz4.inc
#	$(PNG2LZ4) asm collider_phase2_03.png collider_p203_rle >> intro_collider_lz4.inc


#####

#intro_desktop_lz4.inc:	$(PNG2LZ4) intro_desktop.png \
#		powerup01.png powerup02.png powerup03.png
#	$(PNG2LZ4) asm intro_desktop.png desktop_rle > intro_desktop_lz4.inc
#	$(PNG2LZ4) asm powerup01.png powerup01_rle >> intro_desktop_lz4.inc
#	$(PNG2LZ4) asm powerup02.png powerup02_rle >> intro_desktop_lz4.inc
#	$(PNG2LZ4) asm powerup03.png powerup03_rle >> intro_desktop_lz4.inc

#####

#intro_cursor_lz4.inc:	$(PNG2LZ4) desktop_bg.png \
#	cursor01.png cursor02.png cursor03.png cursor04.png \
#	cursor05.png cursor06.png cursor07.png cursor08.png
#	$(PNG2LZ4) asm desktop_bg.png desktop_bg_rle > intro_cursor_lz4.inc
#	$(PNG2LZ4) asm cursor01.png cursor01_rle >> intro_cursor_lz4.inc
#	$(PNG2LZ4) asm cursor02.png cursor02_rle >> intro_cursor_lz4.inc
#	$(PNG2LZ4) asm cursor03.png cursor03_rle >> intro_cursor_lz4.inc
#	$(PNG2LZ4) asm cursor04.png cursor04_rle >> intro_cursor_lz4.inc
#	$(PNG2LZ4) asm cursor05.png cursor05_rle >> intro_cursor_lz4.inc
#	$(PNG2LZ4) asm cursor06.png cursor06_rle >> intro_cursor_lz4.inc
#	$(PNG2LZ4) asm cursor07.png cursor07_rle >> intro_cursor_lz4.inc
#	$(PNG2LZ4) asm cursor08.png cursor08_rle >> intro_cursor_lz4.inc



clean:		
		rm -f *~ *.inc *.gr *.lzsa
