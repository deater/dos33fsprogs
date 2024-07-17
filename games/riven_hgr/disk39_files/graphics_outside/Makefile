include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
#LINKER_SCRIPTS = ../../../linker_scripts
#HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	outside_graphics.inc

outside_graphics.inc:	\
	maglev1_n.hgr.zx02 maglev1_s.hgr.zx02 maglev1_e.hgr.zx02 maglev1_w.hgr.zx02 \
	overlook_n.hgr.zx02 overlook_s.hgr.zx02
	echo "maglev1_n_zx02: .incbin \"maglev1_n.hgr.zx02\"" > outside_graphics.inc
	echo "maglev1_s_zx02: .incbin \"maglev1_s.hgr.zx02\"" >> outside_graphics.inc
	echo "maglev1_e_zx02: .incbin \"maglev1_e.hgr.zx02\"" >> outside_graphics.inc
	echo "maglev1_w_zx02: .incbin \"maglev1_w.hgr.zx02\"" >> outside_graphics.inc
#	echo "magpath_n_zx02: .incbin \"magpath_n.hgr.zx02\"" >> outside_graphics.inc
#	echo "magpath_s_zx02: .incbin \"magpath_s.hgr.zx02\"" >> outside_graphics.inc
	echo "overlook_n_zx02: .incbin \"overlook_n.hgr.zx02\"" >> outside_graphics.inc
	echo "overlook_s_zx02: .incbin \"overlook_s.hgr.zx02\"" >> outside_graphics.inc



####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr outside_graphics.inc

