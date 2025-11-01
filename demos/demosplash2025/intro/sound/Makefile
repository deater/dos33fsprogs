include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	ms.btc.zx02


####

ms.btc.zx02:	ms.btc
	$(ZX02) ms.btc ms.btc.zx02

####
clean:
	rm -f *~ *.zx02

