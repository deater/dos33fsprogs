include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	start_graphics.inc

start_graphics.inc:	\
	start_n.hgr.zx02 start_w.hgr.zx02 start_e.hgr.zx02 start_s.hgr.zx02
	echo "start_n_zx02: .incbin \"start_n.hgr.zx02\"" > start_graphics.inc
	echo "start_w_zx02: .incbin \"start_w.hgr.zx02\"" >> start_graphics.inc
	echo "start_e_zx02: .incbin \"start_e.hgr.zx02\"" >> start_graphics.inc
	echo "start_s_zx02: .incbin \"start_s.hgr.zx02\"" >> start_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr start_graphics.inc

