include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	a_pboy.btc.zx02

####

a_pboy.btc.zx02:	a_pboy.btc
	$(ZX02) a_pboy.btc a_pboy.btc.zx02

####

clean:
	rm -f *~
