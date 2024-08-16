include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	chair2_graphics.inc

chair2_graphics.inc:	\
	chair2_n.hgr.zx02 chair2_s.hgr.zx02 \
	chair2_e.hgr.zx02 chair2_w.hgr.zx02 \
	chair3_s.hgr.zx02 \
	chair3_down_s.hgr.zx02 chair3_down_flip_s.hgr.zx02 \
	porthole_r_s.hgr.zx02 \
	porthole_l_closed_s.hgr.zx02 porthole_l_open_s.hgr.zx02
	echo "chair2_n_zx02: .incbin \"chair2_n.hgr.zx02\"" > chair2_graphics.inc
	echo "chair2_s_zx02: .incbin \"chair2_s.hgr.zx02\"" >> chair2_graphics.inc
	echo "chair2_e_zx02: .incbin \"chair2_e.hgr.zx02\"" >> chair2_graphics.inc
	echo "chair2_w_zx02: .incbin \"chair2_w.hgr.zx02\"" >> chair2_graphics.inc
	echo "chair3_s_zx02: .incbin \"chair3_s.hgr.zx02\"" >> chair2_graphics.inc
	echo "chair3_down_s_zx02: .incbin \"chair3_down_s.hgr.zx02\"" >> chair2_graphics.inc
	echo "chair3_down_flip_s_zx02: .incbin \"chair3_down_flip_s.hgr.zx02\"" >> chair2_graphics.inc
	echo "porthole_r_s_zx02: .incbin \"porthole_r_s.hgr.zx02\"" >> chair2_graphics.inc
	echo "porthole_l_closed_s_zx02: .incbin \"porthole_l_closed_s.hgr.zx02\"" >> chair2_graphics.inc
	echo "porthole_l_open_s_zx02: .incbin \"porthole_l_open_s.hgr.zx02\"" >> chair2_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr chair2_graphics.inc

