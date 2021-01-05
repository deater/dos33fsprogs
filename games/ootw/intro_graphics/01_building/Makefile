include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4


all:	intro_car.inc intro_building.inc intro_building_car.inc \
	intro_car_lz4.inc intro_building_lz4.inc intro_building_car_lz4.inc

#####

intro_building_car.inc:	$(PNG2RLE) intro_building_car.png
	$(PNG2RLE) asm intro_building_car.png building_car_rle > intro_building_car.inc

#####

intro_building.inc:	$(PNG2RLE) intro_building.png
	$(PNG2RLE) asm intro_building.png building_rle > intro_building.inc

#####

intro_car.inc:	$(PNG2RLE) intro_car1.png intro_car2.png \
	intro_car3.png intro_car4.png intro_car5.png \
	intro_car6.png intro_car7.png intro_car8.png \
	intro_car9.png intro_car10.png intro_car12.png \
	intro_car13.png intro_car14.png
	$(PNG2RLE) asm intro_car1.png intro_car1 > intro_car.inc
	$(PNG2RLE) asm intro_car2.png intro_car2 >> intro_car.inc
	$(PNG2RLE) asm intro_car3.png intro_car3 >> intro_car.inc
	$(PNG2RLE) asm intro_car4.png intro_car4 >> intro_car.inc
	$(PNG2RLE) asm intro_car5.png intro_car5 >> intro_car.inc
	$(PNG2RLE) asm intro_car6.png intro_car6 >> intro_car.inc
	$(PNG2RLE) asm intro_car7.png intro_car7 >> intro_car.inc
	$(PNG2RLE) asm intro_car8.png intro_car8 >> intro_car.inc
	$(PNG2RLE) asm intro_car9.png intro_car9 >> intro_car.inc
	$(PNG2RLE) asm intro_car10.png intro_car10 >> intro_car.inc
	$(PNG2RLE) asm intro_car12.png intro_car12 >> intro_car.inc
	$(PNG2RLE) asm intro_car13.png intro_car13 >> intro_car.inc
	$(PNG2RLE) asm intro_car14.png intro_car14 >> intro_car.inc


#####

intro_building_car_lz4.inc:	$(PNG2LZ4) intro_building_car.png
	$(PNG2LZ4) asm intro_building_car.png building_car_rle > intro_building_car_lz4.inc

#####

intro_building_lz4.inc:	$(PNG2LZ4) intro_building.png
	$(PNG2LZ4) asm intro_building.png building_rle > intro_building_lz4.inc



#####

intro_car_lz4.inc:	$(PNG2LZ4) intro_car1.png intro_car2.png \
	intro_car3.png intro_car4.png intro_car5.png \
	intro_car6.png intro_car7.png intro_car8.png \
	intro_car9.png intro_car10.png intro_car12.png \
	intro_car13.png intro_car14.png
	$(PNG2LZ4) asm intro_car1.png intro_car1 > intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car2.png intro_car2 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car3.png intro_car3 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car4.png intro_car4 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car5.png intro_car5 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car6.png intro_car6 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car7.png intro_car7 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car8.png intro_car8 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car9.png intro_car9 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car10.png intro_car10 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car12.png intro_car12 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car13.png intro_car13 >> intro_car_lz4.inc
	$(PNG2LZ4) asm intro_car14.png intro_car14 >> intro_car_lz4.inc


#####

clean:		
		rm -f *~ *.inc
