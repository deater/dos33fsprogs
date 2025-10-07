include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr

all:	a2_nine.aux.zx02 a2_nine.bin.zx02

####

a2_nine.aux.zx02:	a2_nine.AUX
	$(ZX02) a2_nine.AUX a2_nine.aux.zx02

a2_nine.AUX:	a2_nine.png
	$(PNG_TO_DHGR) a2_nine.png a2_nine

a2_nine.bin.zx02:	a2_nine.BIN
	$(ZX02) a2_nine.BIN a2_nine.bin.zx02

a2_nine.BIN:	a2_nine.png
	$(PNG_TO_DHGR) a2_nine.png a2_nine


####

clean:
	rm -f *~ *.zx02 *.AUX *.BIN
