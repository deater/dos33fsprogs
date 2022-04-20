PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	graphics_hr_level1.inc \
	graphics_hr_level2.inc \
	graphics_hr_level3.inc \
	graphics_hr_level4.inc \
	graphics_hr_level5.inc \
	graphics_hr_level6.inc \
	graphics_hr_level7.inc


####

graphics_hr_level1.inc:	\
	hr_level1.lzsa \
	hr_level1_preview.lzsa
	echo "hr_level1_lzsa: .incbin \"hr_level1.lzsa\"" > graphics_hr_level1.inc
	echo "hr_level1_preview_lzsa: .incbin \"hr_level1_preview.lzsa\"" >> graphics_hr_level1.inc

graphics_hr_level2.inc:	\
	hr_level2.lzsa \
	hr_level2_preview.lzsa
	echo "hr_level2_lzsa: .incbin \"hr_level2.lzsa\"" > graphics_hr_level2.inc
	echo "hr_level2_preview_lzsa: .incbin \"hr_level2_preview.lzsa\"" >> graphics_hr_level2.inc

graphics_hr_level3.inc:	\
	hr_level3.lzsa \
	hr_level3_preview.lzsa
	echo "hr_level3_lzsa: .incbin \"hr_level3.lzsa\"" > graphics_hr_level3.inc
	echo "hr_level3_preview_lzsa: .incbin \"hr_level3_preview.lzsa\"" >> graphics_hr_level3.inc

graphics_hr_level4.inc:	\
	hr_level4.lzsa \
	hr_level4_preview.lzsa
	echo "hr_level4_lzsa: .incbin \"hr_level4.lzsa\"" > graphics_hr_level4.inc
	echo "hr_level4_preview_lzsa: .incbin \"hr_level4_preview.lzsa\"" >> graphics_hr_level4.inc

graphics_hr_level5.inc:	\
	hr_level5.lzsa \
	hr_level5_preview.lzsa
	echo "hr_level5_lzsa: .incbin \"hr_level5.lzsa\"" > graphics_hr_level5.inc
	echo "hr_level5_preview_lzsa: .incbin \"hr_level5_preview.lzsa\"" >> graphics_hr_level5.inc

graphics_hr_level6.inc:	\
	hr_level6.lzsa \
	hr_level6_preview.lzsa
	echo "hr_level6_lzsa: .incbin \"hr_level6.lzsa\"" > graphics_hr_level6.inc
	echo "hr_level6_preview_lzsa: .incbin \"hr_level6_preview.lzsa\"" >> graphics_hr_level6.inc

graphics_hr_level7.inc:	\
	hr_level7.lzsa \
	hr_level7_preview.lzsa
	echo "hr_level7_lzsa: .incbin \"hr_level7.lzsa\"" > graphics_hr_level7.inc
	echo "hr_level7_preview_lzsa: .incbin \"hr_level7_preview.lzsa\"" >> graphics_hr_level7.inc






###

hr_level1.lzsa:	hr_level1.hgr
	$(LZSA) -r -f2 hr_level1.hgr hr_level1.lzsa

hr_level1.hgr:	l1_sb.png
	$(PNG2HGR) l1_sb.png > hr_level1.hgr

###

hr_level1_preview.lzsa:	hr_level1_preview.hgr
	$(LZSA) -r -f2 hr_level1_preview.hgr hr_level1_preview.lzsa

hr_level1_preview.hgr:	l1_preview.png
	$(PNG2HGR) l1_preview.png > hr_level1_preview.hgr


###

hr_level2.lzsa:	hr_level2.hgr
	$(LZSA) -r -f2 hr_level2.hgr hr_level2.lzsa

hr_level2.hgr:	l2_taran.png
	$(PNG2HGR) l2_taran.png > hr_level2.hgr

###

hr_level2_preview.lzsa:	hr_level2_preview.hgr
	$(LZSA) -r -f2 hr_level2_preview.hgr hr_level2_preview.lzsa

hr_level2_preview.hgr:	l2_preview.png
	$(PNG2HGR) l2_preview.png > hr_level2_preview.hgr


###

hr_level3.lzsa:	hr_level3.hgr
	$(LZSA) -r -f2 hr_level3.hgr hr_level3.lzsa

hr_level3.hgr:	l3_hstarmy.png
	$(PNG2HGR) l3_hstarmy.png > hr_level3.hgr

###

hr_level3_preview.lzsa:	hr_level3_preview.hgr
	$(LZSA) -r -f2 hr_level3_preview.hgr hr_level3_preview.lzsa

hr_level3_preview.hgr:	l3_preview.png
	$(PNG2HGR) l3_preview.png > hr_level3_preview.hgr

###

hr_level4.lzsa:	hr_level4.hgr
	$(LZSA) -r -f2 hr_level4.hgr hr_level4.lzsa

hr_level4.hgr:	l4_bubs.png
	$(PNG2HGR) l4_bubs.png > hr_level4.hgr

###

hr_level4_preview.lzsa:	hr_level4_preview.hgr
	$(LZSA) -r -f2 hr_level4_preview.hgr hr_level4_preview.lzsa

hr_level4_preview.hgr:	l4_preview.png
	$(PNG2HGR) l4_preview.png > hr_level4_preview.hgr

###

hr_level5.lzsa:	hr_level5.hgr
	$(LZSA) -r -f2 hr_level5.hgr hr_level5.lzsa

hr_level5.hgr:	l5_trog.png
	$(PNG2HGR) l5_trog.png > hr_level5.hgr

###

hr_level5_preview.lzsa:	hr_level5_preview.hgr
	$(LZSA) -r -f2 hr_level5_preview.hgr hr_level5_preview.lzsa

hr_level5_preview.hgr:	l5_preview.png
	$(PNG2HGR) l5_preview.png > hr_level5_preview.hgr

###

hr_level6.lzsa:	hr_level6.hgr
	$(LZSA) -r -f2 hr_level6.hgr hr_level6.lzsa

hr_level6.hgr:	l6_rr.png
	$(PNG2HGR) l6_rr.png > hr_level6.hgr

###

hr_level6_preview.lzsa:	hr_level6_preview.hgr
	$(LZSA) -r -f2 hr_level6_preview.hgr hr_level6_preview.lzsa

hr_level6_preview.hgr:	l6_preview.png
	$(PNG2HGR) l6_preview.png > hr_level6_preview.hgr

###

hr_level7.lzsa:	hr_level7.hgr
	$(LZSA) -r -f2 hr_level7.hgr hr_level7.lzsa

hr_level7.hgr:	l7_floppy.png
	$(PNG2HGR) l7_floppy.png > hr_level7.hgr

###

hr_level7_preview.lzsa:	hr_level7_preview.hgr
	$(LZSA) -r -f2 hr_level7_preview.hgr hr_level7_preview.lzsa

hr_level7_preview.hgr:	l7_preview.png
	$(PNG2HGR) l7_preview.png > hr_level7_preview.hgr




###

clean:	
	rm -f *~ *.lzsa *.gr *.hgr

