include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr

all:	entry_graphics.inc

entry_graphics.inc:	\
	door_w.hgr.zx02 door_e.hgr.zx02 \
	near_door_w.hgr.zx02 near_door_e.hgr.zx02 near_door_s.hgr.zx02
	echo "door_w_zx02: .incbin \"door_w.hgr.zx02\"" > entry_graphics.inc
	echo "door_e_zx02: .incbin \"door_e.hgr.zx02\"" >> entry_graphics.inc
	echo "near_door_w_zx02: .incbin \"near_door_w.hgr.zx02\"" >> entry_graphics.inc
	echo "near_door_e_zx02: .incbin \"near_door_e.hgr.zx02\"" >> entry_graphics.inc
	echo "near_door_s_zx02: .incbin \"near_door_s.hgr.zx02\"" >> entry_graphics.inc





####

%.hgr: %.png
	$(PNG_TO_HGR) $< > $@

%.hgr.zx02: %.hgr
	$(ZX02) -f $< $@

####

clean:
	rm -f *~ *.o *.lst  *.zx02 *.hgr entry_graphics.inc

