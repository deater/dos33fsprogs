include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	cho_graphics.inc

cho_graphics.inc:	\
	captured_bg.gr.zx02
	echo "captured_bg: .incbin \"captured_bg.gr.zx02\"" > cho_graphics.inc

####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02:	%.gr
	$(ZX02) -f $< $@

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr cho_graphics.inc
