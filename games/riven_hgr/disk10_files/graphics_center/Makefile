include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	center_graphics.inc

center_graphics.inc:	\
	center_12.hgr.zx02 center_23.hgr.zx02 \
	center_34.hgr.zx02 center_45.hgr.zx02 \
	center_51.hgr.zx02
	echo "center_12_zx02: .incbin \"center_12.hgr.zx02\"" > center_graphics.inc
	echo "center_23_zx02: .incbin \"center_23.hgr.zx02\"" >> center_graphics.inc
	echo "center_34_zx02: .incbin \"center_34.hgr.zx02\"" >> center_graphics.inc
	echo "center_45_zx02: .incbin \"center_45.hgr.zx02\"" >> center_graphics.inc
	echo "center_51_zx02: .incbin \"center_51.hgr.zx02\"" >> center_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr center_graphics.inc

