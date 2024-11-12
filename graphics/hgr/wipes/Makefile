include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk
ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	wipes.dsk

wipes.dsk:	HELLO bubbles/WIPE_BUBBLES
	cp $(EMPTY_DISK)/empty.dsk wipes.dsk
	$(DOS33) -y wipes.dsk SAVE A HELLO
	$(DOS33) -y wipes.dsk BSAVE -a 0x5700 bubbles/WIPE_BUBBLES

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

bubbles/WIPE_BUBBLES:	
	cd bubbles && make

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO
	cd bubbles && make clean

