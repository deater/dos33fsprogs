include ../../../../Makefile.inc
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_40x48D = ../../../../utils/gr-utils/png_to_40x48d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	sb_title_low.zx02 sb_title_high.zx02

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

clean:	
	rm -f *~ *.o *.lst *.zx02 *.hgr *.gr


