include ../../../../../Makefile.inc

#PNG2RLE = ../../../gr-utils/png2rle
#PNG2LZ4 = ../../../gr-utils/png2lz4

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
#
#intro_elevator.inc:	$(PNG2RLE) intro_elevator.png
#	$(PNG2RLE) asm intro_elevator.png elevator_rle > intro_elevator.inc
#
#intro_off_elevator.inc:	$(PNG2RLE) intro_off_elevator.png
#	$(PNG2RLE) asm intro_off_elevator.png off_elevator_rle > intro_off_elevator.inc
#
#intro_walking.inc:	$(PNG2RLE) walking00.png walking01.png walking02.png \
#		walking03.png walking04.png walking05.png walking06.png \
#		walking07.png walking08.png
#	$(PNG2RLE) asm walking01.png walking00_rle > intro_walking.inc
#	$(PNG2RLE) asm walking01.png walking01_rle >> intro_walking.inc
#	$(PNG2RLE) asm walking02.png walking02_rle >> intro_walking.inc
#	$(PNG2RLE) asm walking03.png walking03_rle >> intro_walking.inc
#	$(PNG2RLE) asm walking04.png walking04_rle >> intro_walking.inc
#	$(PNG2RLE) asm walking05.png walking05_rle >> intro_walking.inc
#	$(PNG2RLE) asm walking06.png walking06_rle >> intro_walking.inc
#	$(PNG2RLE) asm walking07.png walking07_rle >> intro_walking.inc
#	$(PNG2RLE) asm walking08.png walking08_rle >> intro_walking.inc

#####

#intro_elevator_lz4.inc:	$(PNG2LZ4) intro_elevator.png
#	$(PNG2LZ4) asm intro_elevator.png elevator_rle > intro_elevator_lz4.inc

#intro_off_elevator_lz4.inc:	$(PNG2LZ4) intro_off_elevator.png
#	$(PNG2LZ4) asm intro_off_elevator.png off_elevator_rle > intro_off_elevator_lz4.inc

#intro_walking_lz4.inc:	$(PNG2LZ4) walking00.png walking01.png walking02.png \
#		walking03.png walking04.png walking05.png walking06.png \
#		walking07.png walking08.png
#	$(PNG2LZ4) asm walking01.png walking00_rle > intro_walking_lz4.inc
#	$(PNG2LZ4) asm walking01.png walking01_rle >> intro_walking_lz4.inc
#	$(PNG2LZ4) asm walking02.png walking02_rle >> intro_walking_lz4.inc
#	$(PNG2LZ4) asm walking03.png walking03_rle >> intro_walking_lz4.inc
#	$(PNG2LZ4) asm walking04.png walking04_rle >> intro_walking_lz4.inc
#	$(PNG2LZ4) asm walking05.png walking05_rle >> intro_walking_lz4.inc
#	$(PNG2LZ4) asm walking06.png walking06_rle >> intro_walking_lz4.inc
#	$(PNG2LZ4) asm walking07.png walking07_rle >> intro_walking_lz4.inc
#	$(PNG2LZ4) asm walking08.png walking08_rle >> intro_walking_lz4.inc


#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa
