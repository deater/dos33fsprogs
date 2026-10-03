include ../../../Makefile.inc
PNG2HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_40x48D = ../../../utils/gr-utils/png_to_40x48d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	sb_background.zx02 \
	sb_title_low.zx02 sb_title_high.zx02 \
	earth_low.zx02 earth_high.zx02

####

sb_background.zx02:	sb_background.hgr
	$(ZX02) -f sb_background.hgr sb_background.zx02

sb_background.hgr:	sb_background.png
	$(PNG2HGR) sb_background.png > sb_background.hgr


####

sb_title_low.zx02:	sb_title_low.gr
	$(ZX02) -f sb_title_low.gr sb_title_low.zx02

sb_title_low.gr:	spacebars_title_scaled.png
	$(PNG_TO_40x48D) bin spacebars_title_scaled.png sb_title

####

sb_title_high.zx02:	sb_title_high.gr
	$(ZX02) -f sb_title_high.gr sb_title_high.zx02

sb_title_high.gr:	spacebars_title_scaled.png
	$(PNG_TO_40x48D) bin spacebars_title_scaled.png sb_title

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


