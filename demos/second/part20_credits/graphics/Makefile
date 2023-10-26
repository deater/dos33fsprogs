include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	credits_2.hgr.zx02 \
	summary1.hgr.zx02 summary2.hgr.zx02 \
	summary1_invert.hgr.zx02 summary2_invert.hgr.zx02

####

credits_2.hgr:	credits_2.png
	$(PNG_TO_HGR) credits_2.png > credits_2.hgr

credits_2.hgr.zx02:	credits_2.hgr
	$(ZX02) credits_2.hgr credits_2.hgr.zx02

####

summary1.hgr:	summary1.png
	$(PNG_TO_HGR) summary1.png > summary1.hgr

summary1.hgr.zx02:	summary1.hgr
	$(ZX02) summary1.hgr summary1.hgr.zx02

####

summary2.hgr:	summary2.png
	$(PNG_TO_HGR) summary2.png > summary2.hgr

summary2.hgr.zx02:	summary2.hgr
	$(ZX02) summary2.hgr summary2.hgr.zx02

####

summary1_invert.hgr:	summary1_invert.png
	$(PNG_TO_HGR) summary1_invert.png > summary1_invert.hgr

summary1_invert.hgr.zx02:	summary1_invert.hgr
	$(ZX02) summary1_invert.hgr summary1_invert.hgr.zx02

####

summary2_invert.hgr:	summary2_invert.png
	$(PNG_TO_HGR) summary2_invert.png > summary2_invert.hgr

summary2_invert.hgr.zx02:	summary2_invert.hgr
	$(ZX02) summary2_invert.hgr summary2_invert.hgr.zx02






####

clean:
	rm -f *~ *.zx02
