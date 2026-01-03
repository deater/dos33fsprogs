include ../../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../../utils/hgr-utils/png2hgr
PNG_TO_HGR_RAW = ../../../../../utils/hgr-utils/png2hgr_raw
HGR_SPRITE = ../../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../../linker_scripts/
PNG_TO_HGR_DIFF = ../../../../../utils/hgr-utils/png2hgr_diff

all:	\
	kerrek1.hgr.zx02 kerrek1.raw.zx02 \
	crooked_tree_night.hgr.zx02 \
	crooked_alone.hgr.zx02 \
	lake_e.hgr.zx02 \
	knight.hgr.zx02 \
	inside_cottage.hgr.zx02

####

inside_cottage.hgr.zx02:	inside_cottage.hgr
	$(ZX02) inside_cottage.hgr inside_cottage.hgr.zx02

inside_cottage.hgr:  inside_cottage.png
	$(PNG_TO_HGR) inside_cottage.png > inside_cottage.hgr

####

knight.hgr.zx02:	knight.hgr
	$(ZX02) knight.hgr knight.hgr.zx02

knight.hgr:  knight.png
	$(PNG_TO_HGR) knight.png > knight.hgr

####

lake_e.hgr.zx02:	lake_e.hgr
	$(ZX02) lake_e.hgr lake_e.hgr.zx02

lake_e.hgr:  lake_e.png
	$(PNG_TO_HGR) lake_e.png > lake_e.hgr

####

crooked_tree_night.hgr.zx02:	crooked_tree_night.hgr
	$(ZX02) crooked_tree_night.hgr crooked_tree_night.hgr.zx02

crooked_tree_night.hgr:  crooked_tree_night.png
	$(PNG_TO_HGR) crooked_tree_night.png > crooked_tree_night.hgr

####

crooked_alone.hgr.zx02:	crooked_alone.hgr
	$(ZX02) crooked_alone.hgr crooked_alone.hgr.zx02

crooked_alone.hgr:  crooked_alone.png
	$(PNG_TO_HGR) crooked_alone.png > crooked_alone.hgr

####

kerrek1.hgr.zx02:	kerrek1.hgr
	$(ZX02) kerrek1.hgr kerrek1.hgr.zx02

kerrek1.hgr:  kerrek1.png
	$(PNG_TO_HGR) kerrek1.png > kerrek1.hgr

####

kerrek1.raw.zx02:	kerrek1.raw
	$(ZX02) kerrek1.raw kerrek1.raw.zx02

kerrek1.raw:  kerrek1.png
	$(PNG_TO_HGR_RAW) kerrek1.png > kerrek1.raw


####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc *.raw

