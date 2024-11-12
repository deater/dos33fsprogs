include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_DIAMOND_STRIPE

###

WIPE_DIAMOND_STRIPE:	wipe_diamond_stripe.o
	ld65 -o WIPE_DIAMOND_STRIPE wipe_diamond_stripe.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_diamond_stripe.o:	wipe_diamond_stripe.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	fx.hgr.diamond.stripes.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_diamond_stripe.o wipe_diamond_stripe.s -l wipe_diamond_stripe.lst

###

diamond_data.zx02:	fx.hgr.diamond.data
	$(ZX02) fx.hgr.diamond.data diamond_data.zx02

fx.hgr.diamond.data:	fx.hgr.diamond.data.o
	ld65 -o fx.hgr.diamond.data fx.hgr.diamond.data.o -C $(LINKER_SCRIPTS)/apple2_8800.inc

fx.hgr.diamond.data.o:	fx.hgr.diamond.data.s
	ca65 -o fx.hgr.diamond.data.o fx.hgr.diamond.data.s -l fx.hgr.diamond.data.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_DIAMOND_STRIPE

