include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	fish_graphics.inc

fish_graphics.inc:	\
	fish_n.hgr.zx02 fish_s.hgr.zx02
# fish_e.hgr.zx02 fish_s.hgr.zx02
	echo "fish_n_zx02: .incbin \"fish_n.hgr.zx02\"" > fish_graphics.inc
	echo "fish_s_zx02: .incbin \"fish_s.hgr.zx02\"" >> fish_graphics.inc
#	echo "fish_w_zx02: .incbin \"fish_w.hgr.zx02\"" >> fish_graphics.inc
#	echo "fish_e_zx02: .incbin \"fish_e.hgr.zx02\"" >> fish_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr fish_graphics.inc

