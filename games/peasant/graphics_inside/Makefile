
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d

all:	graphics_inside.inc \
	priority_inside.inc

###

graphics_inside.inc:	\
	hidden_glen.lzsa inside_cottage.lzsa inside_nn.lzsa
	echo "hidden_glen_lzsa: .incbin \"hidden_glen.lzsa\"" > graphics_inside.inc
	echo "inside_cottage_lzsa: .incbin \"inside_cottage.lzsa\"" >> graphics_inside.inc
	echo "inside_nn_lzsa: .incbin \"inside_nn.lzsa\"" >> graphics_inside.inc

###

hidden_glen.lzsa:	hidden_glen.hgr
	$(LZSA) -r -f2 hidden_glen.hgr hidden_glen.lzsa

hidden_glen.hgr:	hidden_glen.png
	$(PNG2HGR) hidden_glen.png > hidden_glen.hgr

###

inside_cottage.lzsa:	inside_cottage.hgr
	$(LZSA) -r -f2 inside_cottage.hgr inside_cottage.lzsa

inside_cottage.hgr:	inside_cottage.png
	$(PNG2HGR) inside_cottage.png > inside_cottage.hgr

###

inside_nn.lzsa:	inside_nn.hgr
	$(LZSA) -r -f2 inside_nn.hgr inside_nn.lzsa

inside_nn.hgr:	inside_nn.png
	$(PNG2HGR) inside_nn.png > inside_nn.hgr



###

priority_inside.inc:  \
	inside_nn_priority.lzsa \
	hidden_glen_priority.lzsa \
	inside_cottage_priority.lzsa
	echo "hidden_glen_priority_lzsa: .incbin \"hidden_glen_priority.lzsa\"" > priority_inside.inc
	echo "inside_cottage_priority_lzsa: .incbin \"inside_cottage_priority.lzsa\"" >> priority_inside.inc
	echo "inside_nn_priority_lzsa: .incbin \"inside_nn_priority.lzsa\"" >> priority_inside.inc

####

inside_cottage_priority.lzsa:	inside_cottage_priority.gr
	$(LZSA) -r -f2 inside_cottage_priority.gr inside_cottage_priority.lzsa

inside_cottage_priority.gr:	inside_cottage_priority.png
	$(PNG2GR) inside_cottage_priority.png inside_cottage_priority.gr

####

inside_nn_priority.lzsa:	inside_nn_priority.gr
	$(LZSA) -r -f2 inside_nn_priority.gr inside_nn_priority.lzsa

inside_nn_priority.gr:	inside_nn_priority.png
	$(PNG2GR) inside_nn_priority.png inside_nn_priority.gr

####

hidden_glen_priority.lzsa:	hidden_glen_priority.gr
	$(LZSA) -r -f2 hidden_glen_priority.gr hidden_glen_priority.lzsa

hidden_glen_priority.gr:	hidden_glen_priority.png
	$(PNG2GR) hidden_glen_priority.png hidden_glen_priority.gr


####



clean:	
	rm -f *~ graphics_inside.inc priority_inside.inc *.lzsa *.gr *.hgr

