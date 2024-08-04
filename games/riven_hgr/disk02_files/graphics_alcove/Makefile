include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	alcove_graphics.inc

alcove_graphics.inc:	\
	alcove_e.hgr.zx02 \
	alcove_w.hgr.zx02 alcove2_w.hgr.zx02 alcove3_w.hgr.zx02
	echo "alcove_e_zx02: .incbin \"alcove_e.hgr.zx02\"" > alcove_graphics.inc
	echo "alcove_w_zx02: .incbin \"alcove_w.hgr.zx02\"" >> alcove_graphics.inc
	echo "alcove2_w_zx02: .incbin \"alcove2_w.hgr.zx02\"" >> alcove_graphics.inc
	echo "alcove3_w_zx02: .incbin \"alcove3_w.hgr.zx02\"" >> alcove_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr alcove_graphics.inc

