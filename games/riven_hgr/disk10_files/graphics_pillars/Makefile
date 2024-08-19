include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	pillars_graphics.inc

pillars_graphics.inc:	\
	stained01.hgr.zx02 \
	stained02.hgr.zx02 \
	stained03.hgr.zx02 \
	stained04.hgr.zx02 \
	stained05.hgr.zx02 \
	beetle_open_r.hgr.zx02 beetle_r.hgr.zx02
	echo "beetle_open_r_zx02: .incbin \"beetle_open_r.hgr.zx02\"" > pillars_graphics.inc
	echo "beetle_r_zx02: .incbin \"beetle_r.hgr.zx02\"" >> pillars_graphics.inc
	echo "stained01_zx02: .incbin \"stained01.hgr.zx02\"" >> pillars_graphics.inc
	echo "stained02_zx02: .incbin \"stained02.hgr.zx02\"" >> pillars_graphics.inc
	echo "stained03_zx02: .incbin \"stained03.hgr.zx02\"" >> pillars_graphics.inc
	echo "stained04_zx02: .incbin \"stained04.hgr.zx02\"" >> pillars_graphics.inc
	echo "stained05_zx02: .incbin \"stained05.hgr.zx02\"" >> pillars_graphics.inc







####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr pillars_graphics.inc

