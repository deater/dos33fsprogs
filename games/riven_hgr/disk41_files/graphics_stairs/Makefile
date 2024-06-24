include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	stairs_graphics.inc

stairs_graphics.inc:	\
	stairs_s.hgr.zx02 stairs_n.hgr.zx02 \
	stairs_e.hgr.zx02 stairs_w.hgr.zx02 \
	stairs_down1_e.hgr.zx02 stairs_down1_w.hgr.zx02
	echo "stairs_s_zx02: .incbin \"stairs_s.hgr.zx02\"" > stairs_graphics.inc
	echo "stairs_n_zx02: .incbin \"stairs_n.hgr.zx02\"" >> stairs_graphics.inc
	echo "stairs_e_zx02: .incbin \"stairs_e.hgr.zx02\"" >> stairs_graphics.inc
	echo "stairs_w_zx02: .incbin \"stairs_w.hgr.zx02\"" >> stairs_graphics.inc
	echo "stairs_down1_e_zx02: .incbin \"stairs_down1_e.hgr.zx02\"" >> stairs_graphics.inc
	echo "stairs_down1_w_zx02: .incbin \"stairs_down1_w.hgr.zx02\"" >> stairs_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr stairs_graphics.inc

