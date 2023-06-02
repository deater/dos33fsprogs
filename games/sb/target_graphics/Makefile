include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2SPRITES = ../../../utils/gr-utils/png2sprites
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite

all:	target.hgr.zx02

####

target.hgr.zx02:	target.hgr
	$(ZX02) target.hgr target.hgr.zx02

target.hgr:	target.png
	$(PNG_TO_HGR) target.png > target.hgr

####

clean:
	rm -f *~ *.o *.lst

