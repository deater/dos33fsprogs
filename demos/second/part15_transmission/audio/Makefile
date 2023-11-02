include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	transmission.btc.zx02

####

transmission.btc.zx02:	transmission.btc
	$(ZX02) transmission.btc transmission.btc.zx02

####

clean:
	rm -f *~
