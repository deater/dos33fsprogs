include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../..utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	cliff.dsk

####

cliff.dsk:	HELLO CLIFF
	cp $(EMPTY_DISK) cliff.dsk
	$(DOS33) -y cliff.dsk SAVE A HELLO
	$(DOS33) -y cliff.dsk BSAVE -a 0x6000 CLIFF

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

CLIFF:	cliff.o
	ld65 -o CLIFF cliff.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

cliff.o:	cliff.s zx02_optim.s \
		hgr_copy.s hgr_partial_save.s \
		hgr_sprite.s \
		cliff_graphics/cliff_base.hgr.zx02 \
		sprites/enemy_sprites.inc \
		zp.inc hardware.inc
	ca65 -o cliff.o cliff.s -l cliff.lst

####

cliff_graphics/cliff_base.hgr.zx02:	
	cd cliff_graphics && make

sprites/enemy_sprites.inc:	
	cd sprites && make


####

clean:	
	rm -f *.lst *.o CLIFF HELLO
	cd cliff_graphics && make clean
	cd sprites && make clean
