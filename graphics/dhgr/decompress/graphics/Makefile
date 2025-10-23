include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_BIG = ../../../../utils/hgr-utils/png2dhgr_big
PNG_TO_DHGR4 = ../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	monster_pumpkin.bin.zx02 monster_pumpkin.aux.zx02 \
	monster_pumpkin.combined.zx02 monster_pumpkin.big.zx02 \
	monster_pumpkin.big_packed.zx02


####

monster_pumpkin.big_packed.zx02:     monster_pumpkin.big_packed
	$(ZX02) monster_pumpkin.big_packed monster_pumpkin.big_packed.zx02

monster_pumpkin.big_packed:  monster_pumpkin.png
	$(PNG_TO_DHGR_BIG) monster_pumpkin.png monster_pumpkin

monster_pumpkin.big.zx02:     monster_pumpkin.big
	$(ZX02) monster_pumpkin.big monster_pumpkin.big.zx02

monster_pumpkin.big:  monster_pumpkin.png
	$(PNG_TO_DHGR_BIG) monster_pumpkin.png monster_pumpkin

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
	rm -f *~ *.zx02 *.lst *.o *.AUX *.BIN *.big *.big_packed
