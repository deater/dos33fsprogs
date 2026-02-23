include ../../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR_RAW = ../../../../../utils/hgr-utils/png2dhgr_raw
PNG_TO_DHGR4 = ../../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../../linker_scripts/
PNG_TO_HGR_DIFF = ../../../../../utils/hgr-utils/png2hgr_diff

all:	\
	horse00.bin.zx02 horse00.aux.zx02 \
	horse01.bin.zx02 horse01.aux.zx02


####

slots1_slots3_diff.inc:	slots1.png slots3.png
	$(PNG_TO_HGR_DIFF) slots1.png slots3.png > slots1_slots3_diff.inc

slots3_slots5_diff.inc:	slots3.png slots5.png
	$(PNG_TO_HGR_DIFF) slots3.png slots5.png > slots3_slots5_diff.inc

slots5_slots7_diff.inc:	slots5.png slots7.png
	$(PNG_TO_HGR_DIFF) slots5.png slots7.png > slots5_slots7_diff.inc

slots7_slots2_diff.inc:	slots7.png slots2.png
	$(PNG_TO_HGR_DIFF) slots7.png slots2.png > slots7_slots2_diff.inc


slots2_slots4_diff.inc:	slots2.png slots4.png
	$(PNG_TO_HGR_DIFF) slots2.png slots4.png > slots2_slots4_diff.inc

slots4_slots6_diff.inc:	slots4.png slots6.png
	$(PNG_TO_HGR_DIFF) slots4.png slots6.png > slots4_slots6_diff.inc

slots6_slots1_diff.inc:	slots6.png slots1.png
	$(PNG_TO_HGR_DIFF) slots6.png slots1.png > slots6_slots1_diff.inc


###

horse00.aux.zx02:	horse00.AUX
	$(ZX02) horse00.AUX horse00.aux.zx02

horse00.AUX:	horse00.png
	$(PNG_TO_DHGR) horse00.png horse00

horse00.bin.zx02:	horse00.BIN
	$(ZX02) horse00.BIN horse00.bin.zx02

horse00.BIN:	horse00.png
	$(PNG_TO_DHGR) horse00.png horse00

###

horse01.aux.zx02:	horse01.AUX
	$(ZX02) horse01.AUX horse01.aux.zx02

horse01.AUX:	horse01.png
	$(PNG_TO_DHGR) horse01.png horse01

horse01.bin.zx02:	horse01.BIN
	$(ZX02) horse01.BIN horse01.bin.zx02

horse01.BIN:	horse01.png
	$(PNG_TO_DHGR) horse01.png horse01


####

clean:
	rm -f *~ *.zx02 *.lst *.o *.hgr *_diff.inc

