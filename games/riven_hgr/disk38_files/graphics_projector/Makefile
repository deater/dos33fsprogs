include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	projector_graphics.inc

projector_graphics.inc:	\
	projector_n.hgr.zx02 projector_s.hgr.zx02 \
	projector_w.hgr.zx02 projector_e.hgr.zx02 \
	projector_n_open.hgr.zx02
	echo "projector_n_zx02: .incbin \"projector_n.hgr.zx02\"" > projector_graphics.inc
	echo "projector_s_zx02: .incbin \"projector_s.hgr.zx02\"" >> projector_graphics.inc
	echo "projector_w_zx02: .incbin \"projector_w.hgr.zx02\"" >> projector_graphics.inc
	echo "projector_e_zx02: .incbin \"projector_e.hgr.zx02\"" >> projector_graphics.inc
	echo "projector_n_open_zx02: .incbin \"projector_n_open.hgr.zx02\"" >> projector_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr projector_graphics.inc

