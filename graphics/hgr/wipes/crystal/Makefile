include ../../../../Makefile.inc

LINKER_SCRIPTS = ../../../../linker_scripts

all:	WIPE_CRYSTAL

###

WIPE_CRYSTAL:	wipe_crystal.o
	ld65 -o WIPE_CRYSTAL wipe_crystal.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_crystal.o:	wipe_crystal.s \
	../zp.inc ../hardware.inc ../wait_keypress.s ../zx02_optim.s \
	../main_macros.s \
	fx.hgr.crystal.s \
	../fx.lib.s \
	../macros.s
	ca65 -o wipe_crystal.o wipe_crystal.s -l wipe_crystal.lst

###

diamond_data.zx02:	fx.hgr.diamond.data
	$(ZX02) fx.hgr.diamond.data diamond_data.zx02

fx.hgr.diamond.data:	fx.hgr.diamond.data.o
	ld65 -o fx.hgr.diamond.data fx.hgr.diamond.data.o -C $(LINKER_SCRIPTS)/apple2_8800.inc

fx.hgr.diamond.data.o:	fx.hgr.diamond.data.s
	ca65 -o fx.hgr.diamond.data.o fx.hgr.diamond.data.s -l fx.hgr.diamond.data.lst

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO WIPE_CRYSTAL

