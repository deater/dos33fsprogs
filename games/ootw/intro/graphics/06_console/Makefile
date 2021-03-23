include ../../../../../Makefile.inc

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

###

clean:		
		rm -f *~ *.inc *.gr *.lzsa
