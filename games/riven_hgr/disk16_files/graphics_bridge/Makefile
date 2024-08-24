include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	bridge_graphics.inc

bridge_graphics.inc:	\
	dome_bridge_n.hgr.zx02 dome_bridge_s.hgr.zx02 \
	dome_bridge_e.hgr.zx02 dome_bridge_w.hgr.zx02 \
	dome_bridge_s_blocked.hgr.zx02
	echo "dome_bridge_n_zx02: .incbin \"dome_bridge_n.hgr.zx02\"" > bridge_graphics.inc
	echo "dome_bridge_s_zx02: .incbin \"dome_bridge_s.hgr.zx02\"" >> bridge_graphics.inc
	echo "dome_bridge_e_zx02: .incbin \"dome_bridge_e.hgr.zx02\"" >> bridge_graphics.inc
	echo "dome_bridge_w_zx02: .incbin \"dome_bridge_w.hgr.zx02\"" >> bridge_graphics.inc
	echo "dome_bridge_s_blocked_zx02: .incbin \"dome_bridge_s_blocked.hgr.zx02\"" >> bridge_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr bridge_graphics.inc

