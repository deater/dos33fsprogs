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
	monster-bw5.bin.zx02 monster-bw5.aux.zx02 \
	monster-bw7.bin.zx02 monster-bw7.aux.zx02 \
	monster-bw10.bin.zx02 monster-bw10.aux.zx02 \
	monster-c7.bin.zx02 monster-c7.aux.zx02 \
	monster-c7.raw.zx02 \
	monster_hand.raw_top.zx02 monster_hand.raw_bottom.zx02 \
	monster_pumpkin.raw_top.zx02 monster_pumpkin.raw_bottom.zx02 \
	monster-bw5.raw_top.zx02 monster-bw5.raw_bottom.zx02 \
	monster-bw7.raw_top.zx02 monster-bw7.raw_bottom.zx02 \
	monster-c7.raw_top.zx02 monster-c7.raw_bottom.zx02 \
	pq_tree_dhgr.raw_top.zx02 pq_tree_dhgr.raw_bottom.zx02 \
	pq_cave_dhgr.raw_top.zx02 pq_cave_dhgr.raw_bottom.zx02


####

pq_cave_dhgr.raw_top.zx02:     pq_cave_dhgr.raw_top
	$(ZX02) pq_cave_dhgr.raw_top pq_cave_dhgr.raw_top.zx02

pq_cave_dhgr.raw_top:  pq_cave_dhgr.png
	$(PNG_TO_DHGR_RAW) -t pq_cave_dhgr.png pq_cave_dhgr

pq_cave_dhgr.raw_bottom.zx02:     pq_cave_dhgr.raw_bottom
	$(ZX02) pq_cave_dhgr.raw_bottom pq_cave_dhgr.raw_bottom.zx02

pq_cave_dhgr.raw_bottom: pq_cave_dhgr.png
	$(PNG_TO_DHGR_RAW) -t pq_cave_dhgr.png pq_cave_dhgr

####

pq_tree_dhgr.raw_top.zx02:     pq_tree_dhgr.raw_top
	$(ZX02) pq_tree_dhgr.raw_top pq_tree_dhgr.raw_top.zx02

pq_tree_dhgr.raw_top:  pq_tree_dhgr.png
	$(PNG_TO_DHGR_RAW) -t pq_tree_dhgr.png pq_tree_dhgr

pq_tree_dhgr.raw_bottom.zx02:     pq_tree_dhgr.raw_bottom
	$(ZX02) pq_tree_dhgr.raw_bottom pq_tree_dhgr.raw_bottom.zx02

pq_tree_dhgr.raw_bottom: pq_tree_dhgr.png
	$(PNG_TO_DHGR_RAW) -t pq_tree_dhgr.png pq_tree_dhgr

####

monster_hand.raw_top.zx02:     monster_hand.raw_top
	$(ZX02) monster_hand.raw_top monster_hand.raw_top.zx02

monster_hand.raw_top:  monster_hand.png
	$(PNG_TO_DHGR_RAW) -t monster_hand.png monster_hand

monster_hand.raw_bottom.zx02:     monster_hand.raw_bottom
	$(ZX02) monster_hand.raw_bottom monster_hand.raw_bottom.zx02

monster_hand.raw_bottom: monster_hand.png
	$(PNG_TO_DHGR_RAW) -t monster_hand.png monster_hand

####

monster_pumpkin.raw_top.zx02:     monster_pumpkin.raw_top
	$(ZX02) monster_pumpkin.raw_top monster_pumpkin.raw_top.zx02

monster_pumpkin.raw_top:  monster_pumpkin.png
	$(PNG_TO_DHGR_RAW) -t monster_pumpkin.png monster_pumpkin

monster_pumpkin.raw_bottom.zx02:     monster_pumpkin.raw_bottom
	$(ZX02) monster_pumpkin.raw_bottom monster_pumpkin.raw_bottom.zx02

monster_pumpkin.raw_bottom: monster_pumpkin.png
	$(PNG_TO_DHGR_RAW) -t monster_pumpkin.png monster_pumpkin


monster_pumpkin.aux.zx02:     monster_pumpkin.AUX
	$(ZX02) monster_pumpkin.AUX monster_pumpkin.aux.zx02

monster_pumpkin.AUX:  monster_pumpkin.png
	$(PNG_TO_DHGR) monster_pumpkin.png monster_pumpkin

monster_pumpkin.bin.zx02:     monster_pumpkin.BIN
	$(ZX02) monster_pumpkin.BIN monster_pumpkin.bin.zx02

monster_pumpkin.BIN: monster_pumpkin.png
	$(PNG_TO_DHGR) monster_pumpkin.png monster_pumpkin

####

monster-bw5.raw_top.zx02:     monster-bw5.raw_top
	$(ZX02) monster-bw5.raw_top monster-bw5.raw_top.zx02

