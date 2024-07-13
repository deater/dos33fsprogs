include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	start_graphics.inc

start_graphics.inc:	\
	arrival_n.hgr.zx02
	echo "arrival_n_zx02: .incbin \"arrival_n.hgr.zx02\"" > start_graphics.inc

####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr start_graphics.inc

