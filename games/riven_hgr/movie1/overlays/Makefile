include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	maglev_overlay.gr.zx02 maglev_overlay_mask.gr.zx02 \
	overlay25.gr.zx02 \
	overlay29.gr.zx02 \
	overlay30.gr.zx02 \
	overlay31.gr.zx02 \
	overlay32.gr.zx02 \
	overlay33.gr.zx02 \
	overlay34.gr.zx02 \
	overlay35.gr.zx02

####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr

