
PNG2RLE = ../../../../utils/gr-utils/png2rle
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../../utils/bmp2dhr/b2d

all:	asteroid.inc new.inc


asteroid.inc:	asteroid.page0.lzsa asteroid.page1.lzsa
	echo "page0_lzsa: .incbin \"asteroid.page0.lzsa\"" > asteroid.inc
	echo "page1_lzsa: .incbin \"asteroid.page1.lzsa\"" >> asteroid.inc

oregon.inc:	oregon.page0.lzsa oregon.page1.lzsa
	echo "page0_lzsa: .incbin \"oregon.page0.lzsa\"" > oregon.inc
	echo "page1_lzsa: .incbin \"oregon.page1.lzsa\"" >> oregon.inc

new.inc:	new.page0.lzsa new.page1.lzsa
	echo "page0_lzsa: .incbin \"new.page0.lzsa\"" > new.inc
	echo "page1_lzsa: .incbin \"new.page1.lzsa\"" >> new.inc

###

asteroid_page0.hgr:	asteroid_page0.png
	$(PNG2HGR) asteroid_page0.png > asteroid_page0.hgr

asteroid_page1.hgr:	asteroid_page1.png
	$(PNG2HGR) asteroid_page1.png > asteroid_page1.hgr

###

asteroid.page0.lzsa:	asteroid_page0.hgr
	$(LZSA) -r -f2 asteroid_page0.hgr asteroid.page0.lzsa

asteroid.page1.lzsa:	asteroid_page1.hgr
	$(LZSA) -r -f2 asteroid_page1.hgr asteroid.page1.lzsa

###

new_page0.hgr:	new_page0.png
	$(PNG2HGR) new_page0.png > new_page0.hgr

new_page1.hgr:	new_page1.png
	$(PNG2HGR) new_page1.png > new_page1.hgr

###

new.page0.lzsa:	new_page0.hgr
	$(LZSA) -r -f2 new_page0.hgr new.page0.lzsa

new.page1.lzsa:	new_page1.hgr
	$(LZSA) -r -f2 new_page1.hgr new.page1.lzsa


###

oregon.page0.lzsa:	oregon.page0
	$(LZSA) -r -f2 oregon.page0 oregon.page0.lzsa

oregon.page1.lzsa:	oregon.page1
	$(LZSA) -r -f2 oregon.page1 oregon.page1.lzsa

###


clean:	
	rm -f *~ outline.inc *.lzsa *.gr *.hgr

