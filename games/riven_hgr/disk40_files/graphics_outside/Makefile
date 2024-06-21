include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	outside_graphics.inc

outside_graphics.inc:	\
	out_path_e.hgr.zx02 out_path_w.hgr.zx02 \
	out_plaza_n.hgr.zx02 out_plaza_s.hgr.zx02 out_plaza_e.hgr.zx02 out_plaza_w.hgr.zx02
	echo "out_path_e_zx02: .incbin \"out_path_e.hgr.zx02\"" > outside_graphics.inc
	echo "out_path_w_zx02: .incbin \"out_path_w.hgr.zx02\"" >> outside_graphics.inc
	echo "out_plaza_n_zx02: .incbin \"out_plaza_n.hgr.zx02\"" >> outside_graphics.inc
	echo "out_plaza_s_zx02: .incbin \"out_plaza_s.hgr.zx02\"" >> outside_graphics.inc
	echo "out_plaza_e_zx02: .incbin \"out_plaza_e.hgr.zx02\"" >> outside_graphics.inc
	echo "out_plaza_w_zx02: .incbin \"out_plaza_w.hgr.zx02\"" >> outside_graphics.inc



####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr outside_graphics.inc

