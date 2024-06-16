include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	maglev_graphics.inc

maglev_graphics.inc:	\
	inseat_s.hgr.zx02 inseat_w.hgr.zx02 inseat_e.hgr.zx02 \
	lookin_w.hgr.zx02
	echo "inseat_s_zx02: .incbin \"inseat_s.hgr.zx02\"" > maglev_graphics.inc
	echo "inseat_w_zx02: .incbin \"inseat_w.hgr.zx02\"" >> maglev_graphics.inc
	echo "inseat_e_zx02: .incbin \"inseat_e.hgr.zx02\"" >> maglev_graphics.inc
	echo "lookin_w_zx02: .incbin \"lookin_w.hgr.zx02\"" >> maglev_graphics.inc



####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr maglev_graphics.inc

