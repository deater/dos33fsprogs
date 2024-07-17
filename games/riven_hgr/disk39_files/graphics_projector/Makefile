include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	projector_graphics.inc

projector_graphics.inc:	\
	doorway_n.hgr.zx02 doorway_s.hgr.zx02 \
	steps_n.hgr.zx02 steps_s.hgr.zx02 \
	magpath_n.hgr.zx02 magpath_s.hgr.zx02
	echo "doorway_n_zx02: .incbin \"doorway_n.hgr.zx02\"" > projector_graphics.inc
	echo "doorway_s_zx02: .incbin \"doorway_s.hgr.zx02\"" >> projector_graphics.inc
	echo "steps_n_zx02: .incbin \"steps_n.hgr.zx02\"" >> projector_graphics.inc
	echo "steps_s_zx02: .incbin \"steps_s.hgr.zx02\"" >> projector_graphics.inc
	echo "magpath_n_zx02: .incbin \"magpath_n.hgr.zx02\"" >> projector_graphics.inc
	echo "magpath_s_zx02: .incbin \"magpath_s.hgr.zx02\"" >> projector_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr projector_graphics.inc

