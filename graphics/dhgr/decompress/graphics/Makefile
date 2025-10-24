include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_RAW = ../../../../utils/hgr-utils/png2dhgr_raw
PNG_TO_DHGR4 = ../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	monster_pumpkin.bin.zx02 monster_pumpkin.aux.zx02 \
	monster_pumpkin.combined.zx02 \
	monster_pumpkin.uncompact.zx02 \
	monster_pumpkin.raw.zx02 \
	monster_pumpkin.raw_top.zx02 monster_pumpkin.raw_bottom.zx02


####

monster_pumpkin.raw.zx02:     monster_pumpkin.raw
	$(ZX02) monster_pumpkin.raw monster_pumpkin.raw.zx02

monster_pumpkin.raw:  monster_pumpkin.png
	$(PNG_TO_DHGR_RAW) monster_pumpkin.png monster_pumpkin

####

monster_pumpkin.raw_top.zx02:     monster_pumpkin.raw_top
	$(ZX02) monster_pumpkin.raw_top monster_pumpkin.raw_top.zx02

monster_pumpkin.raw_top:  monster_pumpkin.png
	$(PNG_TO_DHGR_RAW) -t monster_pumpkin.png monster_pumpkin

####

monster_pumpkin.raw_bottom.zx02:     monster_pumpkin.raw_bottom
	$(ZX02) monster_pumpkin.raw_bottom monster_pumpkin.raw_bottom.zx02

monster_pumpkin.raw_bottom:  monster_pumpkin.png
	$(PNG_TO_DHGR_RAW) -t monster_pumpkin.png monster_pumpkin


###

monster_pumpkin.uncompact.zx02:     monster_pumpkin.uncompact
	$(ZX02) monster_pumpkin.uncompact monster_pumpkin.uncompact.zx02

monster_pumpkin.uncompact:  monster_pumpkin.png
	$(PNG_TO_DHGR_RAW) -u monster_pumpkin.png monster_pumpkin

###

monster_pumpkin.combined.zx02:     monster_pumpkin.combined
	$(ZX02) monster_pumpkin.combined monster_pumpkin.combined.zx02

monster_pumpkin.combined:     monster_pumpkin.AUX monster_pumpkin.BIN
	cat monster_pumpkin.BIN > monster_pumpkin.combined
	cat monster_pumpkin.AUX >> monster_pumpkin.combined

monster_pumpkin.aux.zx02:     monster_pumpkin.AUX
	$(ZX02) monster_pumpkin.AUX monster_pumpkin.aux.zx02

monster_pumpkin.AUX:  monster_pumpkin.png
	$(PNG_TO_DHGR) monster_pumpkin.png monster_pumpkin

monster_pumpkin.bin.zx02:     monster_pumpkin.BIN
	$(ZX02) monster_pumpkin.BIN monster_pumpkin.bin.zx02

monster_pumpkin.BIN: monster_pumpkin.png
	$(PNG_TO_DHGR) monster_pumpkin.png monster_pumpkin


####

clean:
	rm -f *~ *.zx02 *.lst *.o *.AUX *.BIN *.raw *.uncompact *.raw_top *.raw_bottom
