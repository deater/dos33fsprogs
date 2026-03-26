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
	a2_gentfish_farm01.bzvraw.zx02 \
	a2_gentfish_farm01.hgr.zx02 \
	a2_gentfish_farm02.hgr.zx02 \
	a2_gentfish_farm01_02_diff.inc \
	a2_gentfish_farm01_03_diff.inc a2_gentfish_farm03_05_diff.inc \
	a2_gentfish_farm05_07_diff.inc a2_gentfish_farm07_09_diff.inc \
	a2_gentfish_farm09_11_diff.inc a2_gentfish_farm11_13_diff.inc \
	a2_gentfish_farm13_15_diff.inc a2_gentfish_farm15_17_diff.inc \
	a2_gentfish_farm17_19_diff.inc a2_gentfish_farm19_21_diff.inc \
	a2_gentfish_farm21_23_diff.inc a2_gentfish_farm23_25_diff.inc \
	a2_gentfish_farm25_27_diff.inc a2_gentfish_farm27_29_diff.inc \
	a2_gentfish_farm29_31_diff.inc a2_gentfish_farm31_33_diff.inc \
	a2_gentfish_farm33_35_diff.inc a2_gentfish_farm35_37_diff.inc \
	a2_gentfish_farm37_39_diff.inc a2_gentfish_farm39_41_diff.inc \
	a2_gentfish_farm41_43_diff.inc a2_gentfish_farm43_45_diff.inc \
	a2_gentfish_farm45_47_diff.inc a2_gentfish_farm47_01_diff.inc \
	a2_gentfish_farm02_04_diff.inc a2_gentfish_farm04_06_diff.inc \
	a2_gentfish_farm06_08_diff.inc a2_gentfish_farm08_10_diff.inc \
	a2_gentfish_farm10_12_diff.inc a2_gentfish_farm12_14_diff.inc \
	a2_gentfish_farm14_16_diff.inc a2_gentfish_farm16_18_diff.inc \
	a2_gentfish_farm18_20_diff.inc a2_gentfish_farm20_22_diff.inc \
	a2_gentfish_farm22_24_diff.inc a2_gentfish_farm24_26_diff.inc \
	a2_gentfish_farm26_28_diff.inc a2_gentfish_farm28_30_diff.inc \
	a2_gentfish_farm30_32_diff.inc a2_gentfish_farm32_34_diff.inc \
	a2_gentfish_farm34_36_diff.inc a2_gentfish_farm36_38_diff.inc \
	a2_gentfish_farm38_40_diff.inc a2_gentfish_farm40_42_diff.inc \
	a2_gentfish_farm42_44_diff.inc a2_gentfish_farm44_46_diff.inc \
	a2_gentfish_farm46_48_diff.inc a2_gentfish_farm48_02_diff.inc


####

a2_gentfish_farm01.bzvraw.zx02:	a2_gentfish_farm01.bzvraw
	$(ZX02) a2_gentfish_farm01.bzvraw a2_gentfish_farm01.bzvraw.zx02

a2_gentfish_farm01.bzvraw:	a2_gentfish_farm01.png
	$(PNG_TO_HGR_RAW) -r -b -z a2_gentfish_farm01.png > a2_gentfish_farm01.bzvraw

####

a2_gentfish_farm01.hgr.zx02:	a2_gentfish_farm01.hgr
	$(ZX02) a2_gentfish_farm01.hgr a2_gentfish_farm01.hgr.zx02

a2_gentfish_farm01.hgr:  a2_gentfish_farm01.png
	$(PNG_TO_HGR) a2_gentfish_farm01.png > a2_gentfish_farm01.hgr

####

a2_gentfish_farm02.hgr.zx02:	a2_gentfish_farm02.hgr
	$(ZX02) a2_gentfish_farm02.hgr a2_gentfish_farm02.hgr.zx02

a2_gentfish_farm02.hgr:  a2_gentfish_farm02.png
	$(PNG_TO_HGR) a2_gentfish_farm02.png > a2_gentfish_farm02.hgr

####

a2_gentfish_farm01_02_diff.inc:	a2_gentfish_farm01.png a2_gentfish_farm02.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm01.png a2_gentfish_farm02.png > a2_gentfish_farm01_02_diff.inc

###

a2_gentfish_farm01_03_diff.inc:	a2_gentfish_farm01.png a2_gentfish_farm03.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm01.png a2_gentfish_farm03.png > a2_gentfish_farm01_03_diff.inc

a2_gentfish_farm03_05_diff.inc:	a2_gentfish_farm03.png a2_gentfish_farm05.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm03.png a2_gentfish_farm05.png > a2_gentfish_farm03_05_diff.inc

a2_gentfish_farm05_07_diff.inc:	a2_gentfish_farm05.png a2_gentfish_farm07.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm05.png a2_gentfish_farm07.png > a2_gentfish_farm05_07_diff.inc

