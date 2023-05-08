include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../utils/hgr-utils/png2dhgr
PNG_TO_DGR = ../../../utils/gr-utils/png2dgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	\
	sworg_hgr.hgr.zx02 \
	sworg_dhgr.bin.zx02 \
	sworg_dhgr.aux.zx02 \
	sworg_dgr.main.zx02 \
	sworg_dgr.aux.zx02

####

sworg_hgr.hgr.zx02:	sworg_hgr.hgr
	$(ZX02) sworg_hgr.hgr sworg_hgr.hgr.zx02

sworg_hgr.hgr:	sworg_hgr.png
	$(PNG_TO_HGR) sworg_hgr.png > sworg_hgr.hgr

####

sworg_dhgr.aux.zx02:	sworg_dhgr.AUX
	$(ZX02) sworg_dhgr.AUX sworg_dhgr.aux.zx02

sworg_dhgr.AUX:	sworg_dhgr.png
	$(PNG_TO_DHGR) sworg_dhgr.png sworg_dhgr

sworg_dhgr.bin.zx02:	sworg_dhgr.BIN
	$(ZX02) sworg_dhgr.BIN sworg_dhgr.bin.zx02

sworg_dhgr.BIN:	sworg_dhgr.png
	$(PNG_TO_DHGR) sworg_dhgr.png sworg_dhgr

####

sworg_dgr.aux.zx02:	sworg_dgr.aux
	$(ZX02) sworg_dgr.aux sworg_dgr.aux.zx02

sworg_dgr.aux:	sworg_dgr.png
	$(PNG_TO_DGR) sworg_dgr.png sworg_dgr

sworg_dgr.main.zx02:	sworg_dgr.main
	$(ZX02) sworg_dgr.main sworg_dgr.main.zx02

sworg_dgr.main:	sworg_dgr.png
	$(PNG_TO_DGR) sworg_dgr.png sworg_dgr



####

clean:	
	rm -f *~ *.o *.lst
