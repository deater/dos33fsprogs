
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	cliff_graphics.inc \
	priority_cliff.inc

###

cliff_graphics.inc:	\
	cliff_base.lzsa cliff_heights.lzsa outer.lzsa
	echo "cliff_base_lzsa: .incbin \"cliff_base.lzsa\"" > cliff_graphics.inc
	echo "cliff_heights_lzsa: .incbin \"cliff_heights.lzsa\"" >> cliff_graphics.inc
	echo "outer_lzsa: .incbin \"outer.lzsa\"" >> cliff_graphics.inc

###

cliff_base.lzsa:	cliff_base.hgr
	$(LZSA) -r -f2 cliff_base.hgr cliff_base.lzsa

cliff_base.hgr:	cliff_base.png
	$(PNG2HGR) cliff_base.png > cliff_base.hgr

###

cliff_heights.lzsa:	cliff_heights.hgr
	$(LZSA) -r -f2 cliff_heights.hgr cliff_heights.lzsa

cliff_heights.hgr:	cliff_heights.png
	$(PNG2HGR) cliff_heights.png > cliff_heights.hgr

###

outer.lzsa:	outer.hgr
	$(LZSA) -r -f2 outer.hgr outer.lzsa

outer.hgr:	outer.png
	$(PNG2HGR) outer.png > outer.hgr



###

priority_cliff.inc:  \
	todo_priority.lzsa \
	cliff_base_priority.lzsa \
	cliff_heights_priority.lzsa
	echo "cliff_base_priority_lzsa: .incbin \"cliff_base_priority.lzsa\"" > priority_cliff.inc
	echo "cliff_heights_priority_lzsa: .incbin \"cliff_heights_priority.lzsa\"" >> priority_cliff.inc
	echo "outer_priority_lzsa: .incbin \"todo_priority.lzsa\"" >> priority_cliff.inc


####

todo_priority.lzsa:	todo_priority.gr
	$(LZSA) -r -f2 todo_priority.gr todo_priority.lzsa

todo_priority.gr:	todo_priority.png
	$(PNG2GR) todo_priority.png todo_priority.gr

####

cliff_base_priority.lzsa:	cliff_base_priority.gr
	$(LZSA) -r -f2 cliff_base_priority.gr cliff_base_priority.lzsa

cliff_base_priority.gr:	cliff_base_priority.png
	$(PNG2GR) cliff_base_priority.png cliff_base_priority.gr

####

cliff_heights_priority.lzsa:	cliff_heights_priority.gr
	$(LZSA) -r -f2 cliff_heights_priority.gr cliff_heights_priority.lzsa

cliff_heights_priority.gr:	cliff_heights_priority.png
	$(PNG2GR) cliff_heights_priority.png cliff_heights_priority.gr


####


clean:	
	rm -f *~ cliff_graphics.inc priority_cliff.inc *.lzsa *.gr *.hgr

