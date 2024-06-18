include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	arrival_graphics.inc

arrival_graphics.inc:	\
	arrival_near_n.hgr.zx02 arrival_near_s.hgr.zx02 arrival_near_e.hgr.zx02 arrival_near_w.hgr.zx02 \
	arrival_n.hgr.zx02 \
	arrival_handle_n.hgr.zx02
	echo "arrival_near_n_zx02: .incbin \"arrival_near_n.hgr.zx02\"" > arrival_graphics.inc
	echo "arrival_near_s_zx02: .incbin \"arrival_near_s.hgr.zx02\"" >> arrival_graphics.inc
	echo "arrival_near_e_zx02: .incbin \"arrival_near_e.hgr.zx02\"" >> arrival_graphics.inc
	echo "arrival_near_w_zx02: .incbin \"arrival_near_w.hgr.zx02\"" >> arrival_graphics.inc
	echo "arrival_n_zx02: .incbin \"arrival_n.hgr.zx02\"" >> arrival_graphics.inc
	echo "arrival_handle_n_zx02: .incbin \"arrival_handle_n.hgr.zx02\"" >> arrival_graphics.inc




####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr arrival_graphics.inc

