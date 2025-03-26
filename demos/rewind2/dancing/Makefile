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

aha.main:	aha001.main aha002.main aha003.main aha004.main \
		aha005.main aha006.main aha007.main aha008.main \
		aha009.main aha010.main aha011.main aha012.main \
		aha013.main aha014.main aha015.main aha016.main \
		aha017.main aha018.main aha019.main aha020.main \
		aha021.main aha022.main aha023.main aha024.main
	cat aha001.main aha002.main aha003.main aha004.main \
		aha005.main aha006.main aha007.main aha008.main \
		aha009.main aha010.main aha011.main aha012.main \
		aha013.main aha014.main aha015.main aha016.main \
		aha017.main aha018.main aha019.main aha020.main \
		aha021.main aha022.main aha023.main aha024.main > aha.main

aha.main.zx02: aha.main
	$(ZX02) aha.main aha.main.zx02

###

aha.aux:	aha001.aux aha002.aux aha003.aux aha004.aux \
		aha005.aux aha006.aux aha007.aux aha008.aux \
		aha009.aux aha010.aux aha011.aux aha012.aux \
		aha013.aux aha014.aux aha015.aux aha016.aux \
		aha017.aux aha018.aux aha019.aux aha020.aux \
		aha021.aux aha022.aux aha023.aux aha024.aux
	cat aha001.aux aha002.aux aha003.aux aha004.aux \
		aha005.aux aha006.aux aha007.aux aha008.aux \
		aha009.aux aha010.aux aha011.aux aha012.aux \
		aha013.aux aha014.aux aha015.aux aha016.aux \
		aha017.aux aha018.aux aha019.aux aha020.aux \
		aha021.aux aha022.aux aha023.aux aha024.aux > aha.aux

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

aha005.aux:  aha005.png
	$(PNG_TO_DGR) aha005.png aha005

aha006.aux:  aha006.png
	$(PNG_TO_DGR) aha006.png aha006

aha007.aux:  aha007.png
	$(PNG_TO_DGR) aha007.png aha007

aha008.aux:  aha008.png
	$(PNG_TO_DGR) aha008.png aha008

aha009.aux:  aha009.png
	$(PNG_TO_DGR) aha009.png aha009

aha010.aux:  aha010.png
	$(PNG_TO_DGR) aha010.png aha010

aha011.aux:  aha011.png
	$(PNG_TO_DGR) aha011.png aha011

aha012.aux:  aha012.png
	$(PNG_TO_DGR) aha012.png aha012

aha013.aux:  aha013.png
	$(PNG_TO_DGR) aha013.png aha013

aha014.aux:  aha014.png
	$(PNG_TO_DGR) aha014.png aha014

aha015.aux:  aha015.png
	$(PNG_TO_DGR) aha015.png aha015

aha016.aux:  aha016.png
	$(PNG_TO_DGR) aha016.png aha016

aha017.aux:  aha017.png
	$(PNG_TO_DGR) aha017.png aha017

aha018.aux:  aha018.png
	$(PNG_TO_DGR) aha018.png aha018

aha019.aux:  aha019.png
	$(PNG_TO_DGR) aha019.png aha019

aha020.aux:  aha020.png
	$(PNG_TO_DGR) aha020.png aha020

aha021.aux:  aha021.png
	$(PNG_TO_DGR) aha021.png aha021

aha022.aux:  aha022.png
	$(PNG_TO_DGR) aha022.png aha022

aha023.aux:  aha023.png
	$(PNG_TO_DGR) aha023.png aha023

aha024.aux:  aha024.png
	$(PNG_TO_DGR) aha024.png aha024


#####

aha001.main: aha001.png
	$(PNG_TO_DGR) aha001.png aha001

aha002.main: aha002.png
	$(PNG_TO_DGR) aha002.png aha002

aha003.main: aha003.png
	$(PNG_TO_DGR) aha003.png aha003

aha004.main: aha004.png
	$(PNG_TO_DGR) aha004.png aha004

aha005.main: aha005.png
	$(PNG_TO_DGR) aha005.png aha005

aha006.main: aha006.png
	$(PNG_TO_DGR) aha006.png aha006

aha007.main: aha007.png
	$(PNG_TO_DGR) aha007.png aha007

aha008.main: aha008.png
	$(PNG_TO_DGR) aha008.png aha008

aha009.main: aha009.png
	$(PNG_TO_DGR) aha009.png aha009

aha010.main: aha010.png
	$(PNG_TO_DGR) aha010.png aha010

aha011.main: aha011.png
	$(PNG_TO_DGR) aha011.png aha011

aha012.main: aha012.png
	$(PNG_TO_DGR) aha012.png aha012

aha013.main: aha013.png
	$(PNG_TO_DGR) aha013.png aha013

aha014.main: aha014.png
	$(PNG_TO_DGR) aha014.png aha014

aha015.main: aha015.png
	$(PNG_TO_DGR) aha015.png aha015

aha016.main: aha016.png
	$(PNG_TO_DGR) aha016.png aha016

aha017.main: aha017.png
	$(PNG_TO_DGR) aha017.png aha017

aha018.main: aha018.png
	$(PNG_TO_DGR) aha018.png aha018

aha019.main: aha019.png
	$(PNG_TO_DGR) aha019.png aha019

aha020.main: aha020.png
	$(PNG_TO_DGR) aha020.png aha020

aha021.main: aha021.png
	$(PNG_TO_DGR) aha021.png aha021

aha022.main: aha022.png
	$(PNG_TO_DGR) aha022.png aha022

aha023.main: aha023.png
	$(PNG_TO_DGR) aha023.png aha023

aha024.main: aha024.png
	$(PNG_TO_DGR) aha024.png aha024

####

clean:
	rm -f *~ DANCING *.zx02 aha.aux aha.main
