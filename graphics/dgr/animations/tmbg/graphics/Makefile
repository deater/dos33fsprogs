include ../../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_DGR = ../../../../../utils/gr-utils/png2dgr
LINKER_SCRIPTS = ../../../../../linker_scripts/
PNG_TO_DGR_DIFF = ../../../../../utils/gr-utils/png2dgr_diff

all:	\
	tmbg01.aux.zx02 tmbg01.main.zx02 \
	tmbg02.aux.zx02 tmbg02.main.zx02 \
	frame1_frame3_diff.inc frame3_frame5_diff.inc \
	frame5_frame2_diff.inc frame2_frame4_diff.inc \
	frame4_frame1_diff.inc


####

frame1_frame3_diff.inc:	tmbg01.png tmbg03.png
	$(PNG_TO_DGR_DIFF) tmbg01.png tmbg03.png f13 > frame1_frame3_diff.inc

frame3_frame5_diff.inc:	tmbg03.png tmbg05.png
	$(PNG_TO_DGR_DIFF) tmbg03.png tmbg05.png f35 > frame3_frame5_diff.inc

frame5_frame2_diff.inc:	tmbg05.png tmbg02.png
	$(PNG_TO_DGR_DIFF) tmbg05.png tmbg02.png f52 > frame5_frame2_diff.inc

frame2_frame4_diff.inc:	tmbg02.png tmbg04.png
	$(PNG_TO_DGR_DIFF) tmbg02.png tmbg04.png f24 > frame2_frame4_diff.inc

frame4_frame1_diff.inc:	tmbg04.png tmbg01.png
	$(PNG_TO_DGR_DIFF) tmbg04.png tmbg01.png f41 > frame4_frame1_diff.inc

####

tmbg01.aux.zx02:	tmbg01.aux
	$(ZX02) tmbg01.aux tmbg01.aux.zx02

tmbg01.main.zx02:	tmbg01.main
	$(ZX02) tmbg01.main tmbg01.main.zx02

tmbg01.aux:  tmbg01.png
	$(PNG_TO_DGR) tmbg01.png tmbg01

####

tmbg02.aux.zx02:	tmbg02.aux
	$(ZX02) tmbg02.aux tmbg02.aux.zx02

tmbg02.main.zx02:	tmbg02.main
	$(ZX02) tmbg02.main tmbg02.main.zx02

tmbg02.aux:  tmbg02.png
	$(PNG_TO_DGR) tmbg02.png tmbg02

####

clean:
	rm -f *~ *.zx02 *.lst *.o *.main *.aux *_diff.inc

