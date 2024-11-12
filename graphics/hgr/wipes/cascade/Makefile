include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_CASCADE

###

WIPE_CASCADE:	wipe_cascade.o
	ld65 -o WIPE_CASCADE wipe_cascade.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_cascade.o:	wipe_cascade.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	fx.hgr.cascade.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_cascade.o wipe_cascade.s -l wipe_cascade.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_CASCADE

