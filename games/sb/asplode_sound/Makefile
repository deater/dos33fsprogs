ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	asplode.btc.zx02 asplode_sound.btc.zx02

asplode.btc.zx02:	asplode.btc
	$(ZX02) asplode.btc asplode.btc.zx02


asplode_sound.btc.zx02:	asplode_sound.btc
	$(ZX02) asplode_sound.btc asplode_sound.btc.zx02

asplode_sound.btc:	asplode.btc bim.btc boom.btc twang.btc
	dd if=/dev/zero of=empty.btc bs=1 count=966
	cat asplode.btc > asplode_sound.btc
	cat empty.btc >> asplode_sound.btc
	dd if=bim.btc bs=1 count=1024 >> asplode_sound.btc
	dd if=boom.btc bs=1 count=1024 >> asplode_sound.btc
	dd if=twang.btc bs=1 count=2048 >> asplode_sound.btc


clean:	
	rm -f *~ asplode_sound.btc
