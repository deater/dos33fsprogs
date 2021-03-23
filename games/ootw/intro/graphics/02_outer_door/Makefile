include ../../../../../Makefile.inc

PNG2GR = ../../../../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	outer_door.inc feet.inc

#####

outer_door.inc:	outer_door.lzsa
	echo "outer_door_lzsa: .incbin\"outer_door.lzsa\"" > outer_door.inc


feet.inc:	feet01.lzsa feet02.lzsa \
		feet03.lzsa feet04.lzsa feet05.lzsa feet06.lzsa \
		feet07.lzsa feet08.lzsa feet09.lzsa feet10.lzsa \
		feet11.lzsa feet12.lzsa feet13.lzsa feet14.lzsa \
		feet15.lzsa blank.lzsa
	echo "feet01_lzsa: .incbin\"feet01.lzsa\"" > feet.inc
	echo "feet02_lzsa: .incbin\"feet02.lzsa\"" >> feet.inc
	echo "feet03_lzsa: .incbin\"feet03.lzsa\"" >> feet.inc
	echo "feet04_lzsa: .incbin\"feet04.lzsa\"" >> feet.inc
	echo "feet05_lzsa: .incbin\"feet05.lzsa\"" >> feet.inc
	echo "feet06_lzsa: .incbin\"feet06.lzsa\"" >> feet.inc
	echo "feet07_lzsa: .incbin\"feet07.lzsa\"" >> feet.inc
	echo "feet08_lzsa: .incbin\"feet08.lzsa\"" >> feet.inc
	echo "feet09_lzsa: .incbin\"feet09.lzsa\"" >> feet.inc
	echo "feet10_lzsa: .incbin\"feet10.lzsa\"" >> feet.inc
	echo "feet11_lzsa: .incbin\"feet11.lzsa\"" >> feet.inc
	echo "feet12_lzsa: .incbin\"feet12.lzsa\"" >> feet.inc
	echo "feet13_lzsa: .incbin\"feet13.lzsa\"" >> feet.inc
	echo "feet14_lzsa: .incbin\"feet14.lzsa\"" >> feet.inc
	echo "feet15_lzsa: .incbin\"feet15.lzsa\"" >> feet.inc

####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

#####

clean:		
		rm -f *~ *.inc *.gr *.lzsa
