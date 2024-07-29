include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	path_graphics.inc

path_graphics.inc:	\
	path_n.hgr.zx02 path_s.hgr.zx02 path_e.hgr.zx02 path_w.hgr.zx02
	echo "path_n_zx02: .incbin \"path_n.hgr.zx02\"" > path_graphics.inc
	echo "path_s_zx02: .incbin \"path_s.hgr.zx02\"" >> path_graphics.inc
	echo "path_w_zx02: .incbin \"path_w.hgr.zx02\"" >> path_graphics.inc
	echo "path_e_zx02: .incbin \"path_e.hgr.zx02\"" >> path_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr path_graphics.inc

