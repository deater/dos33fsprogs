
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	graphics_inn.inc \
	priority_inn.inc

###

graphics_inn.inc:	\
	inside_inn.lzsa
	echo "inside_inn_lzsa: .incbin \"inside_inn.lzsa\"" > graphics_inn.inc

###

inside_inn.lzsa:	inside_inn.hgr
	$(LZSA) -r -f2 inside_inn.hgr inside_inn.lzsa

inside_inn.hgr:	inside_inn.png
	$(PNG2HGR) inside_inn.png > inside_inn.hgr

###

priority_inn.inc:  \
	todo_priority.lzsa
	echo "inside_inn_priority_lzsa: .incbin \"todo_priority.lzsa\"" > priority_inn.inc

####

todo_priority.lzsa:	todo_priority.gr
	$(LZSA) -r -f2 todo_priority.gr todo_priority.lzsa

todo_priority.gr:	todo_priority.png
	$(PNG2GR) todo_priority.png todo_priority.gr

####

clean:	
	rm -f *~ graphics_inn.inc priority_inn.inc *.lzsa *.gr *.hgr

