include ../../Makefile.inc

EMPTY_DISK = ../../empty_disk/empty.dsk
LINKER_SCRIPTS = ../../linker_scripts/
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
GENERATE_COMMON = ../../utils/symbols/generate_common

all:	space_bars.dsk

space_bars.dsk:	QBOOT QLOAD \
	./title/TITLE \
	./level3/LEVEL3_EARTH \
	./level6/LEVEL6_SATURN
	cp $(EMPTY_DISK) space_bars.dsk
	$(DOS33_RAW) space_bars.dsk 0 0 QBOOT			0 1
	$(DOS33_RAW) space_bars.dsk 0 2 QBOOT			1 1
	$(DOS33_RAW) space_bars.dsk 0 4 QBOOT			2 1
	$(DOS33_RAW) space_bars.dsk 1 0 QLOAD			0 0
	$(DOS33_RAW) space_bars.dsk 3 0 ./title/TITLE		0 0
	$(DOS33_RAW) space_bars.dsk 4 0 ./level3/LEVEL3_EARTH	0 0
	$(DOS33_RAW) space_bars.dsk 8 0 ./level6/LEVEL6_SATURN	0 0

####

title/TITLE:	qload.inc
	cd title && make

level3/LEVEL3_EARTH:	qload.inc
	cd level3 && make

level6/LEVEL6_SATURN:	qload.inc
	cd level6 && make

####

qload.inc:	QLOAD
	$(GENERATE_COMMON) -a 0x1200 -s load_file qload.lst > qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s detect_appleii_model qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_all qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_all_color qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s set_normal qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s set_inverse qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_a_bit qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s move_and_print qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s detect_language_card qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s mockingboard_detect qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_bottom qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_bottoms qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_screens qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_top qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s zx02_full_decomp qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s zx_src_h qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s zx_src_l qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s gr_offsets qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_until_keypressed qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s vapor_lock qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s delay_a qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_gr qload.lst >> qload.inc

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	qload.s \
	zp.inc hardware.inc common_defines.inc \
	gr_offsets.s gr_simple_clear.s gr_fast_clear.s \
	lc_detect.s hardware_detect.s \
	text_print.s keypress.s \
	start.s game_over.s \
	vapor_lock.s delay_a.s \
	zx02_optim.s
	ca65 -o qload.o qload.s -l qload.lst

#	pt3_lib_detect_model.s pt3_lib_mockingboard_detect.s \
#	pt3_lib_mockingboard_setup.s interrupt_handler.s \
#	pt3_lib_mockingboard_patch.s \


####

clean:	
	rm -f *~ *.o *.lst qload.inc
	cd title && make clean
	cd level3 && make clean
	cd level6 && make clean

