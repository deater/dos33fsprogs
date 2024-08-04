include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	downsteps_graphics3.inc

downsteps_graphics3.inc:	\
	downsteps3_n.hgr.zx02 downsteps3_s.hgr.zx02 downsteps3_e.hgr.zx02
	echo "downsteps3_n_zx02: .incbin \"downsteps3_n.hgr.zx02\"" > downsteps3_graphics.inc
	echo "downsteps3_s_zx02: .incbin \"downsteps3_s.hgr.zx02\"" >> downsteps3_graphics.inc
	echo "downsteps3_e_zx02: .incbin \"downsteps3_e.hgr.zx02\"" >> downsteps3_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr downsteps3_graphics.inc

