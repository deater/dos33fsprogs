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




#	$(PNG2RLE) asm intro_car1.png intro_car1 > intro_car.inc
#	$(PNG2RLE) asm intro_car2.png intro_car2 >> intro_car.inc
#	$(PNG2RLE) asm intro_car3.png intro_car3 >> intro_car.inc
#	$(PNG2RLE) asm intro_car4.png intro_car4 >> intro_car.inc
#	$(PNG2RLE) asm intro_car5.png intro_car5 >> intro_car.inc
#	$(PNG2RLE) asm intro_car6.png intro_car6 >> intro_car.inc
#	$(PNG2RLE) asm intro_car7.png intro_car7 >> intro_car.inc
#	$(PNG2RLE) asm intro_car8.png intro_car8 >> intro_car.inc
#	$(PNG2RLE) asm intro_car9.png intro_car9 >> intro_car.inc
#	$(PNG2RLE) asm intro_car10.png intro_car10 >> intro_car.inc
#	$(PNG2RLE) asm intro_car12.png intro_car12 >> intro_car.inc
#	$(PNG2RLE) asm intro_car13.png intro_car13 >> intro_car.inc
#	$(PNG2RLE) asm intro_car14.png intro_car14 >> intro_car.inc

%.gr: %.png
	$(PNG2GR) $< $@

%.lzsa: %.gr
	$(LZSA) -r -f2 $< $@

#all:	intro_car.inc intro_building.inc intro_building_car.inc \
#	intro_car_lz4.inc intro_building_lz4.inc intro_building_car_lz4.inc

#####

#intro_building_car.inc:	$(PNG2RLE) intro_building_car.png
#	$(PNG2RLE) asm intro_building_car.png building_car_rle > intro_building_car.inc

#####

#intro_building.inc:	$(PNG2RLE) intro_building.png
#	$(PNG2RLE) asm intro_building.png building_rle > intro_building.inc

#####

#intro_car.inc:	$(PNG2RLE) intro_car1.png intro_car2.png \
#	intro_car3.png intro_car4.png intro_car5.png \
#	intro_car6.png intro_car7.png intro_car8.png \
#	intro_car9.png intro_car10.png intro_car12.png \
#	intro_car13.png intro_car14.png
#	$(PNG2RLE) asm intro_car1.png intro_car1 > intro_car.inc
#	$(PNG2RLE) asm intro_car2.png intro_car2 >> intro_car.inc
#	$(PNG2RLE) asm intro_car3.png intro_car3 >> intro_car.inc
#	$(PNG2RLE) asm intro_car4.png intro_car4 >> intro_car.inc
#	$(PNG2RLE) asm intro_car5.png intro_car5 >> intro_car.inc
#	$(PNG2RLE) asm intro_car6.png intro_car6 >> intro_car.inc
#	$(PNG2RLE) asm intro_car7.png intro_car7 >> intro_car.inc
#	$(PNG2RLE) asm intro_car8.png intro_car8 >> intro_car.inc
#	$(PNG2RLE) asm intro_car9.png intro_car9 >> intro_car.inc
#	$(PNG2RLE) asm intro_car10.png intro_car10 >> intro_car.inc
#	$(PNG2RLE) asm intro_car12.png intro_car12 >> intro_car.inc
#	$(PNG2RLE) asm intro_car13.png intro_car13 >> intro_car.inc
#	$(PNG2RLE) asm intro_car14.png intro_car14 >> intro_car.inc


#####

#intro_building_car_lz4.inc:	$(PNG2LZ4) intro_building_car.png
#	$(PNG2LZ4) asm intro_building_car.png building_car_rle > intro_building_car_lz4.inc

#####

#intro_building_lz4.inc:	$(PNG2LZ4) intro_building.png
#	$(PNG2LZ4) asm intro_building.png building_rle > intro_building_lz4.inc



#####

#intro_car_lz4.inc:	$(PNG2LZ4) intro_car1.png intro_car2.png \
#	intro_car3.png intro_car4.png intro_car5.png \
#	intro_car6.png intro_car7.png intro_car8.png \
#	intro_car9.png intro_car10.png intro_car12.png \
#	intro_car13.png intro_car14.png
#	$(PNG2LZ4) asm intro_car1.png intro_car1 > intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car2.png intro_car2 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car3.png intro_car3 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car4.png intro_car4 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car5.png intro_car5 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car6.png intro_car6 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car7.png intro_car7 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car8.png intro_car8 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car9.png intro_car9 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car10.png intro_car10 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car12.png intro_car12 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car13.png intro_car13 >> intro_car_lz4.inc
#	$(PNG2LZ4) asm intro_car14.png intro_car14 >> intro_car_lz4.inc


#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa
