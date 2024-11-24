include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG2GR = ../../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../../utils/gr-utils/png2sprites

all:	a2_sundae_title.gr.zx02 \
	a2_sundae_gameplay.gr.zx02 \
	a2_sundae_james.gr.zx02

####

a2_sundae_title.gr.zx02:	a2_sundae_title.gr
	$(ZX02) a2_sundae_title.gr a2_sundae_title.gr.zx02

a2_sundae_title.gr:	a2_sundae_title.png
	$(PNG2GR) a2_sundae_title.png a2_sundae_title.gr

####

a2_sundae_gameplay.gr.zx02:	a2_sundae_gameplay.gr
	$(ZX02) a2_sundae_gameplay.gr a2_sundae_gameplay.gr.zx02

a2_sundae_gameplay.gr:	a2_sundae_gameplay.png
	$(PNG2GR) a2_sundae_gameplay.png a2_sundae_gameplay.gr

####

a2_sundae_james.gr.zx02:	a2_sundae_james.gr
	$(ZX02) a2_sundae_james.gr a2_sundae_james.gr.zx02

a2_sundae_james.gr:	a2_sundae_james.png
	$(PNG2GR) a2_sundae_james.png a2_sundae_james.gr


####

clean:
	rm -f *~ *.o *.lst *.zx02 *.gr

