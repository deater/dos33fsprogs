include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	cove_graphics.inc

cove_graphics.inc:	\
	stairs_down1_e.hgr.zx02 stairs_down1_w.hgr.zx02 \
	stairs_down2_e.hgr.zx02 stairs_down2_w.hgr.zx02 \
	cove_e.hgr.zx02 cove_w.hgr.zx02
	echo "stairs_down1_e_zx02: .incbin \"stairs_down1_e.hgr.zx02\"" > cove_graphics.inc
	echo "stairs_down1_w_zx02: .incbin \"stairs_down1_w.hgr.zx02\"" >> cove_graphics.inc
	echo "stairs_down2_e_zx02: .incbin \"stairs_down2_e.hgr.zx02\"" >> cove_graphics.inc
	echo "stairs_down2_w_zx02: .incbin \"stairs_down2_w.hgr.zx02\"" >> cove_graphics.inc
	echo "cove_e_zx02: .incbin \"cove_e.hgr.zx02\"" >> cove_graphics.inc
	echo "cove_w_zx02: .incbin \"cove_w.hgr.zx02\"" >> cove_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr cove_graphics.inc

