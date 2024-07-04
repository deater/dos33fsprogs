include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	captured_graphics.inc

captured_graphics.inc:	\
	riven01_iipix.hgr.zx02 \
	riven02_iipix.hgr.zx02 \
	riven03_iipix.hgr.zx02 \
	riven04_iipix.hgr.zx02
	echo "riven01_zx02: .incbin \"riven01_iipix.hgr.zx02\"" > captured_graphics.inc
	echo "riven02_zx02: .incbin \"riven02_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven03_zx02: .incbin \"riven03_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven04_zx02: .incbin \"riven04_iipix.hgr.zx02\"" >> captured_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr captured_graphics.inc
