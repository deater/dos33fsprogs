include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_48

###

WIPE_48:	wipe_48.o
	ld65 -o WIPE_48 wipe_48.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_48.o:	wipe_48.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_48.o wipe_48.s -l wipe_48.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_48

