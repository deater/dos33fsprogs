include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	close_graphics.inc

close_graphics.inc:	\
	close_n.hgr.zx02 close_s.hgr.zx02 \
	close_w.hgr.zx02 close_e.hgr.zx02 \
	wahrk_l_s.hgr.zx02 wahrk_r_s.hgr.zx02 \
	close_open_n.hgr.zx02
	echo "close_n_zx02: .incbin \"close_n.hgr.zx02\"" > close_graphics.inc
	echo "close_open_n_zx02: .incbin \"close_open_n.hgr.zx02\"" >> close_graphics.inc
	echo "close_s_zx02: .incbin \"close_s.hgr.zx02\"" >> close_graphics.inc
	echo "close_w_zx02: .incbin \"close_w.hgr.zx02\"" >> close_graphics.inc
	echo "close_e_zx02: .incbin \"close_e.hgr.zx02\"" >> close_graphics.inc
	echo "wahrk_l_s_zx02: .incbin \"wahrk_l_s.hgr.zx02\"" >> close_graphics.inc
	echo "wahrk_r_s_zx02: .incbin \"wahrk_r_s.hgr.zx02\"" >> close_graphics.inc



####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr close_graphics.inc

