ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	nine.dsk

####

nine.dsk:	HELLO NINE WOZ
	cp $(EMPTY_DISK) nine.dsk
	$(DOS33) -y nine.dsk SAVE A HELLO
	$(DOS33) -y nine.dsk BSAVE -a 0x6000 NINE
	$(DOS33) -y nine.dsk BSAVE -a 0x6000 WOZ

####

NINE:	nine.o
	ld65 -o NINE nine.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

nine.o:	nine.s zx02_optim.s \
		hgr_sprite.s \
		hgr_tables.s \
		sprites/numbers.inc \
		zp.inc hardware.inc
	ca65 -o nine.o nine.s -l nine.lst

####

WOZ:	woz.o
	ld65 -o WOZ woz.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

woz.o:	woz.s zx02_optim.s \
		dhgr_sprite.s \
		hgr_tables.s \
		sprites/numbers.inc \
		zp.inc hardware.inc
	ca65 -o woz.o woz.s -l woz.lst

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


####

clean:
	rm -f *~ *.o *.lst NINE WOZ

distclean:
	rm -f *~ *.o *.lst NINE WOZ
	cd graphics && make clean
	cd sprites && make clean
