include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	double.dsk

double.dsk:	HELLO DOUBLE STATIC MIDLINE
	cp $(EMPTYDISK) double.dsk
	$(DOS33) -y double.dsk SAVE A HELLO
	$(DOS33) -y double.dsk BSAVE -a 0x6000 DOUBLE
	$(DOS33) -y double.dsk BSAVE -a 0x6000 STATIC
	$(DOS33) -y double.dsk BSAVE -a 0x6000 MIDLINE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DOUBLE:	double.o
	ld65 -o DOUBLE double.o -C $(LINKERSCRIPTS)/apple2_6000.inc

double.o:	double.s \
	zp.inc hardware.inc pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s pt3_lib_detect_model.s \
	pt3_lib_core.s \
	zx02_optim.s copy_400.s gr_offsets.s vblank.s \
	text_print.s title.s gr_fast_clear.s \
	interrupt_handler.s pt3_lib_mockingboard_patch.s \
	wait_a_bit.s wait.s pt3_lib_init.s \
	music/fighting.zx02 \
	setup_graphics.s \
	effect_static.s \
	effect_sin_window.s \
	effect_midline.s \
	table/sin.table \
	graphics/sworg_hgr.hgr.zx02 \
	graphics/sworg_dhgr.aux.zx02 \
	graphics/sworg_dhgr.bin.zx02 \
	graphics/sworg_dgr.main.zx02 \
	graphics/sworg_dgr.aux.zx02
	ca65 -o double.o double.s -l double.lst

###

STATIC:	static.o
	ld65 -o STATIC static.o -C $(LINKERSCRIPTS)/apple2_6000.inc

static.o:	static.s \
	zp.inc hardware.inc pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s pt3_lib_detect_model.s \
	zx02_optim.s copy_400.s gr_offsets.s vblank.s \
	text_print.s title.s gr_fast_clear.s \
	interrupt_handler.s pt3_lib_mockingboard_patch.s \
	wait_a_bit.s wait.s pt3_lib_init.s \
	setup_graphics.s \
	music/fighting.zx02 \
	graphics/sworg_hgr.hgr.zx02 \
	graphics/sworg_dhgr.aux.zx02 \
	graphics/sworg_dhgr.bin.zx02 \
	graphics/sworg_dgr.main.zx02 \
	graphics/sworg_dgr.aux.zx02
	ca65 -o static.o static.s -l static.lst


###

MIDLINE:	midline.o
	ld65 -o MIDLINE midline.o -C $(LINKERSCRIPTS)/apple2_6000.inc

midline.o:	midline.s \
	zp.inc hardware.inc pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s pt3_lib_detect_model.s \
	pt3_lib_core.s \
	zx02_optim.s copy_400.s gr_offsets.s vblank.s \
	text_print.s title.s gr_fast_clear.s \
	interrupt_handler.s pt3_lib_mockingboard_patch.s \
	wait_a_bit.s wait.s pt3_lib_init.s \
	music/fighting.zx02 \
	setup_graphics.s \
	effect_static.s \
	effect_sin_window.s \
	effect_midline.s \
	table/sin.table \
	graphics/sworg_hgr.hgr.zx02 \
	graphics/sworg_dhgr.aux.zx02 \
	graphics/sworg_dhgr.bin.zx02 \
	graphics/sworg_dgr.main.zx02 \
	graphics/sworg_dgr.aux.zx02
	ca65 -o midline.o midline.s -l midline.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO DOUBLE STATIC MIDLINE
