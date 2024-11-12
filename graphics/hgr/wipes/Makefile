include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk
ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	wipes.dsk

wipes.dsk:	HELLO \
	bubbles/WIPE_BUBBLES \
	diamond/WIPE_DIAMOND \
	diamond_stripes/WIPE_DIAMOND_STRIPE \
	crystal/WIPE_CRYSTAL \
	fizzle/WIPE_FIZZLE \
	lr/WIPE_LR \
	cascade/WIPE_CASCADE
	cp $(EMPTY_DISK)/empty.dsk wipes.dsk
	$(DOS33) -y wipes.dsk SAVE A HELLO
	$(DOS33) -y wipes.dsk BSAVE -a 0x5700 bubbles/WIPE_BUBBLES
	$(DOS33) -y wipes.dsk BSAVE -a 0x6000 diamond/WIPE_DIAMOND
	$(DOS33) -y wipes.dsk BSAVE -a 0x6000 diamond_stripes/WIPE_DIAMOND_STRIPE
	$(DOS33) -y wipes.dsk BSAVE -a 0x6000 crystal/WIPE_CRYSTAL
	$(DOS33) -y wipes.dsk BSAVE -a 0x6000 fizzle/WIPE_FIZZLE
	$(DOS33) -y wipes.dsk BSAVE -a 0x6000 lr/WIPE_LR
	$(DOS33) -y wipes.dsk BSAVE -a 0x6000 cascade/WIPE_CASCADE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

bubbles/WIPE_BUBBLES:	
	cd bubbles && make

cascade/WIPE_CASCADE:	
	cd cascade && make

crystal/WIPE_CRYSTAL:	
	cd crystal && make

diamond/WIPE_DIAMOND:	
	cd diamond && make

diamond_stripes/WIPE_DIAMOND_STRIPE:	
	cd diamond_stripes && make

fizzle/WIPE_FIZZLE:	
	cd fizzle && make

lr/WIPE_LR:	
	cd lr && make

###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO
	cd bubbles && make clean
	cd cascade && make clean
	cd diamond && make clean
	cd diamond_stripes && make clean
	cd crystal && make clean
	cd fizzle && make clean
	cd lr && make clean
