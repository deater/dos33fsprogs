include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	chair_graphics.inc

chair_graphics.inc:	\
	chair_n.hgr.zx02 chair_s.hgr.zx02 \
	entrance_n.hgr.zx02 entrance_s.hgr.zx02 \
	entrance_open_s.hgr.zx02
	echo "chair_n_zx02: .incbin \"chair_n.hgr.zx02\"" > chair_graphics.inc
	echo "chair_s_zx02: .incbin \"chair_s.hgr.zx02\"" >> chair_graphics.inc
	echo "entrance_n_zx02: .incbin \"entrance_n.hgr.zx02\"" >> chair_graphics.inc
	echo "entrance_s_zx02: .incbin \"entrance_s.hgr.zx02\"" >> chair_graphics.inc
	echo "entrance_open_s_zx02: .incbin \"entrance_open_s.hgr.zx02\"" >> chair_graphics.inc



####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr chair_graphics.inc

