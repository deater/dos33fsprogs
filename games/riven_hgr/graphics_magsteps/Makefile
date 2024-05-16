include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr

all:	magsteps_graphics.inc

magsteps_graphics.inc:	\
	magsteps2_n.hgr.zx02 magsteps2_s.hgr.zx02 \
	magsteps3_n.hgr.zx02 magsteps3_s.hgr.zx02
	echo "magsteps2_n_zx02: .incbin \"magsteps2_n.hgr.zx02\"" > magsteps_graphics.inc
	echo "magsteps2_s_zx02: .incbin \"magsteps2_s.hgr.zx02\"" >> magsteps_graphics.inc
	echo "magsteps3_n_zx02: .incbin \"magsteps3_n.hgr.zx02\"" >> magsteps_graphics.inc
	echo "magsteps3_s_zx02: .incbin \"magsteps3_s.hgr.zx02\"" >> magsteps_graphics.inc



####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr magsteps_graphics.inc

