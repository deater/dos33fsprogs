PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	jhonka_graphics.inc \
	jhonka_priority.inc

###

jhonka_graphics.inc:	\
	jhonka.zx02
	echo "jhonka_zx02: .incbin \"jhonka.zx02\"" > jhonka_graphics.inc

###

jhonka.zx02:	jhonka.hgr
	$(ZX02) -f jhonka.hgr jhonka.zx02

jhonka.hgr:	jhonka.png
	$(PNG2HGR) jhonka.png > jhonka.hgr

###

jhonka_priority.inc:  \
	jhonka_priority.zx02
	echo "jhonka_priority_zx02: .incbin \"jhonka_priority.zx02\"" > jhonka_priority.inc

####

jhonka_priority.zx02:	jhonka_priority.combined
	$(ZX02) -f jhonka_priority.combined jhonka_priority.zx02

jhonka_priority.combined:	jhonka_priority.gr jhonka_priority_noriches.gr \
	jhonka_collision.bin jhonka_collision_there.bin
	cat jhonka_priority.gr >  jhonka_priority.combined
	cat jhonka_collision.bin >> jhonka_priority.combined

jhonka_priority.gr:	jhonka_priority.png
	$(PNG2GR) jhonka_priority.png jhonka_priority.gr

jhonka_priority_noriches.gr:	jhonka_priority_noriches.png
	$(PNG2GR) jhonka_priority_noriches.png jhonka_priority_noriches.gr

jhonka_collision.bin:	jhonka_collision.png
	$(PNG2COLLISION) jhonka_collision.png jhonka_collision.bin

jhonka_collision_there.bin:	jhonka_collision_there.png
	$(PNG2COLLISION) jhonka_collision_there.png jhonka_collision_there.bin

####

clean:	
	rm -f *~ jhonka_graphics.inc jhonka_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr

