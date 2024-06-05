ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	fish.btc.zx02 get_in_boat.btc.zx02

fish.btc.zx02:	fish.btc
	$(ZX02) fish.btc fish.btc.zx02

get_in_boat.btc.zx02:	get_in_boat.btc
	$(ZX02) get_in_boat.btc get_in_boat.btc.zx02

clean:	
	rm -f *.zx02
