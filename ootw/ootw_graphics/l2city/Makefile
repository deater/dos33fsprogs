include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle
PNG2LZ4 = ../../../gr-utils/png2lz4

all:	city_movie.inc

#####

city_movie.inc:	$(PNG2RLE) \
	ncity01.png ncity02.png ncity03.png ncity04.png ncity05.png \
	ncity06.png ncity07.png ncity08.png ncity09.png ncity10.png \
	ncity11.png ncity12.png ncity13.png ncity14.png
	$(PNG2RLE) asm ncity01.png city01_rle > city_movie.inc
	$(PNG2RLE) asm ncity02.png city02_rle >> city_movie.inc
	$(PNG2RLE) asm ncity03.png city03_rle >> city_movie.inc
	$(PNG2RLE) asm ncity04.png city04_rle >> city_movie.inc
	$(PNG2RLE) asm ncity05.png city05_rle >> city_movie.inc
	$(PNG2RLE) asm ncity06.png city06_rle >> city_movie.inc
	$(PNG2RLE) asm ncity07.png city07_rle >> city_movie.inc
	$(PNG2RLE) asm ncity08.png city08_rle >> city_movie.inc
	$(PNG2RLE) asm ncity09.png city09_rle >> city_movie.inc
	$(PNG2RLE) asm ncity10.png city10_rle >> city_movie.inc
	$(PNG2RLE) asm ncity11.png city11_rle >> city_movie.inc
	$(PNG2RLE) asm ncity12.png city12_rle >> city_movie.inc
	$(PNG2RLE) asm ncity13.png city13_rle >> city_movie.inc
	$(PNG2RLE) asm ncity14.png city14_rle >> city_movie.inc



#####

clean:		
		rm -f *~ *.o *.lst city_movie.inc

