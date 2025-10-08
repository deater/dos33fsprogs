include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_FIZZLE

###

WIPE_FIZZLE:	wipe_fizzle.o
	ld65 -o WIPE_FIZZLE wipe_fizzle.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_fizzle.o:	wipe_fizzle.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	fx.dhgr.fizzle.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_fizzle.o wipe_fizzle.s -l wipe_fizzle.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_FIZZLE

