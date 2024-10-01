include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts

all:	DATING_XR

####

DATING_XR:	dating_xr.o
	ld65 -o DATING_XR dating_xr.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

dating_xr.o:	dating_xr.s zx02_optim.s \
		graphics/a2_dating.hgr.zx02 \
		audio.s \
		zp.inc hardware.inc
	ca65 -o dating_xr.o dating_xr.s -l dating_xr.lst




#graphics/sb_sprites.inc:	
#	cd fish_graphics && make

#graphics/sb_title.hgr.zx02:	
#	cd fish_graphics && make

#sound/fish.btc.zx02:	
#	cd fish_sound && make

clean:	
	rm -f *.lst *.o *~ DATING_XR

