include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_48_ALL WIPE_48_SPIRAL DS_TEST

###

WIPE_48_SPIRAL:	wipe_48_spiral.o
	ld65 -o WIPE_48_SPIRAL wipe_48_spiral.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_48_spiral.o:	wipe_48_spiral.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	fx.dhgr.48boxes.spiral.s \
	code.dhgr.48boxes.s \
	../main_macros.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_48_spiral.o wipe_48_spiral.s -l wipe_48_spiral.lst

###

WIPE_48_ALL:	wipe_48_all.o
	ld65 -o WIPE_48_ALL wipe_48_all.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_48_all.o:	wipe_48_all.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_48_all.o wipe_48_all.s -l wipe_48_all.lst

###

DS_TEST:	ds_test.o
	ld65 -o DS_TEST ds_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

ds_test.o:	ds_test.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	../fx.lib.s \
	../macros.s
	ca65 -o ds_test.o ds_test.s -l ds_test.lst



###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_48_SPIRAL WIPE_48_ALL DS_TEST


