include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	captured_graphics.inc

captured_graphics.inc:	\
	riven01_iipix.hgr.zx02 \
	riven02_iipix.hgr.zx02 \
	riven03_iipix.hgr.zx02 \
	riven04_iipix.hgr.zx02 \
	captured_bg.gr.zx02 \
	trap_overlay0.gr.zx02 \
	trap_overlay1.gr.zx02 \
	trap_overlay2.gr.zx02 \
	trap_overlay3.gr.zx02 \
	trap_overlay4.gr.zx02 \
	trap_overlay5.gr.zx02
	echo "riven01_zx02: .incbin \"riven01_iipix.hgr.zx02\"" > captured_graphics.inc
	echo "riven02_zx02: .incbin \"riven02_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven03_zx02: .incbin \"riven03_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven04_zx02: .incbin \"riven04_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "captured_bg: .incbin \"captured_bg.gr.zx02\"" >> captured_graphics.inc
	echo "trap_overlay0: .incbin \"trap_overlay0.gr.zx02\"" >> captured_graphics.inc
	echo "trap_overlay1: .incbin \"trap_overlay1.gr.zx02\"" >> captured_graphics.inc
	echo "trap_overlay2: .incbin \"trap_overlay2.gr.zx02\"" >> captured_graphics.inc
	echo "trap_overlay3: .incbin \"trap_overlay3.gr.zx02\"" >> captured_graphics.inc
	echo "trap_overlay4: .incbin \"trap_overlay4.gr.zx02\"" >> captured_graphics.inc
	echo "trap_overlay5: .incbin \"trap_overlay5.gr.zx02\"" >> captured_graphics.inc



####

%.gr:	%.png
	$(PNG2GR) $< $@

%.gr.zx02:	%.gr
	$(ZX02) -f $< $@

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr captured_graphics.inc
