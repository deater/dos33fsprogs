
PNG2GR = ../../gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa

all:	duke_graphics.inc

####

duke_graphics.inc:	duke1_bg.lzsa
	echo "duke1_bg_lzsa: .incbin \"duke1_bg.lzsa\"" > duke_graphics.inc

####

%.gr:	%.png
	$(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@

####

clean:		
	rm -f *~ *.o *.lst *.lzsa duke_graphics.inc
