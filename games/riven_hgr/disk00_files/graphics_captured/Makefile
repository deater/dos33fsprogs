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
	riven05_iipix.hgr.zx02 \
	riven06_iipix.hgr.zx02 \
	riven07_iipix.hgr.zx02 \
	riven08_iipix.hgr.zx02 \
	riven09_iipix.hgr.zx02 \
	riven10_iipix.hgr.zx02 \
	riven11_iipix.hgr.zx02 \
	riven12_iipix.hgr.zx02 \
	riven13_iipix.hgr.zx02 \
	riven14_iipix.hgr.zx02 \
	riven15_iipix.hgr.zx02 \
	riven16_iipix.hgr.zx02 \
	riven17_iipix.hgr.zx02 \
	riven18_iipix.hgr.zx02 \
	riven19_iipix.hgr.zx02 \
	riven20_iipix.hgr.zx02 \
	riven21_iipix.hgr.zx02 \
	riven22_iipix.hgr.zx02 \
	riven23_iipix.hgr.zx02 \
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
	echo "riven05_zx02: .incbin \"riven05_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven06_zx02: .incbin \"riven06_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven07_zx02: .incbin \"riven07_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven08_zx02: .incbin \"riven08_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven09_zx02: .incbin \"riven09_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven10_zx02: .incbin \"riven10_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven11_zx02: .incbin \"riven11_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven12_zx02: .incbin \"riven12_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven13_zx02: .incbin \"riven13_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven14_zx02: .incbin \"riven14_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven15_zx02: .incbin \"riven15_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven16_zx02: .incbin \"riven16_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven17_zx02: .incbin \"riven17_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven18_zx02: .incbin \"riven18_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven19_zx02: .incbin \"riven19_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven20_zx02: .incbin \"riven20_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven21_zx02: .incbin \"riven21_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven22_zx02: .incbin \"riven22_iipix.hgr.zx02\"" >> captured_graphics.inc
	echo "riven23_zx02: .incbin \"riven23_iipix.hgr.zx02\"" >> captured_graphics.inc
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
