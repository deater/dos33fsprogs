include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	INTRO

####

INTRO.ZX02:	INTRO
	$(ZX02) -f INTRO INTRO.ZX02

####

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

intro.o:	intro.s \
	../zx02_optim.s \
	../zp.inc ../hardware.inc ../qload.inc ../common_defines.inc \
	erase.s \
	../part01_dni/dni_plasma.s \
	graphics/logo_frame01.hgr.zx02 \
	graphics/logo_frame46.hgr.zx02 \
	graphics/d_sprites.inc
	ca65 -o intro.o intro.s -l intro.lst

###

graphics/logo_frame01.hgr.zx02:	
	cd graphics && make

graphics/d_sprites.inc:	
	cd graphics && make

###


clean:
	rm -f *~ *.o *.lst INTRO
	cd graphics && make clean
