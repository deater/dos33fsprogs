include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	chess_object.hgr.zx02 chess_object2.hgr.zx02


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

clean:
	rm -f *~
