include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	icekngdm.hgr.zx02 polar2.hgr.zx02


####

icekngdm.hgr:	icekngdm.png
	$(PNG_TO_HGR) icekngdm.png > icekngdm.hgr

icekngdm.hgr.zx02:	icekngdm.hgr
	$(ZX02) icekngdm.hgr icekngdm.hgr.zx02

####

polar2.hgr:	polar2.png
	$(PNG_TO_HGR) polar2.png > polar2.hgr

polar2.hgr.zx02:	polar2.hgr
	$(ZX02) polar2.hgr polar2.hgr.zx02

####

clean:
	rm -f *~
