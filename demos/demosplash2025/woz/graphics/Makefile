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
	nine_woz.raw_top.zx02 nine_woz.raw_bottom.zx02 \
	new_woz.raw_top.zx02 new_woz.raw_bottom.zx02 \
	asteroid_page1.hgr.zx02 asteroid_page2.hgr.zx02 \
	woz_sprites.inc


####

new_woz.raw_top.zx02:	new_woz.raw_top
	$(ZX02) new_woz.raw_top new_woz.raw_top.zx02

new_woz.raw_top:	new_woz.png
	$(PNG_TO_DHGR_RAW) -t new_woz.png new_woz

new_woz.raw_bottom.zx02:	new_woz.raw_bottom
	$(ZX02) new_woz.raw_bottom new_woz.raw_bottom.zx02

new_woz.raw_bottom:	new_woz.png
	$(PNG_TO_DHGR_RAW) -t new_woz.png new_woz

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
woz_sprites.inc:	woz_sprite.png
	$(HGR_SPRITE) -s -l woz_arms_sprite woz_sprite.png 210 36 265 46 > woz_sprites.inc
	$(HGR_SPRITE) -s -l woz_body_sprite woz_sprite.png 224 85 251 148 >> woz_sprites.inc
#	$(HGR_SPRITE) -l woz_sprite woz_sprite.png 7  7 76  77 > woz_sprites.inc
#	$(HGR_SPRITE) -l woz_mask   woz_sprite.png 7 84 76 154 >> woz_sprites.inc


####

asteroid_page1.hgr.zx02:	asteroid_page1.hgr
	$(ZX02) asteroid_page1.hgr asteroid_page1.hgr.zx02

asteroid_page1.hgr:	asteroid_page1.png
	$(PNG_TO_HGR) asteroid_page1.png > asteroid_page1.hgr

asteroid_page2.hgr.zx02:	asteroid_page2.hgr
	$(ZX02) asteroid_page2.hgr asteroid_page2.hgr.zx02

asteroid_page2.hgr:	asteroid_page2.png
	$(PNG_TO_HGR) asteroid_page2.png > asteroid_page2.hgr

###

clean:
	rm -f *~ *.zx02 *.lst *.o *.AUX *.BIN *.big *.big_packed *.combined *.raw_top *.raw_bottom *.raw woz_sprites.inc






