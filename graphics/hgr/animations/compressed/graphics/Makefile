include ../../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../../utils/hgr-utils/png2hgr
PNG_TO_HGR_RAW = ../../../../../utils/hgr-utils/png2hgr_raw
PNG_TO_DHGR = ../../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_RAW = ../../../../../utils/hgr-utils/png2dhgr_raw
PNG_TO_DHGR4 = ../../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../../linker_scripts/
PNG_TO_HGR_DIFF = ../../../../../utils/hgr-utils/png2hgr_diff

all:	\
	kerrek1.hgr.zx02 kerrek1.raw.zx02 \
	merry_christmas.hgr.zx02 merry_christmas.raw.zx02 \
	ice3.hgr.zx02 ice3.raw.zx02 \
	magsteps2_n.hgr.zx02 magsteps2_n.raw.zx02

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

merry_christmas.hgr.zx02:	merry_christmas.hgr
	$(ZX02) merry_christmas.hgr merry_christmas.hgr.zx02

merry_christmas.hgr:  merry_christmas.png
	$(PNG_TO_HGR) merry_christmas.png > merry_christmas.hgr

####

merry_christmas.raw.zx02:	merry_christmas.raw
	$(ZX02) merry_christmas.raw merry_christmas.raw.zx02

merry_christmas.raw:  merry_christmas.png
	$(PNG_TO_HGR_RAW) merry_christmas.png > merry_christmas.raw

####

ice3.hgr.zx02:	ice3.hgr
	$(ZX02) ice3.hgr ice3.hgr.zx02

ice3.hgr:  ice3.png
	$(PNG_TO_HGR) ice3.png > ice3.hgr

####

ice3.raw.zx02:	ice3.raw
	$(ZX02) ice3.raw ice3.raw.zx02

ice3.raw:  ice3.png
	$(PNG_TO_HGR_RAW) ice3.png > ice3.raw


####

magsteps2_n.hgr.zx02:	magsteps2_n.hgr
	$(ZX02) magsteps2_n.hgr magsteps2_n.hgr.zx02

magsteps2_n.hgr:  magsteps2_n.png
	$(PNG_TO_HGR) magsteps2_n.png > magsteps2_n.hgr

####

magsteps2_n.raw.zx02:	magsteps2_n.raw
	$(ZX02) magsteps2_n.raw magsteps2_n.raw.zx02

magsteps2_n.raw:  magsteps2_n.png
	$(PNG_TO_HGR_RAW) magsteps2_n.png > magsteps2_n.raw




####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc *.raw

