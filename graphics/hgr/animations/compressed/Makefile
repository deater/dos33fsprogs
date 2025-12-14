include ../../../../Makefile.inc

DOS33 = ../../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../../empty_disk/empty.dsk
TOKENIZE = ../../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../../linker_scripts/
GENERATE_COMMON = ../generate_common

all:	compress_test.dsk

compress_test.dsk:	QBOOT QLOAD \
	qload.inc \
	ANIMATION
	cp $(EMPTY_DISK) compress_test.dsk
	$(DOS33_RAW) compress_test.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) compress_test.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) compress_test.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) compress_test.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) compress_test.dsk 5 0 ANIMATION 0 0

####

ANIMATION:	animation.o
	ld65 -o ANIMATION animation.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

animation.o:	animation.s \
	zp.inc ../hardware.inc qload.inc common_defines.inc \
	graphics/kerrek1.hgr.zx02
	ca65 -o animation.o animation.s -l animation.lst

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst


####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	zp.inc ../hardware.inc common_defines.inc qload.s \
	../gr_offsets.s \
	../wait.s \
	../wait_a_bit.s \
	../gr_fast_clear.s \
	../text_print.s \
	../hgr_table.s \
	../pt3lib/lc_detect.s \
	../pt3lib/pt3_lib_detect_model.s \
	../pt3lib/pt3_lib_mockingboard_detect.s \
	../pt3lib/pt3_lib_mockingboard_setup.s \
	../pt3lib/interrupt_handler.s \
	../pt3lib/pt3_lib_mockingboard_patch.s \
	../irq_wait.s \
	../hgr_page_flip.s \
	../hgr_clear_screen.s \
	start.s
	ca65 -o qload.o qload.s -l qload.lst

####

qload.inc:	$(GENERATE_COMMON) QLOAD
	$(GENERATE_COMMON) -a 0x1200 -s load_file qload.lst > qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s detect_appleii_model qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_all qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_all_color qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s set_normal qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s set_inverse qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_a_bit qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_50ms qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s move_and_print qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s detect_language_card qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s mockingboard_detect qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_bottom qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_bottoms qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_screens qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_top qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s zx02_full_decomp qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s zx_src_h qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s zx_src_l qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_until_keypress qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s hgr_draw_sprite qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_50xms qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s random8 qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_vblank qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_seconds qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_for_pattern qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_ticks qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s hgr_page_flip qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s gr_offsets qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s inc_base5 qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s draw_full_dni_number qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s gr_flip_page qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s do_wipe_fizzle qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s do_wipe_lr qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s do_wipe_center qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s hgr_clear_screen qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s hgr_page1_clearscreen qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s hgr_page2_clearscreen qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s check_timeout qload.lst >> qload.inc

###


clean:
	rm -f *~ *.o *.lst HELLO ANIMATION QBOOT QLOAD MUSIC
	rm -f qload.inc qload2.inc music.inc music2.inc


