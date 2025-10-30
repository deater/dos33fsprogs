ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG2RLE = ../../../../utils/gr-utils/png2rle
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../../utils/bmp2dhr/b2d

all:	asteroid.inc new.inc \
	asteroid_page1.hgr.zx02 asteroid_page2.hgr.zx02 \
	woz_page1.hgr.zx02 woz_page2.hgr.zx02

####

asteroid_page1.hgr.zx02:	asteroid_page1.hgr
	$(ZX02) asteroid_page1.hgr asteroid_page1.hgr.zx02

asteroid_page1.hgr:	asteroid_page1.png
	$(PNG2HGR) asteroid_page1.png > asteroid_page1.hgr

asteroid_page2.hgr.zx02:	asteroid_page2.hgr
	$(ZX02) asteroid_page2.hgr asteroid_page2.hgr.zx02

asteroid_page2.hgr:	asteroid_page2.png
	$(PNG2HGR) asteroid_page2.png > asteroid_page2.hgr

####

woz_page1.hgr.zx02:	woz_page1.hgr
	$(ZX02) woz_page1.hgr woz_page1.hgr.zx02

woz_page1.hgr:	woz_page1.png
	$(PNG2HGR) woz_page1.png > woz_page1.hgr

woz_page2.hgr.zx02:	woz_page2.hgr
	$(ZX02) woz_page2.hgr woz_page2.hgr.zx02

woz_page2.hgr:	woz_page2.png
	$(PNG2HGR) woz_page2.png > woz_page2.hgr


####



asteroid.inc:	asteroid.page1.lzsa asteroid.page2.lzsa
	echo "page1_lzsa: .incbin \"asteroid.page1.lzsa\"" > asteroid.inc
	echo "page2_lzsa: .incbin \"asteroid.page2.lzsa\"" >> asteroid.inc

oregon.inc:	oregon.page1.lzsa oregon.page2.lzsa
	echo "page1_lzsa: .incbin \"oregon.page1.lzsa\"" > oregon.inc
	echo "page2_lzsa: .incbin \"oregon.page2.lzsa\"" >> oregon.inc

new.inc:	new.page1.lzsa new.page2.lzsa
	echo "page1_lzsa: .incbin \"new.page1.lzsa\"" > new.inc
	echo "page2_lzsa: .incbin \"new.page2.lzsa\"" >> new.inc

###

asteroid.page1.lzsa:	asteroid_page1.hgr
	$(LZSA) -r -f2 asteroid_page1.hgr asteroid.page1.lzsa

asteroid.page2.lzsa:	asteroid_page2.hgr
	$(LZSA) -r -f2 asteroid_page2.hgr asteroid.page2.lzsa

###

new_page1.hgr:	new_page1.png
	$(PNG2HGR) new_page1.png > new_page1.hgr

new_page2.hgr:	new_page2.png
	$(PNG2HGR) new_page2.png > new_page2.hgr

###

new.page1.lzsa:	new_page1.hgr
	$(LZSA) -r -f2 new_page1.hgr new.page1.lzsa

new.page2.lzsa:	new_page2.hgr
	$(LZSA) -r -f2 new_page2.hgr new.page2.lzsa


###

oregon.page1.lzsa:	oregon.page1
	$(LZSA) -r -f2 oregon.page1 oregon.page1.lzsa

oregon.page2.lzsa:	oregon.page2
	$(LZSA) -r -f2 oregon.page2 oregon.page2.lzsa

###


clean:	
	rm -f *~ outline.inc *.lzsa *.gr *.hgr

