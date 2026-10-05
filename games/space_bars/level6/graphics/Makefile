include ../../../../Makefile.inc
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_40x48D = ../../../../utils/gr-utils/png_to_40x48d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	sb_background.zx02

####

sb_background.zx02:	sb_background.hgr
	$(ZX02) -f sb_background.hgr sb_background.zx02

sb_background.hgr:	sb_background.png
	$(PNG2HGR) sb_background.png > sb_background.hgr

####

clean:	
		rm -f *~ *.o *.lst *.zx02 *.hgr *.gr


