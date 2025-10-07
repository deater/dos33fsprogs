include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk
ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	dhgr_wipes.dsk

dhgr_wipes.dsk:	HELLO \
	fizzle/WIPE_FIZZLE
	cp $(EMPTY_DISK)/empty.dsk dhgr_wipes.dsk
	$(DOS33) -y dhgr_wipes.dsk SAVE A HELLO
	$(DOS33) -y dhgr_wipes.dsk BSAVE -a 0x6000 fizzle/WIPE_FIZZLE
###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

fizzle/WIPE_FIZZLE:	
	cd fizzle && make


###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO
	cd fizzle && make clean

