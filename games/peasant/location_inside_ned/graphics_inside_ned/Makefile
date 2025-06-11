PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	inside_ned_graphics.inc \
	inside_ned_priority.inc

###

inside_ned_graphics.inc:	\
	inside_nn.zx02
	echo "inside_nn_zx02: .incbin \"inside_nn.zx02\"" > inside_ned_graphics.inc

###

inside_nn.zx02:	inside_nn.hgr
	$(ZX02) -f inside_nn.hgr inside_nn.zx02

inside_nn.hgr:	inside_nn.png
	$(PNG2HGR) inside_nn.png > inside_nn.hgr

###

inside_ned_priority.inc:  \
	inside_nn_priority.zx02
	echo "inside_nn_priority_zx02: .incbin \"inside_nn_priority.zx02\"" > inside_ned_priority.inc

####

inside_nn_priority.zx02:	inside_nn_priority.combined
	$(ZX02) -f inside_nn_priority.combined inside_nn_priority.zx02

inside_nn_priority.combined:	inside_nn_priority.gr inside_nn_collision.bin
	cat inside_nn_priority.gr >  inside_nn_priority.combined
	cat inside_nn_collision.bin >> inside_nn_priority.combined

inside_nn_priority.gr:	inside_nn_priority.png
	$(PNG2GR) inside_nn_priority.png inside_nn_priority.gr

inside_nn_collision.bin:	inside_nn_collision.png
	$(PNG2COLLISION) inside_nn_collision.png inside_nn_collision.bin

####

clean:	
	rm -f *~ inside_ned_graphics.inc inside_ned_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr

