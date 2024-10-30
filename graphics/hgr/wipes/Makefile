include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	wipes.dsk

wipes.dsk:	HELLO WIPE_TEST
	cp $(EMPTY_DISK)/empty.dsk wipes.dsk
	$(DOS33) -y wipes.dsk SAVE A HELLO
	$(DOS33) -y wipes.dsk BSAVE -a 0x6000 WIPE_TEST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

WIPE_TEST:	wipe_test.o
	ld65 -o WIPE_TEST wipe_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

wipe_test.o:	wipe_test.s \
	zp.inc hardware.inc wait_keypress.s zx02_optim.s \
	fx.hgr.bubbles.s \
	fx.hgr.precomputed.1bit.s \
	macros.s
	ca65 -o wipe_test.o wipe_test.s -l wipe_test.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO WIPE_TEST

