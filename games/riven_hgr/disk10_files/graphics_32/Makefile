include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	stained_graphics.inc

stained_graphics.inc:	\
	stained02.hgr.zx02 stained03.hgr.zx02 \
	beetle_far_r.hgr.zx02 beetle_close.hgr.zx02
	echo "stained02_zx02: .incbin \"stained02.hgr.zx02\"" > stained_graphics.inc
	echo "stained03_zx02: .incbin \"stained03.hgr.zx02\"" >> stained_graphics.inc
	echo "beetle_far_r_zx02: .incbin \"beetle_far_r.hgr.zx02\"" >> stained_graphics.inc
	echo "beetle_close_zx02: .incbin \"beetle_close.hgr.zx02\"" >> stained_graphics.inc


####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr stained_graphics.inc

