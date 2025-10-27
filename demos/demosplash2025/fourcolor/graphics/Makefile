include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DHGR = ../../../../utils/hgr-utils/png2dhgr
PNG_TO_DHGR4 = ../../../../utils/hgr-utils/png2dhgr4
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	grimnir11_grey.packed.zx02

####

grimnir11_grey.packed.zx02:     grimnir11_grey.packed
	$(ZX02) grimnir11_grey.packed grimnir11_grey.packed.zx02

grimnir11_grey.packed:  grimnir11_grey.png
	$(PNG_TO_DHGR4) grimnir11_grey.png grimnir11_grey

####

clean:
	rm -f *~ *.zx02 *.lst *.o *.packed
