include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	maglev_graphics.inc

maglev_graphics.inc:	\
	maglev_sit_s.hgr.zx02
	echo "maglev_sit_s_zx02: .incbin \"maglev_sit_s.hgr.zx02\"" > maglev_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr maglev_graphics.inc

