include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	telescope_graphics.inc

telescope_graphics.inc:	\
	telescope_n.hgr.zx02 telescope_s.hgr.zx02 telescope_e.hgr.zx02 telescope_w.hgr.zx02 \
	manhole_w.hgr.zx02
	echo "telescope_n_zx02: .incbin \"telescope_n.hgr.zx02\"" > telescope_graphics.inc
	echo "telescope_s_zx02: .incbin \"telescope_s.hgr.zx02\"" >> telescope_graphics.inc
	echo "telescope_e_zx02: .incbin \"telescope_e.hgr.zx02\"" >> telescope_graphics.inc
	echo "telescope_w_zx02: .incbin \"telescope_w.hgr.zx02\"" >> telescope_graphics.inc
	echo "manhole_w_zx02: .incbin \"manhole_w.hgr.zx02\"" >> telescope_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr telescope_graphics.inc

