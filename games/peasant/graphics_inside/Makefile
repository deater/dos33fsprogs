
PNG2RLE = ../../../utils/gr-utils/png2rle
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2HGR = ../../../utils/hgr-utils/png2hgr
#LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../../utils/bmp2dhr/b2d
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	graphics_inside.inc \
	priority_inside.inc

###

graphics_inside.inc:	\
	hidden_glen.zx02 inside_cottage.zx02 inside_nn.zx02
	echo "hidden_glen_zx02: .incbin \"hidden_glen.zx02\"" > graphics_inside.inc
	echo "inside_cottage_zx02: .incbin \"inside_cottage.zx02\"" >> graphics_inside.inc
	echo "inside_nn_zx02: .incbin \"inside_nn.zx02\"" >> graphics_inside.inc

###

hidden_glen.zx02:	hidden_glen.hgr
	$(ZX02) -f hidden_glen.hgr hidden_glen.zx02

hidden_glen.hgr:	hidden_glen.png
	$(PNG2HGR) hidden_glen.png > hidden_glen.hgr

###

inside_cottage.zx02:	inside_cottage.hgr
	$(ZX02) -f inside_cottage.hgr inside_cottage.zx02

inside_cottage.hgr:	inside_cottage.png
	$(PNG2HGR) inside_cottage.png > inside_cottage.hgr

###

inside_nn.zx02:	inside_nn.hgr
	$(ZX02) -f inside_nn.hgr inside_nn.zx02

inside_nn.hgr:	inside_nn.png
	$(PNG2HGR) inside_nn.png > inside_nn.hgr



###

priority_inside.inc:  \
	inside_nn_priority.zx02 \
	hidden_glen_priority.zx02 \
	inside_cottage_priority.zx02
	echo "hidden_glen_priority_zx02: .incbin \"hidden_glen_priority.zx02\"" > priority_inside.inc
	echo "inside_cottage_priority_zx02: .incbin \"inside_cottage_priority.zx02\"" >> priority_inside.inc
	echo "inside_nn_priority_zx02: .incbin \"inside_nn_priority.zx02\"" >> priority_inside.inc

####

inside_cottage_priority.zx02:	inside_cottage_priority.gr
	$(ZX02) -f inside_cottage_priority.gr inside_cottage_priority.zx02

inside_cottage_priority.gr:	inside_cottage_priority.png
	$(PNG2GR) inside_cottage_priority.png inside_cottage_priority.gr

####

inside_nn_priority.zx02:	inside_nn_priority.gr
	$(ZX02) -f inside_nn_priority.gr inside_nn_priority.zx02

inside_nn_priority.gr:	inside_nn_priority.png
	$(PNG2GR) inside_nn_priority.png inside_nn_priority.gr

####

hidden_glen_priority.zx02:	hidden_glen_priority.gr
	$(ZX02) -f hidden_glen_priority.gr hidden_glen_priority.zx02

hidden_glen_priority.gr:	hidden_glen_priority.png
	$(PNG2GR) hidden_glen_priority.png hidden_glen_priority.gr


####



clean:	
	rm -f *~ graphics_inside.inc priority_inside.inc *.zx02 *.gr *.hgr

