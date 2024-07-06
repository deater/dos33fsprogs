include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	cho_graphics.inc

cho_graphics.inc:	\
	captured_bg.gr.zx02 \
	captured_cage_bg.gr.zx02 \
	empty.gr.zx02 \
	cho_overlay006.gr.zx02 cho_overlay007.gr.zx02 \
	cho_overlay008.gr.zx02 cho_overlay009.gr.zx02 \
	cho_overlay010.gr.zx02 cho_overlay011.gr.zx02 \
	cho_overlay012.gr.zx02 cho_overlay013.gr.zx02 \
	cho_overlay014.gr.zx02 cho_overlay015.gr.zx02 \
	cho_overlay016.gr.zx02 cho_overlay017.gr.zx02 \
	cho_overlay018.gr.zx02 cho_overlay019.gr.zx02 \
	cho_overlay020.gr.zx02
	echo "captured_bg: .incbin \"captured_bg.gr.zx02\"" > cho_graphics.inc
	echo "captured_cage_bg: .incbin \"captured_cage_bg.gr.zx02\"" >> cho_graphics.inc
	echo "empty: .incbin \"empty.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay006: .incbin \"cho_overlay006.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay007: .incbin \"cho_overlay007.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay008: .incbin \"cho_overlay008.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay009: .incbin \"cho_overlay009.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay010: .incbin \"cho_overlay010.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay011: .incbin \"cho_overlay011.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay012: .incbin \"cho_overlay012.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay013: .incbin \"cho_overlay013.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay014: .incbin \"cho_overlay014.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay015: .incbin \"cho_overlay015.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay016: .incbin \"cho_overlay016.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay017: .incbin \"cho_overlay017.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay018: .incbin \"cho_overlay018.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay019: .incbin \"cho_overlay019.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay020: .incbin \"cho_overlay020.gr.zx02\"" >> cho_graphics.inc





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
