include ../../../../../Makefile.inc

PNG2RLE = ../../../../../utils/gr-utils/png2rle
PNG2LZ4 = ../../../../../utils/gr-utils/png2lz4
PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	intro_car.inc intro_building.inc intro_building_car.inc

intro_car.inc:	\
	intro_car1.lzsa intro_car2.lzsa \
	intro_car3.lzsa intro_car4.lzsa intro_car5.lzsa \
	intro_car6.lzsa intro_car7.lzsa intro_car8.lzsa \
	intro_car9.lzsa intro_car10.lzsa intro_car12.lzsa \
	intro_car13.lzsa intro_car14.lzsa \
	intro_building.lzsa \
	intro_building_car.lzsa
	echo "intro_car1_lzsa: .incbin \"intro_car1.lzsa\"" > intro_car.inc
	echo "intro_car2_lzsa: .incbin \"intro_car2.lzsa\"" >> intro_car.inc
	echo "intro_car3_lzsa: .incbin \"intro_car3.lzsa\"" >> intro_car.inc
	echo "intro_car4_lzsa: .incbin \"intro_car4.lzsa\"" >> intro_car.inc
	echo "intro_car5_lzsa: .incbin \"intro_car5.lzsa\"" >> intro_car.inc
	echo "intro_car6_lzsa: .incbin \"intro_car6.lzsa\"" >> intro_car.inc
	echo "intro_car7_lzsa: .incbin \"intro_car7.lzsa\"" >> intro_car.inc
	echo "intro_car8_lzsa: .incbin \"intro_car8.lzsa\"" >> intro_car.inc
	echo "intro_car9_lzsa: .incbin \"intro_car9.lzsa\"" >> intro_car.inc
	echo "intro_car10_lzsa: .incbin \"intro_car10.lzsa\"" >> intro_car.inc
	echo "intro_car12_lzsa: .incbin \"intro_car12.lzsa\"" >> intro_car.inc
	echo "intro_car13_lzsa: .incbin \"intro_car13.lzsa\"" >> intro_car.inc
	echo "intro_car14_lzsa: .incbin \"intro_car14.lzsa\"" >> intro_car.inc

intro_building.inc:	\
	intro_building.lzsa
	echo "intro_building_lzsa: .incbin \"intro_building.lzsa\"" > intro_building.inc

intro_building_car.inc:	\
	intro_building_car.lzsa
	echo "intro_building_car_lzsa: .incbin \"intro_building_car.lzsa\"" > intro_building_car.inc

#####

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa
