PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2HGR = ../../../../utils/hgr-utils/png2hgr
ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2COLLISION = ../../../../utils/gr-utils/png2collision

all:	knight_graphics.inc knight_night_graphics.inc \
	intro_knight_graphics.inc \
	knight_priority.inc

###

knight_graphics.inc:	\
	knight.zx02
	echo "knight_zx02: .incbin \"knight.zx02\"" > knight_graphics.inc

knight_night_graphics.inc:	\
	knight_night.zx02
	echo "knight_night_zx02: .incbin \"knight_night.zx02\"" > knight_night_graphics.inc


###

knight.zx02:	knight.hgr
	$(ZX02) -f knight.hgr knight.zx02

knight.hgr:	knight.png
	$(PNG2HGR) knight.png > knight.hgr

###

knight_night.zx02:	knight_night.hgr
	$(ZX02) -f knight_night.hgr knight_night.zx02

knight_night.hgr:	knight_night.png
	$(PNG2HGR) knight_night.png > knight_night.hgr

###

intro_knight_graphics.inc:	\
	intro_knight.zx02
	echo "knight_zx02: .incbin \"intro_knight.zx02\"" > intro_knight_graphics.inc

###

intro_knight.zx02:	intro_knight.hgr
	$(ZX02) -f intro_knight.hgr intro_knight.zx02

intro_knight.hgr:	intro_knight.png
	$(PNG2HGR) intro_knight.png > intro_knight.hgr

###

knight_priority.inc:  \
	knight_priority.zx02
	echo "knight_priority_zx02: .incbin \"knight_priority.zx02\"" > knight_priority.inc

####

knight_priority.zx02:	knight_priority.combined
	$(ZX02) -f knight_priority.combined knight_priority.zx02

knight_priority.combined:	knight_priority.gr knight_collision.bin
	cat knight_priority.gr >  knight_priority.combined
	cat knight_collision.bin >> knight_priority.combined

knight_priority.gr:	knight_priority.png
	$(PNG2GR) knight_priority.png knight_priority.gr

knight_collision.bin:	knight_collision.png
	$(PNG2COLLISION) knight_collision.png knight_collision.bin

knight_collision2.bin:	knight_collision2.png
	$(PNG2COLLISION) knight_collision2.png knight_collision2.bin


####

clean:	
	rm -f *~ knight_graphics.inc knight_night_graphics.inc \
		knight_priority.inc \
		*.bin *.combined *.zx02 *.gr *.hgr