monster-bw5.raw_top:  monster-bw5.png
	$(PNG_TO_DHGR_RAW) -t monster-bw5.png monster-bw5

monster-bw5.raw_bottom.zx02:     monster-bw5.raw_bottom
	$(ZX02) monster-bw5.raw_bottom monster-bw5.raw_bottom.zx02

monster-bw5.raw_bottom: monster-bw5.png
	$(PNG_TO_DHGR_RAW) -t monster-bw5.png monster-bw5

monster-bw5.aux.zx02:     monster-bw5.AUX
	$(ZX02) monster-bw5.AUX monster-bw5.aux.zx02

monster-bw5.AUX:  monster-bw5.png
	$(PNG_TO_DHGR) monster-bw5.png monster-bw5

monster-bw5.bin.zx02:     monster-bw5.BIN
	$(ZX02) monster-bw5.BIN monster-bw5.bin.zx02

monster-bw5.BIN: monster-bw5.png
	$(PNG_TO_DHGR) monster-bw5.png monster-bw5


####

monster-bw7.raw_top.zx02:     monster-bw7.raw_top
	$(ZX02) monster-bw7.raw_top monster-bw7.raw_top.zx02

monster-bw7.raw_top:  monster-bw7.png
	$(PNG_TO_DHGR_RAW) -t monster-bw7.png monster-bw7

monster-bw7.raw_bottom.zx02:     monster-bw7.raw_bottom
	$(ZX02) monster-bw7.raw_bottom monster-bw7.raw_bottom.zx02

monster-bw7.raw_bottom: monster-bw7.png
	$(PNG_TO_DHGR_RAW) -t monster-bw7.png monster-bw7

monster-bw7.aux.zx02:     monster-bw7.AUX
	$(ZX02) monster-bw7.AUX monster-bw7.aux.zx02

monster-bw7.AUX:  monster-bw7.png
	$(PNG_TO_DHGR) monster-bw7.png monster-bw7

monster-bw7.bin.zx02:     monster-bw7.BIN
	$(ZX02) monster-bw7.BIN monster-bw7.bin.zx02

monster-bw7.BIN: monster-bw7.png
	$(PNG_TO_DHGR) monster-bw7.png monster-bw7


####

monster-bw10.aux.zx02:     monster-bw10.AUX
	$(ZX02) monster-bw10.AUX monster-bw10.aux.zx02

monster-bw10.AUX:  monster-bw10.png
	$(PNG_TO_DHGR) monster-bw10.png monster-bw10

monster-bw10.bin.zx02:     monster-bw10.BIN
	$(ZX02) monster-bw10.BIN monster-bw10.bin.zx02

monster-bw10.BIN: monster-bw10.png
	$(PNG_TO_DHGR) monster-bw10.png monster-bw10


####

monster-c7.raw.zx02:     monster-c7.raw
	$(ZX02) monster-c7.raw monster-c7.raw.zx02

monster-c7.raw:  monster-c7.png
	$(PNG_TO_DHGR_RAW) monster-c7.png monster-c7

monster-c7.big.zx02:     monster-c7.big
	$(ZX02) monster-c7.big monster-c7.big.zx02

monster-c7.big:  monster-c7.png
	$(PNG_TO_DHGR_RAW) monster-c7.png monster-c7

monster-c7.combined.zx02:     monster-c7.combined
	$(ZX02) monster-c7.combined monster-c7.combined.zx02

monster-c7.combined:     monster-c7.AUX monster-c7.BIN
	cat monster-c7.BIN > monster-c7.combined
	cat monster-c7.AUX >> monster-c7.combined

monster-c7.aux.zx02:     monster-c7.AUX
	$(ZX02) monster-c7.AUX monster-c7.aux.zx02

monster-c7.AUX:  monster-c7.png
	$(PNG_TO_DHGR) monster-c7.png monster-c7

monster-c7.bin.zx02:     monster-c7.BIN
	$(ZX02) monster-c7.BIN monster-c7.bin.zx02

monster-c7.BIN: monster-c7.png
	$(PNG_TO_DHGR) monster-c7.png monster-c7

monster-c7.raw_top.zx02:     monster-c7.raw_top
	$(ZX02) monster-c7.raw_top monster-c7.raw_top.zx02

monster-c7.raw_top:  monster-c7.png
	$(PNG_TO_DHGR_RAW) -t monster-c7.png monster-c7

monster-c7.raw_bottom.zx02:     monster-c7.raw_bottom
	$(ZX02) monster-c7.raw_bottom monster-c7.raw_bottom.zx02

monster-c7.raw_bottom: monster-c7.png
	$(PNG_TO_DHGR_RAW) -t monster-c7.png monster-c7



####

clean:
	rm -f *~ *.zx02 *.lst *.o *.AUX *.BIN *.big *.big_packed *.combined *.raw_top *.raw_bottom *.raw
