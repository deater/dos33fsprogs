include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	\
	sworg_hgr.hgr.zx02
	

####

sworg_hgr.hgr.zx02:	sworg_hgr.hgr
	$(ZX02) sworg_hgr.hgr sworg_hgr.hgr.zx02

sworg_hgr.hgr:	sworg_hgr.png
	$(PNG_TO_HGR) sworg_hgr.png > sworg_hgr.hgr


####

clean:	
	rm -f *~ *.o *.lst
