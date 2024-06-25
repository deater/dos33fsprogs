include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	stairs2_graphics.inc

stairs2_graphics.inc:	\
	stairs_up2_e.hgr.zx02 stairs_up2_w.hgr.zx02 \
	stairs_up3_e.hgr.zx02 stairs_up3_w.hgr.zx02 \
	stairs_up4_e.hgr.zx02 stairs_up4_w.hgr.zx02
	echo "stairs_up2_e_zx02: .incbin \"stairs_up2_e.hgr.zx02\"" > stairs2_graphics.inc
	echo "stairs_up2_w_zx02: .incbin \"stairs_up2_w.hgr.zx02\"" >> stairs2_graphics.inc
	echo "stairs_up3_e_zx02: .incbin \"stairs_up3_e.hgr.zx02\"" >> stairs2_graphics.inc
	echo "stairs_up3_w_zx02: .incbin \"stairs_up3_w.hgr.zx02\"" >> stairs2_graphics.inc
	echo "stairs_up4_e_zx02: .incbin \"stairs_up4_e.hgr.zx02\"" >> stairs2_graphics.inc
	echo "stairs_up4_w_zx02: .incbin \"stairs_up4_w.hgr.zx02\"" >> stairs2_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr stairs2_graphics.inc

