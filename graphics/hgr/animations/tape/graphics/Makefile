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

all:	\
	tape0001.hgr.zx02 \
	tape0002.hgr.zx02 \
	tape01_tape03_diff.inc tape03_tape05_diff.inc \
	tape05_tape07_diff.inc tape07_tape09_diff.inc \
	tape09_tape11_diff.inc tape11_tape13_diff.inc \
	tape13_tape15_diff.inc tape15_tape17_diff.inc \
	tape17_tape19_diff.inc tape19_tape21_diff.inc \
	tape21_tape23_diff.inc tape23_tape01_diff.inc \
	tape02_tape04_diff.inc tape04_tape06_diff.inc \
	tape06_tape08_diff.inc tape08_tape10_diff.inc \
	tape10_tape12_diff.inc tape12_tape14_diff.inc \
	tape14_tape16_diff.inc tape16_tape18_diff.inc \
	tape18_tape20_diff.inc tape20_tape22_diff.inc \
	tape22_tape24_diff.inc tape24_tape02_diff.inc

####

tape01_tape03_diff.inc:	tape0001.png tape0003.png
	$(PNG_TO_HGR_DIFF) tape0001.png tape0003.png > tape01_tape03_diff.inc

tape03_tape05_diff.inc:	tape0003.png tape0005.png
	$(PNG_TO_HGR_DIFF) tape0003.png tape0005.png > tape03_tape05_diff.inc

tape05_tape07_diff.inc:	tape0005.png tape0007.png
	$(PNG_TO_HGR_DIFF) tape0005.png tape0007.png > tape05_tape07_diff.inc

tape07_tape09_diff.inc:	tape0007.png tape0009.png
	$(PNG_TO_HGR_DIFF) tape0007.png tape0009.png > tape07_tape09_diff.inc

tape09_tape11_diff.inc:	tape0009.png tape0011.png
	$(PNG_TO_HGR_DIFF) tape0009.png tape0011.png > tape09_tape11_diff.inc

tape11_tape13_diff.inc:	tape0011.png tape0013.png
	$(PNG_TO_HGR_DIFF) tape0011.png tape0013.png > tape11_tape13_diff.inc

tape13_tape15_diff.inc:	tape0013.png tape0015.png
	$(PNG_TO_HGR_DIFF) tape0013.png tape0015.png > tape13_tape15_diff.inc

tape15_tape17_diff.inc:	tape0015.png tape0017.png
	$(PNG_TO_HGR_DIFF) tape0015.png tape0017.png > tape15_tape17_diff.inc

tape17_tape19_diff.inc:	tape0017.png tape0019.png
	$(PNG_TO_HGR_DIFF) tape0017.png tape0019.png > tape17_tape19_diff.inc

tape19_tape21_diff.inc:	tape0019.png tape0021.png
	$(PNG_TO_HGR_DIFF) tape0019.png tape0021.png > tape19_tape21_diff.inc

tape21_tape23_diff.inc:	tape0021.png tape0023.png
	$(PNG_TO_HGR_DIFF) tape0021.png tape0023.png > tape21_tape23_diff.inc

tape23_tape01_diff.inc:	tape0023.png tape0001.png
	$(PNG_TO_HGR_DIFF) tape0023.png tape0001.png > tape23_tape01_diff.inc




tape02_tape04_diff.inc:	tape0002.png tape0004.png
	$(PNG_TO_HGR_DIFF) tape0002.png tape0004.png > tape02_tape04_diff.inc

tape04_tape06_diff.inc:	tape0004.png tape0006.png
	$(PNG_TO_HGR_DIFF) tape0004.png tape0006.png > tape04_tape06_diff.inc

tape06_tape08_diff.inc:	tape0006.png tape0008.png
	$(PNG_TO_HGR_DIFF) tape0006.png tape0008.png > tape06_tape08_diff.inc

tape08_tape10_diff.inc:	tape0008.png tape0010.png
	$(PNG_TO_HGR_DIFF) tape0008.png tape0010.png > tape08_tape10_diff.inc

tape10_tape12_diff.inc:	tape0010.png tape0012.png
	$(PNG_TO_HGR_DIFF) tape0010.png tape0012.png > tape10_tape12_diff.inc

tape12_tape14_diff.inc:	tape0012.png tape0014.png
	$(PNG_TO_HGR_DIFF) tape0012.png tape0014.png > tape12_tape14_diff.inc

tape14_tape16_diff.inc:	tape0014.png tape0016.png
	$(PNG_TO_HGR_DIFF) tape0014.png tape0016.png > tape14_tape16_diff.inc

tape16_tape18_diff.inc:	tape0016.png tape0018.png
	$(PNG_TO_HGR_DIFF) tape0016.png tape0018.png > tape16_tape18_diff.inc

tape18_tape20_diff.inc:	tape0018.png tape0020.png
	$(PNG_TO_HGR_DIFF) tape0018.png tape0020.png > tape18_tape20_diff.inc

tape20_tape22_diff.inc:	tape0020.png tape0022.png
	$(PNG_TO_HGR_DIFF) tape0020.png tape0022.png > tape20_tape22_diff.inc

tape22_tape24_diff.inc:	tape0022.png tape0024.png
	$(PNG_TO_HGR_DIFF) tape0022.png tape0024.png > tape22_tape24_diff.inc

tape24_tape02_diff.inc:	tape0024.png tape0002.png
	$(PNG_TO_HGR_DIFF) tape0024.png tape0002.png > tape24_tape02_diff.inc









####

tape0001.hgr.zx02:	tape0001.hgr
	$(ZX02) tape0001.hgr tape0001.hgr.zx02

tape0001.hgr:  tape0001.png
	$(PNG_TO_HGR) tape0001.png > tape0001.hgr

####

tape0002.hgr.zx02:	tape0002.hgr
	$(ZX02) tape0002.hgr tape0002.hgr.zx02

tape0002.hgr:  tape0002.png
	$(PNG_TO_HGR) tape0002.png > tape0002.hgr

####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc

