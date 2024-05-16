include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../utils/gr-utils/png2sprites
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	dome_graphics.inc

dome_graphics.inc:	\
	maglev1_n.hgr.zx02 maglev1_s.hgr.zx02 maglev1_e.hgr.zx02 maglev1_w.hgr.zx02 \
	maglev2_n.hgr.zx02 \
	maglev3_n.hgr.zx02
	echo "maglev1_n_zx02: .incbin \"maglev1_n.hgr.zx02\"" > dome_graphics.inc
	echo "maglev1_s_zx02: .incbin \"maglev1_s.hgr.zx02\"" >> dome_graphics.inc
	echo "maglev1_e_zx02: .incbin \"maglev1_e.hgr.zx02\"" >> dome_graphics.inc
	echo "maglev1_w_zx02: .incbin \"maglev1_w.hgr.zx02\"" >> dome_graphics.inc
	echo "maglev2_n_zx02: .incbin \"maglev2_n.hgr.zx02\"" >> dome_graphics.inc
	echo "maglev3_n_zx02: .incbin \"maglev3_n.hgr.zx02\"" >> dome_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr dome_graphics.inc

