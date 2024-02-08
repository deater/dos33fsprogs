include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	plasma_mask.dsk

plasma_mask.dsk:	HELLO PLASMA_NEW
	cp $(EMPTYDISK) plasma_mask.dsk
	$(DOS33) -y plasma_mask.dsk SAVE A HELLO
	$(DOS33) -y plasma_mask.dsk BSAVE -a 0x1000 PLASMA_NEW

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PLASMA_MASK:	plasma_mask.o
	ld65 -o PLASMA_MASK plasma_mask.o -C $(LINKERSCRIPTS)/apple2_4000.inc

plasma_mask.o:	plasma_mask.s gr_gbascalc.s make_tables.s \
	zp.inc hardware.inc zx02_optim.s make_tables.s \
	mA2E_2.s tracker_init.s play_frame.s \
	graphics/dsr_big.gr.zx02
	ca65 -o plasma_mask.o plasma_mask.s -l plasma_mask.lst

###

PLASMA_NEW:	plasma_new.o
	ld65 -o PLASMA_NEW plasma_new.o -C $(LINKERSCRIPTS)/apple2_1000.inc

plasma_new.o:	plasma_new.s PLASMA_COMPRESS.zx02
	ca65 -o plasma_new.o plasma_new.s -l plasma_new.lst

###

PLASMA_COMPRESS.zx02:	PLASMA_COMPRESS
	$(ZX02) -f PLASMA_COMPRESS PLASMA_COMPRESS.zx02

###

PLASMA_COMPRESS:	plasma_compress.o
	ld65 -o PLASMA_COMPRESS plasma_compress.o -C $(LINKERSCRIPTS)/apple2_4000.inc

plasma_compress.o:	plasma_compress.s gr_gbascalc.s make_tables.s \
	zp.inc hardware.inc zx02_optim.s make_tables.s \
	mA2E_2.s tracker_init.s play_frame.s \
	graphics/dsr_big.gr.zx02
	ca65 -o plasma_compress.o plasma_compress.s -l plasma_compress.lst

###


clean:	
	rm -f *~ *.o *.lst HELLO PLASMA_MASK
