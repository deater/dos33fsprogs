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
	q0001.hgr.zx02 \
	q0002.hgr.zx02 \
	q0001_0002_diff.inc \
	q0001_0003_diff.inc q0003_0005_diff.inc \
	q0005_0007_diff.inc q0007_0001_diff.inc \
	q0002_0004_diff.inc q0004_0006_diff.inc \
	q0006_0008_diff.inc q0008_0002_diff.inc




####

q0001.hgr.zx02:	q0001.hgr
	$(ZX02) q0001.hgr q0001.hgr.zx02

q0001.hgr:  q0001.png
	$(PNG_TO_HGR) q0001.png > q0001.hgr

####

q0002.hgr.zx02:	q0002.hgr
	$(ZX02) q0002.hgr q0002.hgr.zx02

q0002.hgr:  q0002.png
	$(PNG_TO_HGR) q0002.png > q0002.hgr

####

q0001_0002_diff.inc:	q0001.png q0002.png
	$(PNG_TO_HGR_DIFF) q0001.png q0002.png > q0001_0002_diff.inc

###

q0001_0003_diff.inc:	q0001.png q0003.png
	$(PNG_TO_HGR_DIFF) q0001.png q0003.png > q0001_0003_diff.inc

q0003_0005_diff.inc:	q0003.png q0005.png
	$(PNG_TO_HGR_DIFF) q0003.png q0005.png > q0003_0005_diff.inc

q0005_0007_diff.inc:	q0005.png q0007.png
	$(PNG_TO_HGR_DIFF) q0005.png q0007.png > q0005_0007_diff.inc

q0007_0001_diff.inc:	q0007.png q0001.png
	$(PNG_TO_HGR_DIFF) q0007.png q0001.png > q0007_0001_diff.inc

####

q0002_0004_diff.inc:	q0002.png q0004.png
	$(PNG_TO_HGR_DIFF) q0002.png q0004.png > q0002_0004_diff.inc

q0004_0006_diff.inc:	q0004.png q0006.png
	$(PNG_TO_HGR_DIFF) q0004.png q0006.png > q0004_0006_diff.inc

q0006_0008_diff.inc:	q0006.png q0008.png
	$(PNG_TO_HGR_DIFF) q0006.png q0008.png > q0006_0008_diff.inc

q0008_0002_diff.inc:	q0008.png q0002.png
	$(PNG_TO_HGR_DIFF) q0008.png q0002.png > q0008_0002_diff.inc

####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc

