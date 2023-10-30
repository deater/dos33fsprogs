include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	cube_mask1.gr.zx02 cube_mask2.gr.zx02 \
	cube_mask3.gr.zx02 cube_mask4.gr.zx02

####

cube_mask1.gr.zx02:	cube_mask1.gr
	$(ZX02) cube_mask1.gr cube_mask1.gr.zx02

cube_mask1.gr:	cube_mask1.png
	$(PNG2GR) cube_mask1.png cube_mask1.gr

####

cube_mask2.gr.zx02:	cube_mask2.gr
	$(ZX02) cube_mask2.gr cube_mask2.gr.zx02

cube_mask2.gr:	cube_mask2.png
	$(PNG2GR) cube_mask2.png cube_mask2.gr

####

cube_mask3.gr.zx02:	cube_mask3.gr
	$(ZX02) cube_mask3.gr cube_mask3.gr.zx02

cube_mask3.gr:	cube_mask3.png
	$(PNG2GR) cube_mask3.png cube_mask3.gr

####

cube_mask4.gr.zx02:	cube_mask4.gr
	$(ZX02) cube_mask4.gr cube_mask4.gr.zx02

cube_mask4.gr:	cube_mask4.png
	$(PNG2GR) cube_mask4.png cube_mask4.gr



####

clean:
	rm -f *~