a2_gentfish_farm07_09_diff.inc:	a2_gentfish_farm07.png a2_gentfish_farm09.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm07.png a2_gentfish_farm09.png > a2_gentfish_farm07_09_diff.inc

a2_gentfish_farm09_11_diff.inc:	a2_gentfish_farm09.png a2_gentfish_farm11.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm09.png a2_gentfish_farm11.png > a2_gentfish_farm09_11_diff.inc

a2_gentfish_farm11_13_diff.inc:	a2_gentfish_farm11.png a2_gentfish_farm13.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm11.png a2_gentfish_farm13.png > a2_gentfish_farm11_13_diff.inc

a2_gentfish_farm13_15_diff.inc:	a2_gentfish_farm13.png a2_gentfish_farm15.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm13.png a2_gentfish_farm15.png > a2_gentfish_farm13_15_diff.inc

a2_gentfish_farm15_17_diff.inc:	a2_gentfish_farm15.png a2_gentfish_farm17.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm15.png a2_gentfish_farm17.png > a2_gentfish_farm15_17_diff.inc

a2_gentfish_farm17_19_diff.inc:	a2_gentfish_farm17.png a2_gentfish_farm19.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm17.png a2_gentfish_farm19.png > a2_gentfish_farm17_19_diff.inc

a2_gentfish_farm19_21_diff.inc:	a2_gentfish_farm19.png a2_gentfish_farm21.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm19.png a2_gentfish_farm21.png > a2_gentfish_farm19_21_diff.inc

a2_gentfish_farm21_23_diff.inc:	a2_gentfish_farm21.png a2_gentfish_farm23.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm21.png a2_gentfish_farm23.png > a2_gentfish_farm21_23_diff.inc

a2_gentfish_farm23_25_diff.inc:	a2_gentfish_farm23.png a2_gentfish_farm25.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm23.png a2_gentfish_farm25.png > a2_gentfish_farm23_25_diff.inc

a2_gentfish_farm25_27_diff.inc:	a2_gentfish_farm25.png a2_gentfish_farm27.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm25.png a2_gentfish_farm27.png > a2_gentfish_farm25_27_diff.inc

a2_gentfish_farm27_29_diff.inc:	a2_gentfish_farm27.png a2_gentfish_farm29.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm27.png a2_gentfish_farm29.png > a2_gentfish_farm27_29_diff.inc

a2_gentfish_farm29_31_diff.inc:	a2_gentfish_farm29.png a2_gentfish_farm31.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm29.png a2_gentfish_farm31.png > a2_gentfish_farm29_31_diff.inc

a2_gentfish_farm31_33_diff.inc:	a2_gentfish_farm31.png a2_gentfish_farm33.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm31.png a2_gentfish_farm33.png > a2_gentfish_farm31_33_diff.inc

a2_gentfish_farm33_35_diff.inc:	a2_gentfish_farm33.png a2_gentfish_farm35.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm33.png a2_gentfish_farm35.png > a2_gentfish_farm33_35_diff.inc

a2_gentfish_farm35_37_diff.inc:	a2_gentfish_farm35.png a2_gentfish_farm37.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm35.png a2_gentfish_farm37.png > a2_gentfish_farm35_37_diff.inc

a2_gentfish_farm37_39_diff.inc:	a2_gentfish_farm37.png a2_gentfish_farm39.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm37.png a2_gentfish_farm39.png > a2_gentfish_farm37_39_diff.inc

a2_gentfish_farm39_41_diff.inc:	a2_gentfish_farm39.png a2_gentfish_farm41.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm39.png a2_gentfish_farm41.png > a2_gentfish_farm39_41_diff.inc

a2_gentfish_farm41_43_diff.inc:	a2_gentfish_farm41.png a2_gentfish_farm43.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm41.png a2_gentfish_farm43.png > a2_gentfish_farm41_43_diff.inc

a2_gentfish_farm43_45_diff.inc:	a2_gentfish_farm43.png a2_gentfish_farm45.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm43.png a2_gentfish_farm45.png > a2_gentfish_farm43_45_diff.inc

a2_gentfish_farm45_47_diff.inc:	a2_gentfish_farm45.png a2_gentfish_farm47.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm45.png a2_gentfish_farm47.png > a2_gentfish_farm45_47_diff.inc

a2_gentfish_farm47_01_diff.inc:	a2_gentfish_farm47.png a2_gentfish_farm01.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm47.png a2_gentfish_farm01.png > a2_gentfish_farm47_01_diff.inc

####

a2_gentfish_farm02_04_diff.inc:	a2_gentfish_farm02.png a2_gentfish_farm04.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm02.png a2_gentfish_farm04.png > a2_gentfish_farm02_04_diff.inc

a2_gentfish_farm04_06_diff.inc:	a2_gentfish_farm04.png a2_gentfish_farm06.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm04.png a2_gentfish_farm06.png > a2_gentfish_farm04_06_diff.inc

