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
	kerrek1.hgr.zx02 kerrek1.raw.zx02 kerrek1.vraw.zx02 \
	kerrek1.bvraw.zx02 kerrek1.bzvraw.zx02 \
	merry_christmas.hgr.zx02 merry_christmas.raw.zx02 merry_christmas.vraw.zx02 \
	merry_christmas.bvraw.zx02 merry_christmas.bzvraw.zx02 \
	ice3.hgr.zx02 ice3.raw.zx02 ice3.vraw.zx02 \
	ice3.bvraw.zx02 ice3.bzvraw.zx02 \
	magsteps2_n.hgr.zx02 magsteps2_n.raw.zx02 magsteps2_n.vraw.zx02 \
	magsteps2_n.bvraw.zx02 magsteps2_n.bzvraw.zx02

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

kerrek1.vraw.zx02:	kerrek1.vraw
	$(ZX02) kerrek1.vraw kerrek1.vraw.zx02

kerrek1.vraw:  kerrek1.png
	$(PNG_TO_HGR_RAW) -r kerrek1.png > kerrek1.vraw

####

kerrek1.bvraw.zx02:	kerrek1.bvraw
	$(ZX02) kerrek1.bvraw kerrek1.bvraw.zx02

kerrek1.bvraw:  kerrek1.png
	$(PNG_TO_HGR_RAW) -r -b kerrek1.png > kerrek1.bvraw

####

kerrek1.bzvraw.zx02:	kerrek1.bzvraw
	$(ZX02) kerrek1.bzvraw kerrek1.bzvraw.zx02

kerrek1.bzvraw:  kerrek1.png
	$(PNG_TO_HGR_RAW) -r -b -z kerrek1.png > kerrek1.bzvraw




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

merry_christmas.vraw.zx02:	merry_christmas.vraw
	$(ZX02) merry_christmas.vraw merry_christmas.vraw.zx02

merry_christmas.vraw:  merry_christmas.png
	$(PNG_TO_HGR_RAW) -r merry_christmas.png > merry_christmas.vraw

####

merry_christmas.bvraw.zx02:	merry_christmas.bvraw
	$(ZX02) merry_christmas.bvraw merry_christmas.bvraw.zx02

merry_christmas.bvraw:  merry_christmas.png
	$(PNG_TO_HGR_RAW) -r -b merry_christmas.png > merry_christmas.bvraw

####

merry_christmas.bzvraw.zx02:	merry_christmas.bzvraw
	$(ZX02) merry_christmas.bzvraw merry_christmas.bzvraw.zx02

merry_christmas.bzvraw:  merry_christmas.png
	$(PNG_TO_HGR_RAW) -r -b -z merry_christmas.png > merry_christmas.bzvraw


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

ice3.vraw.zx02:	ice3.vraw
	$(ZX02) ice3.vraw ice3.vraw.zx02

ice3.vraw:  ice3.png
	$(PNG_TO_HGR_RAW) -r ice3.png > ice3.vraw

####

ice3.bvraw.zx02:	ice3.bvraw
	$(ZX02) ice3.bvraw ice3.bvraw.zx02

ice3.bvraw:  ice3.png
	$(PNG_TO_HGR_RAW) -r -b ice3.png > ice3.bvraw

####

ice3.bzvraw.zx02:	ice3.bzvraw
	$(ZX02) ice3.bzvraw ice3.bzvraw.zx02

ice3.bzvraw:  ice3.png
	$(PNG_TO_HGR_RAW) -r -b -z ice3.png > ice3.bzvraw




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

magsteps2_n.vraw.zx02:	magsteps2_n.vraw
	$(ZX02) magsteps2_n.vraw magsteps2_n.vraw.zx02

magsteps2_n.vraw:  magsteps2_n.png
	$(PNG_TO_HGR_RAW) -r magsteps2_n.png > magsteps2_n.vraw

####

magsteps2_n.bvraw.zx02:	magsteps2_n.bvraw
	$(ZX02) magsteps2_n.bvraw magsteps2_n.bvraw.zx02

magsteps2_n.bvraw:  magsteps2_n.png
	$(PNG_TO_HGR_RAW) -r -b magsteps2_n.png > magsteps2_n.bvraw

####

magsteps2_n.bzvraw.zx02:	magsteps2_n.bzvraw
	$(ZX02) magsteps2_n.bzvraw magsteps2_n.bzvraw.zx02

magsteps2_n.bzvraw:  magsteps2_n.png
	$(PNG_TO_HGR_RAW) -r -b magsteps2_n.png > magsteps2_n.bzvraw



####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc *.raw *.vraw *.bvraw *.bzvraw

