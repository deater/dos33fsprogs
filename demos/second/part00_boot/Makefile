include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	FAKE_BIOS

###

FAKE_BIOS:	fake_bios.o
	ld65 -o FAKE_BIOS fake_bios.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

fake_bios.o:	fake_bios.s \
	../hgr_clear_screen.s ../hgr_table.s \
	font_console_1x8.s fonts/a2_cga_thin.inc \
	pt3_lib_detect_model.s ../lc_detect.s aux_detect.s \
	65c02_detect.s ../pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s ../wait.s \
	../zx02_optim.s graphics/a2_energy.hgr.zx02
	ca65 -o fake_bios.o fake_bios.s -l fake_bios.lst

###

fonts/a2_cga_thin.inc:	
	cd fonts && make

graphics/a2_energy.hgr.zx02:	
	cd graphics && make
###

clean:	
	rm -f *~ *.o *.lst FAKE_BIOS
	cd graphics && make clean
	cd fonts && make clean
