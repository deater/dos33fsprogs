include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	logged_graphics.inc

logged_graphics.inc:	\
	logged_w.hgr.zx02 logged_e.hgr.zx02 \
	logged2_w.hgr.zx02 logged2_e.hgr.zx02
	echo "logged_w_zx02: .incbin \"logged_w.hgr.zx02\"" > logged_graphics.inc
	echo "logged_e_zx02: .incbin \"logged_e.hgr.zx02\"" >> logged_graphics.inc
	echo "logged2_w_zx02: .incbin \"logged2_w.hgr.zx02\"" >> logged_graphics.inc
	echo "logged2_e_zx02: .incbin \"logged2_e.hgr.zx02\"" >> logged_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr logged_graphics.inc

