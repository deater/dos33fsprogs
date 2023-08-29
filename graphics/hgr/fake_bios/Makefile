include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	fake_bios.dsk

fake_bios.dsk:	HELLO FAKE_BIOS
	cp $(EMPTY_DISK)/empty.dsk fake_bios.dsk
	$(DOS33) -y fake_bios.dsk SAVE A HELLO
	$(DOS33) -y fake_bios.dsk BSAVE -a 0x6000 FAKE_BIOS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

FAKE_BIOS:	fake_bios.o
	ld65 -o FAKE_BIOS fake_bios.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

fake_bios.o:	fake_bios.s \
	hgr_clear_screen.s \
	font_console_1x8.s fonts/a2_cga_thin.inc \
	pt3_lib_detect_model.s lc_detect.s \
	zx02_optim.s graphics/a2_energy.hgr.zx02
	ca65 -o fake_bios.o fake_bios.s -l fake_bios.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO FAKE_BIOS

