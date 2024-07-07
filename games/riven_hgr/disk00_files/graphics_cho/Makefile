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
	cho_overlay020.gr.zx02 cho_overlay021.gr.zx02 \
	cho_overlay022.gr.zx02 cho_overlay023.gr.zx02 \
	cho_overlay024.gr.zx02 cho_overlay025.gr.zx02 \
	cho_overlay026.gr.zx02 cho_overlay027.gr.zx02 \
	cho_overlay028.gr.zx02 cho_overlay029.gr.zx02 \
	cho_overlay030.gr.zx02 cho_overlay031.gr.zx02 \
	cho_overlay032.gr.zx02 cho_overlay033.gr.zx02 \
	cho_overlay034.gr.zx02 cho_overlay035.gr.zx02 \
	cho_overlay036.gr.zx02 cho_overlay037.gr.zx02 \
	cho_overlay038.gr.zx02 cho_overlay039.gr.zx02 \
	cho_overlay040.gr.zx02
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
	echo "cho_overlay021: .incbin \"cho_overlay021.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay022: .incbin \"cho_overlay022.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay023: .incbin \"cho_overlay023.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay024: .incbin \"cho_overlay024.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay025: .incbin \"cho_overlay025.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay026: .incbin \"cho_overlay026.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay027: .incbin \"cho_overlay027.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay028: .incbin \"cho_overlay028.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay029: .incbin \"cho_overlay029.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay030: .incbin \"cho_overlay030.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay031: .incbin \"cho_overlay031.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay032: .incbin \"cho_overlay032.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay033: .incbin \"cho_overlay033.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay034: .incbin \"cho_overlay034.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay035: .incbin \"cho_overlay035.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay036: .incbin \"cho_overlay036.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay037: .incbin \"cho_overlay037.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay038: .incbin \"cho_overlay038.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay039: .incbin \"cho_overlay039.gr.zx02\"" >> cho_graphics.inc
	echo "cho_overlay040: .incbin \"cho_overlay040.gr.zx02\"" >> cho_graphics.inc







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
