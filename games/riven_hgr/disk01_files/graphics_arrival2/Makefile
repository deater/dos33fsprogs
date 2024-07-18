include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	arrival2_graphics.inc

arrival2_graphics.inc:	\
	arrival2_n.hgr.zx02 arrival2_s.hgr.zx02 arrival2_e.hgr.zx02 arrival2_w.hgr.zx02
	echo "arrival2_n_zx02: .incbin \"arrival2_n.hgr.zx02\"" > arrival2_graphics.inc
	echo "arrival2_s_zx02: .incbin \"arrival2_s.hgr.zx02\"" >> arrival2_graphics.inc
	echo "arrival2_e_zx02: .incbin \"arrival2_e.hgr.zx02\"" >> arrival2_graphics.inc
	echo "arrival2_w_zx02: .incbin \"arrival2_w.hgr.zx02\"" >> arrival2_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr arrival2_graphics.inc

