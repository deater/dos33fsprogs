include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_CENTER

###

WIPE_CENTER:	wipe_center.o
	ld65 -o WIPE_CENTER wipe_center.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_center.o:	wipe_center.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	fx.hgr.center.by.pixel.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_center.o wipe_center.s -l wipe_center.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_CENTER

