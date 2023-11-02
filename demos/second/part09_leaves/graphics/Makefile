include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	final3.hgr.zx02 leaves1.hgr.zx02 leaves2.hgr.zx02 \
	leaves_combined.hgr.zx02

####

leaves_combined.hgr:	leaves1.hgr leaves2.hgr
	cat leaves1.hgr > leaves_combined.hgr
	cat leaves2.hgr >> leaves_combined.hgr

leaves_combined.hgr.zx02:	leaves_combined.hgr
	$(ZX02) leaves_combined.hgr leaves_combined.hgr.zx02

####

final3.hgr:	final3.png
	$(PNG_TO_HGR) final3.png > final3.hgr

final3.hgr.zx02:	final3.hgr
	$(ZX02) final3.hgr final3.hgr.zx02

####

leaves1.hgr:	leaves1.png
	$(PNG_TO_HGR) leaves1.png > leaves1.hgr

leaves1.hgr.zx02:	leaves1.hgr
	$(ZX02) leaves1.hgr leaves1.hgr.zx02

####

leaves2.hgr:	leaves2.png
	$(PNG_TO_HGR) leaves2.png > leaves2.hgr

leaves2.hgr.zx02:	leaves2.hgr
	$(ZX02) leaves2.hgr leaves2.hgr.zx02



####

clean:
	rm -f *~ *.zx02
