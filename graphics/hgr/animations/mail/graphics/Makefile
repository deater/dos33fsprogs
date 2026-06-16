include ../../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_RAW = ../../../../../utils/hgr-utils/png2dhgr_raw
PNG_TO_DHGR4 = ../../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../../linker_scripts/
PNG_TO_HGR_DIFF = ../../../../../utils/hgr-utils/png2hgr_diff -w1
PNG_TO_HGR_RAW = ../../../../../utils/hgr-utils/png2hgr_raw

all:	\
	mq0001.hgr.zx02 \
	mq0002.hgr.zx02 \
	mq0001_0002_diff.inc \
	mq0001_0003_diff.inc mq0003_0001_diff.inc \
	mq0002_0004_diff.inc mq0004_0002_diff.inc

####

mq0001.hgr.zx02:	mq0001.hgr
	$(ZX02) mq0001.hgr mq0001.hgr.zx02

mq0001.hgr:  mq0001.png
	$(PNG_TO_HGR) mq0001.png > mq0001.hgr

####

mq0002.hgr.zx02:	mq0002.hgr
	$(ZX02) mq0002.hgr mq0002.hgr.zx02

mq0002.hgr:  mq0002.png
	$(PNG_TO_HGR) mq0002.png > mq0002.hgr

####

mq0001_0002_diff.inc:	mq0001.png mq0002.png
	$(PNG_TO_HGR_DIFF) mq0001.png mq0002.png > mq0001_0002_diff.inc

###

mq0001_0003_diff.inc:	mq0001.png mq0003.png
	$(PNG_TO_HGR_DIFF) mq0001.png mq0003.png > mq0001_0003_diff.inc

mq0003_0001_diff.inc:	mq0003.png mq0001.png
	$(PNG_TO_HGR_DIFF) mq0003.png mq0001.png > mq0003_0001_diff.inc

###

mq0002_0004_diff.inc:	mq0002.png mq0004.png
	$(PNG_TO_HGR_DIFF) mq0002.png mq0004.png > mq0002_0004_diff.inc

mq0004_0002_diff.inc:	mq0004.png mq0002.png
	$(PNG_TO_HGR_DIFF) mq0004.png mq0002.png > mq0004_0002_diff.inc

####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc

