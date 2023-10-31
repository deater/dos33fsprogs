include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	cube_mask1.gr.zx02 cube_mask2.gr.zx02 \
	cube_mask3.gr.zx02 cube_mask4.gr.zx02 \
	cube2_mask1.gr.zx02 cube2_mask2.gr.zx02 \
	cube2_mask3.gr.zx02 cube2_mask4.gr.zx02 \
	cube2_mask5.gr.zx02 cube2_mask6.gr.zx02 \
	cube2_mask7.gr.zx02 cube2_mask8.gr.zx02

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

cube2_mask1.gr.zx02:	cube2_mask1.gr
	$(ZX02) cube2_mask1.gr cube2_mask1.gr.zx02

cube2_mask1.gr:	cube2_mask1.png
	$(PNG2GR) cube2_mask1.png cube2_mask1.gr

####

cube2_mask2.gr.zx02:	cube2_mask2.gr
	$(ZX02) cube2_mask2.gr cube2_mask2.gr.zx02

cube2_mask2.gr:	cube2_mask2.png
	$(PNG2GR) cube2_mask2.png cube2_mask2.gr

####

cube2_mask3.gr.zx02:	cube2_mask3.gr
	$(ZX02) cube2_mask3.gr cube2_mask3.gr.zx02

cube2_mask3.gr:	cube2_mask3.png
	$(PNG2GR) cube2_mask3.png cube2_mask3.gr

####

cube2_mask4.gr.zx02:	cube2_mask4.gr
	$(ZX02) cube2_mask4.gr cube2_mask4.gr.zx02

cube2_mask4.gr:	cube2_mask4.png
	$(PNG2GR) cube2_mask4.png cube2_mask4.gr

####

cube2_mask5.gr.zx02:	cube2_mask5.gr
	$(ZX02) cube2_mask5.gr cube2_mask5.gr.zx02

cube2_mask5.gr:	cube2_mask5.png
	$(PNG2GR) cube2_mask5.png cube2_mask5.gr

####

cube2_mask6.gr.zx02:	cube2_mask6.gr
	$(ZX02) cube2_mask6.gr cube2_mask6.gr.zx02

cube2_mask6.gr:	cube2_mask6.png
	$(PNG2GR) cube2_mask6.png cube2_mask6.gr

####

cube2_mask7.gr.zx02:	cube2_mask7.gr
	$(ZX02) cube2_mask7.gr cube2_mask7.gr.zx02

cube2_mask7.gr:	cube2_mask7.png
	$(PNG2GR) cube2_mask7.png cube2_mask7.gr

####

cube2_mask8.gr.zx02:	cube2_mask8.gr
	$(ZX02) cube2_mask8.gr cube2_mask8.gr.zx02

cube2_mask8.gr:	cube2_mask8.png
	$(PNG2GR) cube2_mask8.png cube2_mask8.gr





####

clean:
	rm -f *~ *.zx02
