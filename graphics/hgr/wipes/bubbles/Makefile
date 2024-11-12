include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_BUBBLES

###

WIPE_BUBBLES:	wipe_bubbles.o
	ld65 -o WIPE_BUBBLES wipe_bubbles.o -C $(LINKER_SCRIPTS)/apple2_5700.inc

wipe_bubbles.o:	wipe_bubbles.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	code.hgr.precomputed.1bit.s \
	../main_macros.s \
	fx.hgr.bubbles.s \
	fx.hgr.precomputed.1bit.s \
	fx.hgr.bubbles.data \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_bubbles.o wipe_bubbles.s -l wipe_bubbles.lst

###

bubbles_data.zx02:	fx.hgr.bubbles.data
	$(ZX02) fx.hgr.bubbles.data bubbles_data.zx02

fx.hgr.bubbles.data:	fx.hgr.bubbles.data.o
	ld65 -o fx.hgr.bubbles.data fx.hgr.bubbles.data.o -C $(LINKER_SCRIPTS)/apple2_8800.inc

fx.hgr.bubbles.data.o:	fx.hgr.bubbles.data.s
	ca65 -o fx.hgr.bubbles.data.o fx.hgr.bubbles.data.s -l fx.hgr.bubbles.data.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_TEST

