include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite


all:	chess_object.hgr.zx02 chess_object2.hgr.zx02 \
	orange_bg.hgr.zx02 object.inc \
	tunnel1.hgr.zx02 tunnel2.hgr.zx02 \
	tunnel1_cropped.hgr.zx02 tunnel2_cropped.hgr.zx02 \
	chessboard.hgr.zx02

####

object.inc:	chess3.png
	$(HGR_SPRITE) -s -l object chess3.png   84 11 188 118 > object.inc
	$(HGR_SPRITE) -s -l squished chess3.png 70 120 195 190 >> object.inc


####

tunnel1.hgr:	tunnel1.png
	$(PNG_TO_HGR) tunnel1.png > tunnel1.hgr

tunnel1.hgr.zx02:	tunnel1.hgr
	$(ZX02) tunnel1.hgr tunnel1.hgr.zx02

####

tunnel1_cropped.hgr:	tunnel1_cropped.png
	$(PNG_TO_HGR) tunnel1_cropped.png > tunnel1_cropped.hgr

tunnel1_cropped.hgr.zx02:	tunnel1_cropped.hgr
	$(ZX02) tunnel1_cropped.hgr tunnel1_cropped.hgr.zx02

####

tunnel2_cropped.hgr:	tunnel2_cropped.png
	$(PNG_TO_HGR) tunnel2_cropped.png > tunnel2_cropped.hgr

tunnel2_cropped.hgr.zx02:	tunnel2_cropped.hgr
	$(ZX02) tunnel2_cropped.hgr tunnel2_cropped.hgr.zx02



####

tunnel2.hgr:	tunnel2.png
	$(PNG_TO_HGR) tunnel2.png > tunnel2.hgr

tunnel2.hgr.zx02:	tunnel2.hgr
	$(ZX02) tunnel2.hgr tunnel2.hgr.zx02


####

chess_object.hgr:	chess_object.png
	$(PNG_TO_HGR) chess_object.png > chess_object.hgr

chess_object.hgr.zx02:	chess_object.hgr
	$(ZX02) chess_object.hgr chess_object.hgr.zx02

####

chess_object2.hgr:	chess_object2.png
	$(PNG_TO_HGR) chess_object2.png > chess_object2.hgr

chess_object2.hgr.zx02:	chess_object2.hgr
	$(ZX02) chess_object2.hgr chess_object2.hgr.zx02

####

orange_bg.hgr:	orange_bg.png
	$(PNG_TO_HGR) orange_bg.png > orange_bg.hgr

orange_bg.hgr.zx02:	orange_bg.hgr
	$(ZX02) orange_bg.hgr orange_bg.hgr.zx02

####

chessboard.hgr:	chessboard.png
	$(PNG_TO_HGR) chessboard.png > chessboard.hgr

chessboard.hgr.zx02:	chessboard.hgr
	$(ZX02) chessboard.hgr chessboard.hgr.zx02



####

clean:
	rm -f *~