a2_gentfish_farm06_08_diff.inc:	a2_gentfish_farm06.png a2_gentfish_farm08.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm06.png a2_gentfish_farm08.png > a2_gentfish_farm06_08_diff.inc

a2_gentfish_farm08_10_diff.inc:	a2_gentfish_farm08.png a2_gentfish_farm10.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm08.png a2_gentfish_farm10.png > a2_gentfish_farm08_10_diff.inc

a2_gentfish_farm10_12_diff.inc:	a2_gentfish_farm10.png a2_gentfish_farm12.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm10.png a2_gentfish_farm12.png > a2_gentfish_farm10_12_diff.inc

a2_gentfish_farm12_14_diff.inc:	a2_gentfish_farm12.png a2_gentfish_farm14.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm12.png a2_gentfish_farm14.png > a2_gentfish_farm12_14_diff.inc

a2_gentfish_farm14_16_diff.inc:	a2_gentfish_farm14.png a2_gentfish_farm16.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm14.png a2_gentfish_farm16.png > a2_gentfish_farm14_16_diff.inc

a2_gentfish_farm16_18_diff.inc:	a2_gentfish_farm16.png a2_gentfish_farm18.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm16.png a2_gentfish_farm18.png > a2_gentfish_farm16_18_diff.inc

a2_gentfish_farm18_20_diff.inc:	a2_gentfish_farm18.png a2_gentfish_farm20.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm18.png a2_gentfish_farm20.png > a2_gentfish_farm18_20_diff.inc

a2_gentfish_farm20_22_diff.inc:	a2_gentfish_farm20.png a2_gentfish_farm22.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm20.png a2_gentfish_farm22.png > a2_gentfish_farm20_22_diff.inc

a2_gentfish_farm22_24_diff.inc:	a2_gentfish_farm22.png a2_gentfish_farm24.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm22.png a2_gentfish_farm24.png > a2_gentfish_farm22_24_diff.inc

a2_gentfish_farm24_26_diff.inc:	a2_gentfish_farm24.png a2_gentfish_farm26.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm24.png a2_gentfish_farm26.png > a2_gentfish_farm24_26_diff.inc

a2_gentfish_farm26_28_diff.inc:	a2_gentfish_farm26.png a2_gentfish_farm28.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm26.png a2_gentfish_farm28.png > a2_gentfish_farm26_28_diff.inc

a2_gentfish_farm28_30_diff.inc:	a2_gentfish_farm28.png a2_gentfish_farm30.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm28.png a2_gentfish_farm30.png > a2_gentfish_farm28_30_diff.inc

a2_gentfish_farm30_32_diff.inc:	a2_gentfish_farm30.png a2_gentfish_farm32.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm30.png a2_gentfish_farm32.png > a2_gentfish_farm30_32_diff.inc

a2_gentfish_farm32_34_diff.inc:	a2_gentfish_farm32.png a2_gentfish_farm34.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm32.png a2_gentfish_farm34.png > a2_gentfish_farm32_34_diff.inc

a2_gentfish_farm34_36_diff.inc:	a2_gentfish_farm34.png a2_gentfish_farm36.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm34.png a2_gentfish_farm36.png > a2_gentfish_farm34_36_diff.inc

a2_gentfish_farm36_38_diff.inc:	a2_gentfish_farm36.png a2_gentfish_farm38.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm36.png a2_gentfish_farm38.png > a2_gentfish_farm36_38_diff.inc

a2_gentfish_farm38_40_diff.inc:	a2_gentfish_farm38.png a2_gentfish_farm40.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm38.png a2_gentfish_farm40.png > a2_gentfish_farm38_40_diff.inc

a2_gentfish_farm40_42_diff.inc:	a2_gentfish_farm40.png a2_gentfish_farm42.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm40.png a2_gentfish_farm42.png > a2_gentfish_farm40_42_diff.inc

a2_gentfish_farm42_44_diff.inc:	a2_gentfish_farm42.png a2_gentfish_farm44.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm42.png a2_gentfish_farm44.png > a2_gentfish_farm42_44_diff.inc

a2_gentfish_farm44_46_diff.inc:	a2_gentfish_farm44.png a2_gentfish_farm46.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm44.png a2_gentfish_farm46.png > a2_gentfish_farm44_46_diff.inc

a2_gentfish_farm46_48_diff.inc:	a2_gentfish_farm46.png a2_gentfish_farm48.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm46.png a2_gentfish_farm48.png > a2_gentfish_farm46_48_diff.inc

a2_gentfish_farm48_02_diff.inc:	a2_gentfish_farm48.png a2_gentfish_farm02.png
	$(PNG_TO_HGR_DIFF) a2_gentfish_farm48.png a2_gentfish_farm02.png > a2_gentfish_farm48_02_diff.inc




####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc

