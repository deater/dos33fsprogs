include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG2GR = ../../../../utils/gr-utils/png2gr

all:	dsr_big.gr.zx02


####

dsr_big.gr:	dsr_big.png
	$(PNG2GR) dsr_big.png dsr_big.gr

dsr_big.gr.zx02:	dsr_big.gr
	$(ZX02) dsr_big.gr dsr_big.gr.zx02

####

clean:
	rm -f *~
