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
	kerrek1.hgr.zx02 kerrek1.raw.zx02

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

