include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4


all:	intro_elevator.inc intro_off_elevator.inc intro_walking.inc \
	intro_elevator_lz4.inc intro_off_elevator_lz4.inc intro_walking_lz4.inc

#####

intro_elevator.inc:	$(PNG2RLE) intro_elevator.png
	$(PNG2RLE) asm intro_elevator.png elevator_rle > intro_elevator.inc

intro_off_elevator.inc:	$(PNG2RLE) intro_off_elevator.png
	$(PNG2RLE) asm intro_off_elevator.png off_elevator_rle > intro_off_elevator.inc

intro_walking.inc:	$(PNG2RLE) walking00.png walking01.png walking02.png \
		walking03.png walking04.png walking05.png walking06.png \
		walking07.png walking08.png
	$(PNG2RLE) asm walking01.png walking00_rle > intro_walking.inc
	$(PNG2RLE) asm walking01.png walking01_rle >> intro_walking.inc
	$(PNG2RLE) asm walking02.png walking02_rle >> intro_walking.inc
	$(PNG2RLE) asm walking03.png walking03_rle >> intro_walking.inc
	$(PNG2RLE) asm walking04.png walking04_rle >> intro_walking.inc
	$(PNG2RLE) asm walking05.png walking05_rle >> intro_walking.inc
	$(PNG2RLE) asm walking06.png walking06_rle >> intro_walking.inc
	$(PNG2RLE) asm walking07.png walking07_rle >> intro_walking.inc
	$(PNG2RLE) asm walking08.png walking08_rle >> intro_walking.inc

#####

intro_elevator_lz4.inc:	$(PNG2LZ4) intro_elevator.png
	$(PNG2LZ4) asm intro_elevator.png elevator_rle > intro_elevator_lz4.inc

intro_off_elevator_lz4.inc:	$(PNG2LZ4) intro_off_elevator.png
	$(PNG2LZ4) asm intro_off_elevator.png off_elevator_rle > intro_off_elevator_lz4.inc

intro_walking_lz4.inc:	$(PNG2LZ4) walking00.png walking01.png walking02.png \
		walking03.png walking04.png walking05.png walking06.png \
		walking07.png walking08.png
	$(PNG2LZ4) asm walking01.png walking00_rle > intro_walking_lz4.inc
	$(PNG2LZ4) asm walking01.png walking01_rle >> intro_walking_lz4.inc
	$(PNG2LZ4) asm walking02.png walking02_rle >> intro_walking_lz4.inc
	$(PNG2LZ4) asm walking03.png walking03_rle >> intro_walking_lz4.inc
	$(PNG2LZ4) asm walking04.png walking04_rle >> intro_walking_lz4.inc
	$(PNG2LZ4) asm walking05.png walking05_rle >> intro_walking_lz4.inc
	$(PNG2LZ4) asm walking06.png walking06_rle >> intro_walking_lz4.inc
	$(PNG2LZ4) asm walking07.png walking07_rle >> intro_walking_lz4.inc
	$(PNG2LZ4) asm walking08.png walking08_rle >> intro_walking_lz4.inc


#####

clean:		
		rm -f *~ *.inc
