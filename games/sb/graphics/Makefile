include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	strongbad_sample.hgr.zx02

####

strongbad_sample.hgr.zx02:	strongbad_sample.hgr
	$(ZX02) strongbad_sample.hgr strongbad_sample.hgr.zx02

strongbad_sample.hgr:	strongbad_sample.png
	$(PNG_TO_HGR) strongbad_sample.png > strongbad_sample.hgr

####

clean:
	rm -f *~ *.o *.lst

