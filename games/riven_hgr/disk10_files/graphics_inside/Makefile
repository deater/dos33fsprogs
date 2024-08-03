include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	inside_graphics.inc

inside_graphics.inc:	\
	entrance_w.hgr.zx02 entrance_e.hgr.zx02
	echo "entrance_w_zx02: .incbin \"entrance_w.hgr.zx02\"" > inside_graphics.inc
	echo "entrance_e_zx02: .incbin \"entrance_e.hgr.zx02\"" >> inside_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr inside_graphics.inc

