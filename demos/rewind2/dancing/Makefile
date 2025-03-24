include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
PNG_TO_DGR = ../../../utils/gr-utils/png2dgr
PNG2GR = ../../../utils/gr-utils/png2gr
HGR_SPRITE = ../../../utils/hgr-utils/hgr_make_sprite
LINKER_SCRIPTS = ../../../linker_scripts/

all:	DANCING

###

DANCING:	dancing.o
	ld65 -o DANCING dancing.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

dancing.o:	dancing.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	aha001.main.zx02 aha001.aux.zx02
	ca65 -o dancing.o dancing.s -l dancing.lst

####

aha001.aux.zx02:     aha001.aux
	$(ZX02) aha001.aux aha001.aux.zx02

aha001.aux:  aha001.png
	$(PNG_TO_DGR) aha001.png aha001

aha001.main.zx02:     aha001.main
	$(ZX02) aha001.main aha001.main.zx02

aha001.main: aha001.png
	$(PNG_TO_DGR) aha001.png aha001


####

clean:
	rm -f *~ DANCING *.zx02
