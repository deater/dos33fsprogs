include ../../../../Makefile.inc
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_40x48D = ../../../../utils/gr-utils/png_to_40x48d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	car.zx02

####

car.zx02:	car.hgr
	$(ZX02) -f car.hgr car.zx02

car.hgr:	car.png
	$(PNG2HGR) car.png > car.hgr

####

clean:	
		rm -f *~ *.o *.lst *.zx02 *.hgr *.gr


