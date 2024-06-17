include ../../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../../utils/gr-utils/png2gr

all:	maglev_overlay.gr.zx02 maglev_overlay_mask.gr.zx02 \
	overlay_combined.zx02

overlay_combined.zx02:	overlay_combined
	$(ZX02) -f overlay_combined overlay_combined.zx02

overlay_combined: \
	overlay103.gr \
	overlay104.gr \
	overlay105.gr \
	overlay106.gr \
	overlay107.gr \
	overlay108.gr \
	overlay109.gr
	cat overlay103.gr > overlay_combined
	cat overlay104.gr >> overlay_combined
	cat overlay105.gr >> overlay_combined
	cat overlay106.gr >> overlay_combined
	cat overlay107.gr >> overlay_combined
	cat overlay108.gr >> overlay_combined
	cat overlay109.gr >> overlay_combined


####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02: %.gr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.gr overlay_combined

