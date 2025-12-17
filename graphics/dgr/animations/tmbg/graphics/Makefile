include ../../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../../utils/hgr-utils/png2hgr
PNG_TO_DGR = ../../../../../utils/gr-utils/png2dgr
PNG_TO_DHGR_RAW = ../../../../../utils/hgr-utils/png2dhgr_raw
PNG_TO_DHGR4 = ../../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../../linker_scripts/
PNG_TO_HGR_DIFF = ../../../../../utils/hgr-utils/png2hgr_diff

all:	\
	tmbg01.aux.zx02 tmbg01.main.zx02 \
	tmbg02.aux.zx02 tmbg02.main.zx02
#	frame1_frame3_diff.inc frame3_frame5_diff.inc \
#	frame5_frame7_diff.inc frame7_frame1_diff.inc \
#	frame2_frame4_diff.inc frame4_frame6_diff.inc \
#	frame6_frame8_diff.inc frame8_frame2_diff.inc


####

frame1_frame3_diff.inc:	a2_frame0001.png a2_frame0003.png
	$(PNG_TO_HGR_DIFF) a2_frame0001.png a2_frame0003.png > frame1_frame3_diff.inc

frame3_frame5_diff.inc:	a2_frame0003.png a2_frame0005.png
	$(PNG_TO_HGR_DIFF) a2_frame0003.png a2_frame0005.png > frame3_frame5_diff.inc

frame5_frame7_diff.inc:	a2_frame0005.png a2_frame0007.png
	$(PNG_TO_HGR_DIFF) a2_frame0005.png a2_frame0007.png > frame5_frame7_diff.inc

frame7_frame1_diff.inc:	a2_frame0007.png a2_frame0001.png
	$(PNG_TO_HGR_DIFF) a2_frame0007.png a2_frame0001.png > frame7_frame1_diff.inc


frame2_frame4_diff.inc:	a2_frame0002.png a2_frame0004.png
	$(PNG_TO_HGR_DIFF) a2_frame0002.png a2_frame0004.png > frame2_frame4_diff.inc

frame4_frame6_diff.inc:	a2_frame0004.png a2_frame0006.png
	$(PNG_TO_HGR_DIFF) a2_frame0004.png a2_frame0006.png > frame4_frame6_diff.inc

frame6_frame8_diff.inc:	a2_frame0006.png a2_frame0008.png
	$(PNG_TO_HGR_DIFF) a2_frame0006.png a2_frame0008.png > frame6_frame8_diff.inc

frame8_frame2_diff.inc:	a2_frame0008.png a2_frame0002.png
	$(PNG_TO_HGR_DIFF) a2_frame0008.png a2_frame0002.png > frame8_frame2_diff.inc





####

tmbg01.aux.zx02:	tmbg01.aux
	$(ZX02) tmbg01.aux tmbg01.aux.zx02

tmbg01.main.zx02:	tmbg01.main
	$(ZX02) tmbg01.main tmbg01.main.zx02

tmbg01.aux:  tmbg01.png
	$(PNG_TO_DGR) tmbg01.png tmbg01

####

tmbg02.aux.zx02:	tmbg02.aux
	$(ZX02) tmbg02.aux tmbg02.aux.zx02

tmbg02.main.zx02:	tmbg02.main
	$(ZX02) tmbg02.main tmbg02.main.zx02

tmbg02.aux:  tmbg02.png
	$(PNG_TO_DGR) tmbg02.png tmbg02

####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc

