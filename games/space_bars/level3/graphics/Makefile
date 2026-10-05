include ../../../../Makefile.inc
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_40x48D = ../../../../utils/gr-utils/png_to_40x48d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	earth_low.zx02 earth_high.zx02

####

earth_low.zx02:	earth_low.gr
	$(ZX02) -f earth_low.gr earth_low.zx02

earth_low.gr:	earth.png
	$(PNG_TO_40x48D) bin earth.png earth

####

earth_high.zx02:	earth_high.gr
	$(ZX02) -f earth_high.gr earth_high.zx02

earth_high.gr:	earth.png
	$(PNG_TO_40x48D) bin earth.png earth

####

clean:	
		rm -f *~ *.o *.lst *.zx02 *.hgr *.gr


