include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_RAW = ../../../../utils/hgr-utils/png2dhgr_raw
PNG_TO_DHGR4 = ../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	\
	nine_woz.raw_top.zx02 nine_woz.raw_bottom.zx02

####

nine_woz.raw_top.zx02:     nine_woz.raw_top
	$(ZX02) nine_woz.raw_top nine_woz.raw_top.zx02

nine_woz.raw_top:  nine_woz.png
	$(PNG_TO_DHGR_RAW) -t nine_woz.png nine_woz

nine_woz.raw_bottom.zx02:     nine_woz.raw_bottom
	$(ZX02) nine_woz.raw_bottom nine_woz.raw_bottom.zx02

nine_woz.raw_bottom: nine_woz.png
	$(PNG_TO_DHGR_RAW) -t nine_woz.png nine_woz

nine_woz.aux.zx02:     nine_woz.AUX
	$(ZX02) nine_woz.AUX nine_woz.aux.zx02

nine_woz.AUX:  nine_woz.png
	$(PNG_TO_DHGR) nine_woz.png nine_woz

nine_woz.bin.zx02:     nine_woz.BIN
	$(ZX02) nine_woz.BIN nine_woz.bin.zx02

nine_woz.BIN: nine_woz.png
	$(PNG_TO_DHGR) nine_woz.png nine_woz

####

####

clean:
	rm -f *~ *.zx02 *.lst *.o *.AUX *.BIN *.big *.big_packed *.combined *.raw_top *.raw_bottom *.raw
