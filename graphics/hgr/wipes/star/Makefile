include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	WIPE_STAR WIPE_STAR_BLOOM WIPE_STAR_IN

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

WIPE_STAR_BLOOM:	wipe_star_bloom.o
	ld65 -o WIPE_STAR_BLOOM wipe_star_bloom.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

wipe_star_bloom.o:	wipe_star_bloom.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	code.hgr.precomputed.2bit.s \
	../main_macros.s \
	fx.hgr.star.s \
	fx.hgr.precomputed.2bit.s \
	fx.hgr.star_bloom.data \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_star_bloom.o wipe_star_bloom.s -l wipe_star_bloom.lst

###

WIPE_STAR_IN:	wipe_star_in.o
	ld65 -o WIPE_STAR_IN wipe_star_in.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

wipe_star_in.o:	wipe_star_in.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	code.hgr.precomputed.2bit.s \
	../main_macros.s \
	fx.hgr.star.in.s \
	fx.hgr.precomputed.2bit.s \
	fx.hgr.star.data \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_star_in.o wipe_star_in.s -l wipe_star_in.lst


###

star_data.zx02:	fx.hgr.star.data
	$(ZX02) fx.hgr.star.data star_data.zx02
###

fx.hgr.star.data:	fx.hgr.star.data.o
	ld65 -o fx.hgr.star.data fx.hgr.star.data.o -C $(LINKER_SCRIPTS)/apple2_8100.inc

fx.hgr.star.data.o:	fx.hgr.star.data.s
	ca65 -o fx.hgr.star.data.o fx.hgr.star.data.s -l fx.hgr.star.data.lst

###

fx.hgr.star_bloom.data:	fx.hgr.star_bloom.data.o
	ld65 -o fx.hgr.star_bloom.data fx.hgr.star_bloom.data.o -C $(LINKER_SCRIPTS)/apple2_8100.inc

fx.hgr.star_bloom.data.o:	fx.hgr.star.bloom.data.s
	ca65 -o fx.hgr.star_bloom.data.o fx.hgr.star.bloom.data.s -l fx.hgr.star_bloom.data.lst


###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO \
		WIPE_STAR WIPE_STAR_BLOOM WIPE_STAR_IN \
		fx.hgr.star.data fx.hgr.star_bloom.data

