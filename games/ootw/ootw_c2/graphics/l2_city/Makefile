include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	city_movie.inc

#####

city_movie.inc:	\
	ncity01.lzsa ncity02.lzsa ncity03.lzsa ncity04.lzsa ncity05.lzsa \
	ncity06.lzsa ncity07.lzsa ncity08.lzsa ncity09.lzsa ncity10.lzsa \
	ncity11.lzsa ncity12.lzsa ncity13.lzsa ncity14.lzsa
	echo "city01_lzsa: .incbin \"ncity01.lzsa\"" > city_movie.inc
	echo "city02_lzsa: .incbin \"ncity02.lzsa\"" >> city_movie.inc
	echo "city03_lzsa: .incbin \"ncity03.lzsa\"" >> city_movie.inc
	echo "city04_lzsa: .incbin \"ncity04.lzsa\"" >> city_movie.inc
	echo "city05_lzsa: .incbin \"ncity05.lzsa\"" >> city_movie.inc
	echo "city06_lzsa: .incbin \"ncity06.lzsa\"" >> city_movie.inc
	echo "city07_lzsa: .incbin \"ncity07.lzsa\"" >> city_movie.inc
	echo "city08_lzsa: .incbin \"ncity08.lzsa\"" >> city_movie.inc
	echo "city09_lzsa: .incbin \"ncity09.lzsa\"" >> city_movie.inc
	echo "city10_lzsa: .incbin \"ncity10.lzsa\"" >> city_movie.inc
	echo "city11_lzsa: .incbin \"ncity11.lzsa\"" >> city_movie.inc
	echo "city12_lzsa: .incbin \"ncity12.lzsa\"" >> city_movie.inc
	echo "city13_lzsa: .incbin \"ncity13.lzsa\"" >> city_movie.inc
	echo "city14_lzsa: .incbin \"ncity14.lzsa\"" >> city_movie.inc



#####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.o *.lst *.lzsa *.gr city_movie.inc

