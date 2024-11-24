include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	sundae.dsk

####

sundae.dsk:	HELLO SUNDAE
	cp $(EMPTY_DISK) sundae.dsk
	$(DOS33) -y sundae.dsk SAVE A HELLO
	$(DOS33) -y sundae.dsk BSAVE -a 0x2000 SUNDAE

###

SUNDAE:	sundae.o
	ld65 -o SUNDAE sundae.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

sundae.o:	sundae.s ../zx02_optim.s \
		../zp.inc ../hardware.inc
	ca65 -o sundae.o sundae.s -l sundae.lst

duck_graphics/duck_sprites.inc:	
	cd duck_graphics && make


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
	rm -f *.lst *.o HELLO SUNDAE

