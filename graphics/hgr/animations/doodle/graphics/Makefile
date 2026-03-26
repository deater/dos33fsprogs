include ../../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_RAW = ../../../../../utils/hgr-utils/png2dhgr_raw
PNG_TO_DHGR4 = ../../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../../linker_scripts/
PNG_TO_HGR_DIFF = ../../../../../utils/hgr-utils/png2hgr_diff -w2
PNG_TO_HGR_RAW = ../../../../../utils/hgr-utils/png2hgr_raw

all:	\
	a2_doodle001.hgr.zx02 \
	a2_doodle008.hgr.zx02 \
	a2_doodle001_008_diff.inc \
	a2_doodle001_003_diff.inc a2_doodle003_005_diff.inc \
	a2_doodle005_007_diff.inc a2_doodle007_001_diff.inc \
	a2_doodle002_004_diff.inc a2_doodle004_006_diff.inc \
	a2_doodle006_008_diff.inc a2_doodle008_002_diff.inc

####

a2_doodle001.hgr.zx02:	a2_doodle001.hgr
	$(ZX02) a2_doodle001.hgr a2_doodle001.hgr.zx02

a2_doodle001.hgr:  a2_doodle001.png
	$(PNG_TO_HGR) a2_doodle001.png > a2_doodle001.hgr

####

a2_doodle008.hgr.zx02:	a2_doodle008.hgr
	$(ZX02) a2_doodle008.hgr a2_doodle008.hgr.zx02

a2_doodle008.hgr:  a2_doodle008.png
	$(PNG_TO_HGR) a2_doodle008.png > a2_doodle008.hgr

####

a2_doodle001_008_diff.inc:	a2_doodle001.png a2_doodle008.png
	$(PNG_TO_HGR_DIFF) a2_doodle001.png a2_doodle008.png a2_doodle001.png > a2_doodle001_008_diff.inc

###

a2_doodle001_003_diff.inc:	a2_doodle001.png a2_doodle003.png
	$(PNG_TO_HGR_DIFF) a2_doodle001.png a2_doodle003.png a2_doodle002.png > a2_doodle001_003_diff.inc

a2_doodle003_005_diff.inc:	a2_doodle003.png a2_doodle005.png
	$(PNG_TO_HGR_DIFF) a2_doodle003.png a2_doodle005.png a2_doodle004.png > a2_doodle003_005_diff.inc

a2_doodle005_007_diff.inc:	a2_doodle005.png a2_doodle007.png
	$(PNG_TO_HGR_DIFF) a2_doodle005.png a2_doodle007.png a2_doodle006.png > a2_doodle005_007_diff.inc

a2_doodle007_001_diff.inc:	a2_doodle007.png a2_doodle001.png
	$(PNG_TO_HGR_DIFF) a2_doodle007.png a2_doodle001.png a2_doodle008.png > a2_doodle007_001_diff.inc

####

a2_doodle002_004_diff.inc:	a2_doodle002.png a2_doodle004.png
	$(PNG_TO_HGR_DIFF) a2_doodle002.png a2_doodle004.png a2_doodle003.png > a2_doodle002_004_diff.inc

a2_doodle004_006_diff.inc:	a2_doodle004.png a2_doodle006.png
	$(PNG_TO_HGR_DIFF) a2_doodle004.png a2_doodle006.png a2_doodle005.png > a2_doodle004_006_diff.inc

a2_doodle006_008_diff.inc:	a2_doodle006.png a2_doodle008.png
	$(PNG_TO_HGR_DIFF) a2_doodle006.png a2_doodle008.png a2_doodle007.png > a2_doodle006_008_diff.inc

a2_doodle008_002_diff.inc:	a2_doodle008.png a2_doodle002.png
	$(PNG_TO_HGR_DIFF) a2_doodle008.png a2_doodle002.png a2_doodle001.png > a2_doodle008_002_diff.inc


####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc

