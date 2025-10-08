include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_REDLINES

###

WIPE_REDLINES:	wipe_redlines.o
	ld65 -o WIPE_REDLINES wipe_redlines.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_redlines.o:	wipe_redlines.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	fx.dhgr.redlines.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_redlines.o wipe_redlines.s -l wipe_redlines.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_REDLINES

