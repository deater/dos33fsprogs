include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_THIN_BAR

###

WIPE_THIN_BAR:	wipe_thin_bar.o
	ld65 -o WIPE_THIN_BAR wipe_thin_bar.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_thin_bar.o:	wipe_thin_bar.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	fx.hgr.thin.bar.dissolve.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_thin_bar.o wipe_thin_bar.s -l wipe_thin_bar.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_THIN_BAR

