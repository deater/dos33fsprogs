ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	chair_open.btc.zx02 chair_close.btc.zx02

chair_open.btc.zx02:	chair_open.btc
	$(ZX02) chair_open.btc chair_open.btc.zx02

chair_close.btc.zx02:	chair_close.btc
	$(ZX02) chair_close.btc chair_close.btc.zx02

clean:	
	rm -f *.zx02
