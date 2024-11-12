include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_LR

###

WIPE_LR:	wipe_lr.o
	ld65 -o WIPE_LR wipe_lr.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_lr.o:	wipe_lr.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	fx.hgr.2pass.lr.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_lr.o wipe_lr.s -l wipe_lr.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_LR

