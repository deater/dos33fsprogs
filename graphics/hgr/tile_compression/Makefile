include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	tile_compress.dsk

####

####

tile_compress.dsk:	HELLO \
		SATURN_ZX02 \
		SATURN_TILES
	cp $(EMPTY_DISK) tile_compress.dsk
	$(DOS33) -y tile_compress.dsk SAVE A HELLO
	$(DOS33) -y tile_compress.dsk BSAVE -a 0x6000 SATURN_ZX02
	$(DOS33) -y tile_compress.dsk BSAVE -a 0x6000 SATURN_TILES

####

SATURN_ZX02:	saturn_zx02.o
	ld65 -o SATURN_ZX02 saturn_zx02.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

saturn_zx02.o:	saturn_zx02.s zx02_optim.s \
		zp.inc hardware.inc \
		graphics/a2_saturn_warrior.hgr.zx02
	ca65 -o saturn_zx02.o saturn_zx02.s -l saturn_zx02.lst

####

SATURN_TILES:	saturn_tiles.o
	ld65 -o SATURN_TILES saturn_tiles.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

saturn_tiles.o:	saturn_tiles.s \
		zp.inc hardware.inc \
		graphics/saturn_tiles.inc
	ca65 -o saturn_tiles.o saturn_tiles.s -l saturn_tiles.lst


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:
	rm -f *~ *.o *.lst *.hgr *.zx02 HELLO SATURN_ZX02
