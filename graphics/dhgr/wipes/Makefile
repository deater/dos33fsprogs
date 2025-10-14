include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk
ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	dhgr_wipes.dsk

dhgr_wipes.dsk:	HELLO \
	fizzle/WIPE_FIZZLE \
	maple/WIPE_MAPLE \
	pumpkin/WIPE_PUMPKIN \
	star/WIPE_STAR \
	redlines/WIPE_REDLINES \
	forty-eight/WIPE_48_SPIRAL \
	forty-eight/WIPE_48_ALL 
	cp $(EMPTY_DISK)/empty.dsk dhgr_wipes.dsk
	$(DOS33) -y dhgr_wipes.dsk SAVE A HELLO
	$(DOS33) -y dhgr_wipes.dsk BSAVE -a 0x6000 fizzle/WIPE_FIZZLE
	$(DOS33) -y dhgr_wipes.dsk BSAVE -a 0x1000 maple/WIPE_MAPLE
	$(DOS33) -y dhgr_wipes.dsk BSAVE -a 0x1000 pumpkin/WIPE_PUMPKIN
	$(DOS33) -y dhgr_wipes.dsk BSAVE -a 0x1000 star/WIPE_STAR
	$(DOS33) -y dhgr_wipes.dsk BSAVE -a 0x6000 redlines/WIPE_REDLINES
	$(DOS33) -y dhgr_wipes.dsk BSAVE -a 0x6000 forty-eight/WIPE_48_SPIRAL
	$(DOS33) -y dhgr_wipes.dsk BSAVE -a 0x6000 forty-eight/WIPE_48_ALL

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

fizzle/WIPE_FIZZLE:	
	cd fizzle && make

forty-eight/WIPE_48_ALL:	
	cd forty-eight && make

forty-eight/WIPE_48_SPIRAL:	
	cd forty-eight && make

maple/WIPE_MAPLE:	
	cd maple && make

pumpkin/WIPE_PUMPKIN:	
	cd pumpkin && make

redlines/WIPE_REDLINES:	
	cd redlines && make

star/WIPE_STAR:	
	cd star && make



###

clean:	
	rm -f *~ *.o *.lst *.zx02 HELLO
	cd fizzle && make clean
	cd forty-eight && make clean
	cd maple && make clean
	cd pumpkin && make clean
	cd redlines && make clean
	cd star && make clean

