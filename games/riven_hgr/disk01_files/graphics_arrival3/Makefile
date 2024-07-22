include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	arrival3_graphics.inc

arrival3_graphics.inc:	\
	arrival3_n.hgr.zx02 arrival3_s.hgr.zx02 arrival3_e.hgr.zx02 arrival3_w.hgr.zx02 \
	arrival4_n.hgr.zx02 arrival4_s.hgr.zx02 arrival5_n.hgr.zx02
	echo "arrival3_n_zx02: .incbin \"arrival3_n.hgr.zx02\"" > arrival3_graphics.inc
	echo "arrival3_s_zx02: .incbin \"arrival3_s.hgr.zx02\"" >> arrival3_graphics.inc
	echo "arrival3_e_zx02: .incbin \"arrival3_e.hgr.zx02\"" >> arrival3_graphics.inc
	echo "arrival3_w_zx02: .incbin \"arrival3_w.hgr.zx02\"" >> arrival3_graphics.inc
	echo "arrival4_n_zx02: .incbin \"arrival4_n.hgr.zx02\"" >> arrival3_graphics.inc
	echo "arrival4_s_zx02: .incbin \"arrival4_s.hgr.zx02\"" >> arrival3_graphics.inc
	echo "arrival5_n_zx02: .incbin \"arrival5_n.hgr.zx02\"" >> arrival3_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr arrival3_graphics.inc

