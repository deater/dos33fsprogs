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
	ld65 -o DANCING dancing.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

dancing.o:	dancing.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	aha.main.zx02 aha.aux.zx02
	ca65 -o dancing.o dancing.s -l dancing.lst

###

aha.main:	aha001.main aha002.main aha003.main aha004.main
	cat aha001.main aha002.main aha003.main aha004.main > aha.main

aha.main.zx02: aha.main
	$(ZX02) aha.main aha.main.zx02

###

aha.aux:	aha001.aux aha002.aux aha003.aux aha004.aux
	cat aha001.aux aha002.aux aha003.aux aha004.aux > aha.aux

aha.aux.zx02: aha.aux
	$(ZX02) aha.aux aha.aux.zx02

###

aha001.aux:  aha001.png
	$(PNG_TO_DGR) aha001.png aha001

aha002.aux:  aha002.png
	$(PNG_TO_DGR) aha002.png aha002

aha003.aux:  aha003.png
	$(PNG_TO_DGR) aha003.png aha003

aha004.aux:  aha004.png
	$(PNG_TO_DGR) aha004.png aha004

#####

aha001.main: aha001.png
	$(PNG_TO_DGR) aha001.png aha001

aha002.main: aha002.png
	$(PNG_TO_DGR) aha002.png aha002

aha003.main: aha003.png
	$(PNG_TO_DGR) aha003.png aha003

aha004.main: aha004.png
	$(PNG_TO_DGR) aha004.png aha004

####

clean:
	rm -f *~ DANCING *.zx02
