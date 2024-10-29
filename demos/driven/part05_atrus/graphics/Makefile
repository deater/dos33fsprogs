include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	atrus03_iipix.hgr.zx02 \
	atrus10_iipix.hgr.zx02 \
	atrus11_iipix.hgr.zx02

####

atrus03_iipix.hgr.zx02:	atrus03_iipix.hgr
	$(ZX02) atrus03_iipix.hgr atrus03_iipix.hgr.zx02

atrus03_iipix.hgr:	atrus03_iipix.png
	$(PNG_TO_HGR) atrus03_iipix.png > atrus03_iipix.hgr

####

atrus10_iipix.hgr.zx02:	atrus10_iipix.hgr
	$(ZX02) atrus10_iipix.hgr atrus10_iipix.hgr.zx02

atrus10_iipix.hgr:	atrus10_iipix.png
	$(PNG_TO_HGR) atrus10_iipix.png > atrus10_iipix.hgr

####

atrus11_iipix.hgr.zx02:	atrus11_iipix.hgr
	$(ZX02) atrus11_iipix.hgr atrus11_iipix.hgr.zx02

atrus11_iipix.hgr:	atrus11_iipix.png
	$(PNG_TO_HGR) atrus11_iipix.png > atrus11_iipix.hgr




####

clean:
	rm -f *~ *.zx02
