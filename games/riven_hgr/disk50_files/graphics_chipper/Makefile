include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	chipper_graphics.inc

chipper_graphics.inc:	\
	chipper_n.hgr.zx02 chipper_w.hgr.zx02 chipper_e.hgr.zx02 chipper_s.hgr.zx02
	echo "chipper_n_zx02: .incbin \"chipper_n.hgr.zx02\"" > chipper_graphics.inc
	echo "chipper_w_zx02: .incbin \"chipper_w.hgr.zx02\"" >> chipper_graphics.inc
	echo "chipper_e_zx02: .incbin \"chipper_e.hgr.zx02\"" >> chipper_graphics.inc
	echo "chipper_s_zx02: .incbin \"chipper_s.hgr.zx02\"" >> chipper_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr chipper_graphics.inc

