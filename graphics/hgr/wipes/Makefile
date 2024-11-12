include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk
ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	wipes.dsk

wipes.dsk:	HELLO bubbles/WIPE_BUBBLES diamond/WIPE_DIAMOND
	cp $(EMPTY_DISK)/empty.dsk wipes.dsk
	$(DOS33) -y wipes.dsk SAVE A HELLO
	$(DOS33) -y wipes.dsk BSAVE -a 0x5700 bubbles/WIPE_BUBBLES
	$(DOS33) -y wipes.dsk BSAVE -a 0x6000 diamond/WIPE_DIAMOND

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

bubbles/WIPE_BUBBLES:	
	cd bubbles && make

diamond/WIPE_DIAMOND:	
	cd diamond && make

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO
	cd bubbles && make clean
	cd diamond && make clean

