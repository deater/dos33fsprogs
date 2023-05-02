include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../utils/gr-utils/png2sprites

all:	a2_fortnight.hgr.zx02 \
	a2_fortnight_rat1.hgr.zx02 \
	a2_fortnight_rat2.hgr.zx02


####

a2_fortnight.hgr.zx02:	a2_fortnight.hgr
	$(ZX02) a2_fortnight.hgr a2_fortnight.hgr.zx02

a2_fortnight.hgr:	a2_fortnight.png
	$(PNG_TO_HGR) a2_fortnight.png > a2_fortnight.hgr

####

a2_fortnight_rat1.hgr.zx02:	a2_fortnight_rat1.hgr
	$(ZX02) a2_fortnight_rat1.hgr a2_fortnight_rat1.hgr.zx02

a2_fortnight_rat1.hgr:	a2_fortnight_rat1.png
	$(PNG_TO_HGR) a2_fortnight_rat1.png > a2_fortnight_rat1.hgr

####

a2_fortnight_rat2.hgr.zx02:	a2_fortnight_rat2.hgr
	$(ZX02) a2_fortnight_rat2.hgr a2_fortnight_rat2.hgr.zx02

a2_fortnight_rat2.hgr:	a2_fortnight_rat2.png
	$(PNG_TO_HGR) a2_fortnight_rat2.png > a2_fortnight_rat2.hgr


####

clean:
	rm -f *~ *.o *.lst

