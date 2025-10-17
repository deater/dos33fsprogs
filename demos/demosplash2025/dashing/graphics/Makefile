include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	pq_tree_dhgr.aux.zx02 pq_tree_dhgr.bin.zx02 \
	pq_cave_dhgr.aux.zx02 pq_cave_dhgr.bin.zx02


###

pq_tree_dhgr.aux.zx02:     pq_tree_dhgr.AUX
	$(ZX02) pq_tree_dhgr.AUX pq_tree_dhgr.aux.zx02

pq_tree_dhgr.AUX:  pq_tree_dhgr.png
	$(PNG_TO_DHGR) pq_tree_dhgr.png pq_tree_dhgr

pq_tree_dhgr.bin.zx02:     pq_tree_dhgr.BIN
	$(ZX02) pq_tree_dhgr.BIN pq_tree_dhgr.bin.zx02

pq_tree_dhgr.BIN: pq_tree_dhgr.png
	$(PNG_TO_DHGR) pq_tree_dhgr.png pq_tree_dhgr

###

pq_cave_dhgr.aux.zx02:     pq_cave_dhgr.AUX
	$(ZX02) pq_cave_dhgr.AUX pq_cave_dhgr.aux.zx02

pq_cave_dhgr.AUX:  pq_cave_dhgr.png
	$(PNG_TO_DHGR) pq_cave_dhgr.png pq_cave_dhgr

pq_cave_dhgr.bin.zx02:     pq_cave_dhgr.BIN
	$(ZX02) pq_cave_dhgr.BIN pq_cave_dhgr.bin.zx02

pq_cave_dhgr.BIN: pq_cave_dhgr.png
	$(PNG_TO_DHGR) pq_cave_dhgr.png pq_cave_dhgr



####

clean:
	rm -f *~ INTRO *.zx02 *.lst *.o *.AUX *.BIN
