include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	cyan_graphics.inc

cyan_graphics.inc:	\
	cyan01_iipix.hgr.zx02 \
	cyan02_iipix.hgr.zx02 \
	cyan03_iipix.hgr.zx02 \
	cyan04_iipix.hgr.zx02 \
	cyan05_iipix.hgr.zx02 \
	cyan06_iipix.hgr.zx02 \
	cyan07_iipix.hgr.zx02 \
	cyan08_iipix.hgr.zx02 \
	cyan09_iipix.hgr.zx02 \
	cyan10_iipix.hgr.zx02 \
	cyan11_iipix.hgr.zx02 \
	cyan12_iipix.hgr.zx02 \
	cyan13_iipix.hgr.zx02 \
	cyan14_iipix.hgr.zx02 \
	cyan15_iipix.hgr.zx02 \
	cyan16_iipix.hgr.zx02 \
	cyan17_iipix.hgr.zx02 \
	cyan18_iipix.hgr.zx02
	echo "cyan01_zx02: .incbin \"cyan01_iipix.hgr.zx02\"" > cyan_graphics.inc
	echo "cyan02_zx02: .incbin \"cyan02_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan03_zx02: .incbin \"cyan03_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan04_zx02: .incbin \"cyan04_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan05_zx02: .incbin \"cyan05_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan06_zx02: .incbin \"cyan06_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan07_zx02: .incbin \"cyan07_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan08_zx02: .incbin \"cyan08_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan09_zx02: .incbin \"cyan09_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan10_zx02: .incbin \"cyan10_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan11_zx02: .incbin \"cyan11_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan12_zx02: .incbin \"cyan12_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan13_zx02: .incbin \"cyan13_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan14_zx02: .incbin \"cyan14_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan15_zx02: .incbin \"cyan15_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan16_zx02: .incbin \"cyan16_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan17_zx02: .incbin \"cyan17_iipix.hgr.zx02\"" >> cyan_graphics.inc
	echo "cyan18_zx02: .incbin \"cyan18_iipix.hgr.zx02\"" >> cyan_graphics.inc




####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr cyan_graphics.inc

