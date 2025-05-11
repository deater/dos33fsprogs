include ../../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../../utils/hgr-utils/png2hgr
PNG_TO_DGR = ../../../../utils/gr-utils/png2dgr
PNG2GR = ../../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	ROAD

###

ROAD:	road.o
	ld65 -o ROAD road.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

road.o:	road.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	../grongy/road000.zx02 \
	../grongy/road001.zx02 \
	../grongy/road002.zx02 \
	../grongy/road003.zx02
	ca65 -o road.o road.s -l road.lst

###


clean:
	rm -f *~ *.o *.lst ROAD *.zx02 *.aux *.main
