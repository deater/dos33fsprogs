include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	path_graphics.inc

path_graphics.inc:	\
	step_path_n.hgr.zx02 step_path_e.hgr.zx02 step_path_w.hgr.zx02 \
	steps_base_n.hgr.zx02 steps_base_e.hgr.zx02 steps_base_w.hgr.zx02 \
	cliff_base_e.hgr.zx02
	echo "step_path_n_zx02: .incbin \"step_path_n.hgr.zx02\"" > path_graphics.inc
	echo "step_path_e_zx02: .incbin \"step_path_e.hgr.zx02\"" >> path_graphics.inc
	echo "step_path_w_zx02: .incbin \"step_path_w.hgr.zx02\"" >> path_graphics.inc
	echo "steps_base_n_zx02: .incbin \"steps_base_n.hgr.zx02\"" >> path_graphics.inc
	echo "steps_base_e_zx02: .incbin \"steps_base_e.hgr.zx02\"" >> path_graphics.inc
	echo "steps_base_w_zx02: .incbin \"steps_base_w.hgr.zx02\"" >> path_graphics.inc
	echo "cliff_base_e_zx02: .incbin \"cliff_base_e.hgr.zx02\"" >> path_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr path_graphics.inc

