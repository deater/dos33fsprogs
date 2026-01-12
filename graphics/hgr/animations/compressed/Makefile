include ../../../../Makefile.inc

DOS33 = ../../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../../empty_disk/empty.dsk
TOKENIZE = ../../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../../linker_scripts/
GENERATE_COMMON = ../generate_common

all:	compress_test.dsk special_hgr.dsk vertical_hgr.dsk bvertical_hgr.dsk

compress_test.dsk:	QBOOT QLOAD \
	qload.inc \
	ANIMATION
	cp $(EMPTY_DISK) compress_test.dsk
	$(DOS33_RAW) compress_test.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) compress_test.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) compress_test.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) compress_test.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) compress_test.dsk 5 0 ANIMATION 0 0

special_hgr.dsk:	QBOOT QLOAD \
	qload.inc \
	SPECIAL_HGR
	cp $(EMPTY_DISK) special_hgr.dsk
	$(DOS33_RAW) special_hgr.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) special_hgr.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) special_hgr.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) special_hgr.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) special_hgr.dsk 5 0 SPECIAL_HGR 0 0

vertical_hgr.dsk:	QBOOT QLOAD \
	qload.inc \
	VERTICAL_HGR
	cp $(EMPTY_DISK) vertical_hgr.dsk
	$(DOS33_RAW) vertical_hgr.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) vertical_hgr.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) vertical_hgr.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) vertical_hgr.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) vertical_hgr.dsk 5 0 VERTICAL_HGR 0 0

bvertical_hgr.dsk:	QBOOT QLOAD \
	qload.inc \
	BVERTICAL_HGR
	cp $(EMPTY_DISK) bvertical_hgr.dsk
	$(DOS33_RAW) bvertical_hgr.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) bvertical_hgr.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) bvertical_hgr.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) bvertical_hgr.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) bvertical_hgr.dsk 5 0 BVERTICAL_HGR 0 0



####

ANIMATION:	animation.o
	ld65 -o ANIMATION animation.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

animation.o:	animation.s \
	zp.inc ../hardware.inc qload.inc common_defines.inc \
	hgr_repack.s \
	graphics/kerrek1.hgr.zx02
	ca65 -o animation.o animation.s -l animation.lst

####

SPECIAL_HGR:	special_hgr.o
	ld65 -o SPECIAL_HGR special_hgr.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

special_hgr.o:	special_hgr.s \
	zp.inc ../hardware.inc qload2.inc common_defines.inc \
	zx02_hgr.s \
	graphics/kerrek1.raw.zx02
	ca65 -o special_hgr.o special_hgr.s -l special_hgr.lst

####

VERTICAL_HGR:	vertical_hgr.o
	ld65 -o VERTICAL_HGR vertical_hgr.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

vertical_hgr.o:	vertical_hgr.s \
	zp.inc ../hardware.inc qload2.inc common_defines.inc \
	zx02_vertical.s \
	graphics/kerrek1.vraw.zx02
	ca65 -o vertical_hgr.o vertical_hgr.s -l vertical_hgr.lst

####

BVERTICAL_HGR:	bvertical_hgr.o
	ld65 -o BVERTICAL_HGR bvertical_hgr.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

bvertical_hgr.o:	bvertical_hgr.s \
	zp.inc ../hardware.inc qload2.inc common_defines.inc \
	zx02_bvertical.s \
	graphics/kerrek1.bvraw.zx02
	ca65 -o bvertical_hgr.o bvertical_hgr.s -l bvertical_hgr.lst

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


qload2.inc:	$(GENERATE_COMMON) QLOAD
	$(GENERATE_COMMON) -a 0x1200 -s load_file qload.lst > qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s detect_appleii_model qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_all qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_all_color qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s set_normal qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s set_inverse qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_a_bit qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_50ms qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s move_and_print qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s detect_language_card qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s mockingboard_detect qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_bottom qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_bottoms qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_screens qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_top qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s zx02_full_decomp qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s zx_src_h qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s zx_src_l qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_until_keypress qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s hgr_draw_sprite qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_50xms qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s random8 qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_vblank qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_seconds qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_for_pattern qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_ticks qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s hgr_page_flip qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s gr_offsets qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s inc_base5 qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s draw_full_dni_number qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s gr_flip_page qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s do_wipe_fizzle qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s do_wipe_lr qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s do_wipe_center qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s hgr_clear_screen qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s hgr_page1_clearscreen qload.lst >> qload2.inc
	$(GENERATE_COMMON) -a 0x1200 -s hgr_page2_clearscreen qload.lst >> qload2.inc
#	$(GENERATE_COMMON) -a 0x1200 -s check_timeout qload.lst >> qload2.inc


###


clean:
	rm -f *~ *.o *.lst HELLO ANIMATION QBOOT QLOAD SPECIAL_HGR VERTICAL_HGR BVERTICAL_HGR
	rm -f qload.inc qload2.inc


