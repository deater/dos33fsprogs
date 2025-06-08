PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	kerrek1_graphics.inc \
	kerrek1_priority.inc

###

kerrek1_graphics.inc:	\
	kerrek1.zx02
	echo "kerrek1_zx02: .incbin \"kerrek1.zx02\"" > kerrek1_graphics.inc

###

kerrek1.zx02:	kerrek1.hgr
	$(ZX02) -f kerrek1.hgr kerrek1.zx02

kerrek1.hgr:	kerrek1.png
	$(PNG2HGR) kerrek1.png > kerrek1.hgr

###

kerrek1_priority.inc:  \
	kerrek1_priority.zx02
	echo "kerrek1_priority_zx02: .incbin \"kerrek1_priority.zx02\"" > kerrek1_priority.inc

####

kerrek1_priority.zx02:	kerrek1_priority.combined
	$(ZX02) -f kerrek1_priority.combined kerrek1_priority.zx02

kerrek1_priority.combined:	kerrek1_priority.gr kerrek1_collision.bin
	cat kerrek1_priority.gr >  kerrek1_priority.combined
	cat kerrek1_collision.bin >> kerrek1_priority.combined

kerrek1_priority.gr:	kerrek1_priority.png
	$(PNG2GR) kerrek1_priority.png kerrek1_priority.gr

kerrek1_collision.bin:	kerrek1_collision.png
	$(PNG2COLLISION) kerrek1_collision.png kerrek1_collision.bin

####

clean:	
	rm -f *~ kerrek1_graphics.inc kerrek1_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr

