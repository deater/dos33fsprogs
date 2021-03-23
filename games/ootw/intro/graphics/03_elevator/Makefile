include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	intro_elevator.inc intro_off_elevator.inc intro_walking.inc


#####



intro_elevator.inc:	intro_elevator.lzsa
	echo "intro_elevator_lzsa: .incbin \"intro_elevator.lzsa\"" > intro_elevator.inc

intro_off_elevator.inc:	intro_off_elevator.lzsa
	echo "intro_off_elevator_lzsa: .incbin \"intro_off_elevator.lzsa\"" > intro_off_elevator.inc

intro_walking.inc:	walking00.lzsa walking01.lzsa walking02.lzsa \
		walking03.lzsa walking04.lzsa walking05.lzsa walking06.lzsa \
		walking07.lzsa walking08.lzsa
	echo "walking00_lzsa: .incbin \"walking00.lzsa\"" > intro_walking.inc
	echo "walking01_lzsa: .incbin \"walking01.lzsa\"" >> intro_walking.inc
	echo "walking02_lzsa: .incbin \"walking02.lzsa\"" >> intro_walking.inc
	echo "walking03_lzsa: .incbin \"walking03.lzsa\"" >> intro_walking.inc
	echo "walking04_lzsa: .incbin \"walking04.lzsa\"" >> intro_walking.inc
	echo "walking05_lzsa: .incbin \"walking05.lzsa\"" >> intro_walking.inc
	echo "walking06_lzsa: .incbin \"walking06.lzsa\"" >> intro_walking.inc
	echo "walking07_lzsa: .incbin \"walking07.lzsa\"" >> intro_walking.inc
	echo "walking08_lzsa: .incbin \"walking08.lzsa\"" >> intro_walking.inc


#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa
