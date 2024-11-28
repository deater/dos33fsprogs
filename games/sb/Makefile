include ../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	sb.dsk

####

sb.dsk:	QBOOT QLOAD ./title/TITLE \
	./duck_pond/DUCK_POND \
	./roof/ROOF \
	strongbadzone/ASPLODE strongbadzone/BACK_OFF \
	./fish/FISH ./rat/RAT ./dating/DATING_XR
	cp $(EMPTY_DISK) sb.dsk
	$(DOS33_RAW) sb.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) sb.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) sb.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) sb.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) sb.dsk  2  0 ./title/TITLE      0   0
	$(DOS33_RAW) sb.dsk  5  0 ./duck_pond/DUCK_POND  0   0
	$(DOS33_RAW) sb.dsk  8  0 ./roof/ROOF       0   0
	$(DOS33_RAW) sb.dsk  9  0 ./strongbadzone/ASPLODE    0   0
#	$(DOS33_RAW) sb.dsk  20 0 TARGET     0   0
	$(DOS33_RAW) sb.dsk  14 0 ./fish/FISH      0   0
	$(DOS33_RAW) sb.dsk  20 0 ./rat/RAT        0   0
	$(DOS33_RAW) sb.dsk  22 0 ./strongbadzone/BACK_OFF   0   0
	$(DOS33_RAW) sb.dsk  24 0 ../peasant_mini/cliff/CLIMB   0   0
	$(DOS33_RAW) sb.dsk  28 0 ./dating/DATING_XR  0   0

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	qload.s qboot.inc
	ca65 -o qload.o qload.s -l qload.lst

####

./dating/DATING_XR:	
	cd dating && make

./duck_pond/DUCK_POND:	
	cd duck_pond && make

./fish/FISH:	
	cd fish && make

./rat/RAT:	
	cd rat && make

./roof/ROOF:	
	cd roof && make

./strongbadzone/ASPLODE:	
	cd strongbadzone && make

./strongbadzone/BACK_OFF:	
	cd strongbadzone && make

./title/TITLE:	
	cd title && make



####

TARGET:	target.o
	ld65 -o TARGET target.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

target.o:	target.s zx02_optim.s \
		target_graphics/target.hgr.zx02 \
		zp.inc hardware.inc
	ca65 -o target.o target.s -l target.lst

target_graphics/target.hgr.zx02:	
	cd target_graphics && make


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
	rm -f *.lst *.o *~ QBOOT QLOAD
	cd dating && make clean
	cd duck_pond && make clean
	cd fish && make clean
	cd rat && make clean
	cd roof && make clean
	cd strongbadzone && make clean
	cd title && make clean


distclean:
	rm -f *.lst *.o *~ QBOOT QLOAD
	cd dating && make distclean
	cd duck_pond && make distclean
	cd fish && make distclean
	cd rat && make distclean
	cd roof && make distclean
	cd strongbadzone && make distclean
	cd title && make distclean
