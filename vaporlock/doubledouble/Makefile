include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	double.dsk

double.dsk:	HELLO DOUBLE
	cp $(EMPTYDISK) double.dsk
	$(DOS33) -y double.dsk SAVE A HELLO
	$(DOS33) -y double.dsk BSAVE -a 0x6000 DOUBLE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DOUBLE:	double.o
	ld65 -o DOUBLE double.o -C $(LINKERSCRIPTS)/apple2_6000.inc

double.o:	double.s \
	zp.inc hardware.inc pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s pt3_lib_detect_model.s \
	zx02_optim.s copy_400.s gr_offsets.s vblank.s \
	lc_detect.s text_print.s title.s gr_fast_clear.s \
	graphics/sworg_hgr.hgr.zx02 \
	graphics/sworg_dhgr.aux.zx02 \
	graphics/sworg_dhgr.bin.zx02 \
	graphics/sworg_dgr.main.zx02 \
	graphics/sworg_dgr.aux.zx02
	ca65 -o double.o double.s -l double.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO DOUBLE
