include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	WIPE_STAR

###

WIPE_STAR:	wipe_star.o
	ld65 -o WIPE_STAR wipe_star.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

wipe_star.o:	wipe_star.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	code.hgr.precomputed.2bit.s \
	../main_macros.s \
	fx.hgr.star.s \
	fx.hgr.precomputed.2bit.s \
	fx.hgr.star.data \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_star.o wipe_star.s -l wipe_star.lst

###

star_data.zx02:	fx.hgr.star.data
	$(ZX02) fx.hgr.star.data star_data.zx02

fx.hgr.star.data:	fx.hgr.star.data.o
	ld65 -o fx.hgr.star.data fx.hgr.star.data.o -C $(LINKER_SCRIPTS)/apple2_8100.inc

fx.hgr.star.data.o:	fx.hgr.star.data.s
	ca65 -o fx.hgr.star.data.o fx.hgr.star.data.s -l fx.hgr.star.data.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_STAR fx.hgr.star.data

