include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	maglev_overlay.gr.zx02 maglev_overlay_mask.gr.zx02 \
	combined_overlays.zx02


combined_overlays.zx02:	combined_overlays
	$(ZX02) -f combined_overlays combined_overlays.zx02

combined_overlays: \
	overlay25.gr \
	overlay29.gr \
	overlay30.gr \
	overlay31.gr \
	overlay32.gr \
	overlay33.gr \
	overlay34.gr \
	overlay35.gr
	cat overlay25.gr > combined_overlays
	cat overlay29.gr >> combined_overlays
	cat overlay30.gr >> combined_overlays
	cat overlay31.gr >> combined_overlays
	cat overlay32.gr >> combined_overlays
	cat overlay33.gr >> combined_overlays
	cat overlay34.gr >> combined_overlays
	cat overlay35.gr >> combined_overlays



####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr combined_overlays

