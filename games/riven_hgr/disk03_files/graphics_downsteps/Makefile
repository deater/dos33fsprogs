include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	downsteps_graphics.inc

downsteps_graphics.inc:	\
	down1_n.hgr.zx02 down1_s.hgr.zx02 \
	down2_n.hgr.zx02 down2_s.hgr.zx02 down2_e.hgr.zx02
	echo "down1_n_zx02: .incbin \"down1_n.hgr.zx02\"" > downsteps_graphics.inc
	echo "down1_s_zx02: .incbin \"down1_s.hgr.zx02\"" >> downsteps_graphics.inc
	echo "down2_n_zx02: .incbin \"down2_n.hgr.zx02\"" >> downsteps_graphics.inc
	echo "down2_s_zx02: .incbin \"down2_s.hgr.zx02\"" >> downsteps_graphics.inc
	echo "down2_e_zx02: .incbin \"down2_e.hgr.zx02\"" >> downsteps_graphics.inc




####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr downsteps_graphics.inc

