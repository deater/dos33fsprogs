include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts/

all:	zw.dsk

#zw.dsk:	HELLO ZW
#	cp $(EMPTY_DISK) zw.dsk
#	$(DOS33) -y zw.dsk SAVE A HELLO
#	$(DOS33) -y zw.dsk BSAVE -a 0x6000 ZW

zw.dsk:	QBOOT QLOAD ZW
	cp $(EMPTY_DISK) zw.dsk
	$(DOS33_RAW) zw.dsk 0 0 QBOOT	0 1
	$(DOS33_RAW) zw.dsk 0 2 QBOOT	1 1
	$(DOS33_RAW) zw.dsk 0 4 QBOOT	2 1
	$(DOS33_RAW) zw.dsk 1 0 QLOAD	0 0
	$(DOS33_RAW) zw.dsk 3 0 ZW	0 0

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst


####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	qload.s
#        hgr.inc \
#       audio.s decompress_fast_v2.s gr_offsets.s \
#        wait.s wait_a_bit.s \
#        hgr_hlin.s hgr_vlin.s hgr_box.s hgr_tables.s hgr_14x14_sprite.s \
#        hgr_sprite.s hgr_partial_restore.s lc_detect.s gr_fast_clear.s \
#        text_print.s simple_sounds.s \
#        pt3_lib_detect_model.s pt3_lib_mockingboard_detect.s \
#        pt3_lib_mockingboard_setup.s interrupt_handler.s \
#        pt3_lib_mockingboard_patch.s
	ca65 -o qload.o qload.s -l qload.lst

####

ZW:	zw.o
	ld65 -o ZW zw.o -C ../../linker_scripts/apple2_6000.inc

zw.o:	zw.s zx02_optim.s \
	text_print.s \
	zp.inc hardware.inc
	ca65 -o zw.o zw.s -l zw.lst

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###


clean:
		rm -f *~ *.o *.lst HELLO ZW QBOOT QLOAD
