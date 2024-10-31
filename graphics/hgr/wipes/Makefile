include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk
ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	wipes.dsk

wipes.dsk:	HELLO WIPE_TEST
	cp $(EMPTY_DISK)/empty.dsk wipes.dsk
	$(DOS33) -y wipes.dsk SAVE A HELLO
	$(DOS33) -y wipes.dsk BSAVE -a 0x5700 WIPE_TEST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

WIPE_TEST:	wipe_test.o
	ld65 -o WIPE_TEST wipe_test.o -C $(LINKER_SCRIPTS)/apple2_5700.inc

wipe_test.o:	wipe_test.s \
	zp.inc hardware.inc wait_keypress.s zx02_optim.s \
	code.hgr.precomputed.1bit.s \
	main_macros.s \
	fx.hgr.bubbles.s \
	fx.hgr.precomputed.1bit.s \
	fx.hgr.bubbles.data \
	fx.lib.s \
	macros.s
	ca65 -o wipe_test.o wipe_test.s -l wipe_test.lst

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

