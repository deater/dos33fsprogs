include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	dsr_big.gr.zx02 dsr_big2.gr.zx02 dsr_small.gr.zx02 dsr_empty.gr.zx02


####

dsr_big.gr:	dsr_big.png
	$(PNG2GR) dsr_big.png dsr_big.gr

dsr_big.gr.zx02:	dsr_big.gr
	$(ZX02) dsr_big.gr dsr_big.gr.zx02

####

dsr_small.gr:	dsr_small.png
	$(PNG2GR) dsr_small.png dsr_small.gr

dsr_small.gr.zx02:	dsr_small.gr
	$(ZX02) dsr_small.gr dsr_small.gr.zx02


####

dsr_big2.gr:	dsr_big2.png
	$(PNG2GR) dsr_big2.png dsr_big2.gr

dsr_big2.gr.zx02:	dsr_big2.gr
	$(ZX02) dsr_big2.gr dsr_big2.gr.zx02

####

dsr_empty.gr:	dsr_empty.png
	$(PNG2GR) dsr_empty.png dsr_empty.gr

dsr_empty.gr.zx02:	dsr_empty.gr
	$(ZX02) dsr_empty.gr dsr_empty.gr.zx02



####

clean:
	rm -f *~
