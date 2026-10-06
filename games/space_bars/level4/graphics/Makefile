include ../../../../Makefile.inc
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_40x48D = ../../../../utils/gr-utils/png_to_40x48d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	car.zx02 track_low.zx02 track_high.zx02

####

car.zx02:	car.hgr
	$(ZX02) -f car.hgr car.zx02

car.hgr:	car.png
	$(PNG2HGR) car.png > car.hgr


####

track_low.zx02:	track_low.gr
	$(ZX02) -f track_low.gr track_low.zx02

track_low.gr:	track.png
	$(PNG_TO_40x48D) bin track.png track

track_high.zx02:	track_high.gr
	$(ZX02) -f track_high.gr track_high.zx02

track_high.gr:	track.png
	$(PNG_TO_40x48D) bin track.png track


####

clean:	
		rm -f *~ *.o *.lst *.zx02 *.hgr *.gr


