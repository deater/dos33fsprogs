include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts/

all:	trogdor.dsk

trogdor.dsk:	QBOOT QLOAD music.inc qload.inc \
	MUSIC TROGDOR TITLE
	cp $(EMPTY_DISK) trogdor.dsk
	$(DOS33_RAW) trogdor.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) trogdor.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) trogdor.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) trogdor.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) trogdor.dsk 4 0 MUSIC		0 0
	$(DOS33_RAW) trogdor.dsk 11 0 TITLE		0 0
	$(DOS33_RAW) trogdor.dsk 12 0 TROGDOR		0 0


####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst


####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	zp.inc hardware.inc music.inc qload.s \
	gr_offsets.s \
	wait.s wait_a_bit.s \
	lc_detect.s \
	text_print.s start.s \
	hgr_table.s gs_interrupt.s \
	zx02_optim.s wait_keypress.s hardware_detect.s \
	pt3_lib_detect_model.s pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s interrupt_handler.s \
	pt3_lib_mockingboard_patch.s
	ca65 -o qload.o qload.s -l qload.lst

####

QLOAD2:	qload2.o
	ld65 -o QLOAD2 qload2.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload2.o:	qload2.s \
	zp.inc hardware.inc music2.inc \
	gr_offsets.s \
	wait.s wait_a_bit.s \
	lc_detect.s gr_fast_clear.s \
	text_print.s start2.s \
	hardware_detect.s \
	hgr_table.s \
	pt3_lib_detect_model.s pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s interrupt_handler.s \
	pt3_lib_mockingboard_patch.s
	ca65 -o qload2.o qload2.s -l qload2.lst


####

qload.inc:	generate_common QLOAD
	./generate_common -a 0x1200 -s load_file qload.lst > qload.inc
	./generate_common -a 0x1200 -s detect_appleii_model qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_all qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_all_color qload.lst >> qload.inc
	./generate_common -a 0x1200 -s set_normal qload.lst >> qload.inc
	./generate_common -a 0x1200 -s set_inverse qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait_a_bit qload.lst >> qload.inc
	./generate_common -a 0x1200 -s move_and_print qload.lst >> qload.inc
	./generate_common -a 0x1200 -s detect_language_card qload.lst >> qload.inc
	./generate_common -a 0x1200 -s mockingboard_detect qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_bottom qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_bottoms qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_screens qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_top qload.lst >> qload.inc
	./generate_common -a 0x1200 -s zx02_full_decomp qload.lst >> qload.inc
	./generate_common -a 0x1200 -s zx_src_h qload.lst >> qload.inc
	./generate_common -a 0x1200 -s zx_src_l qload.lst >> qload.inc

####

music.inc:	generate_common MUSIC
	./generate_common -a 0xd000 -s pt3_init_song music.lst > music.inc
	./generate_common -a 0xd000 -s mockingboard_init music.lst >> music.inc
	./generate_common -a 0xd000 -s reset_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s clear_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s mockingboard_setup_interrupt music.lst >> music.inc
	./generate_common -a 0xd000 -s mockingboard_disable_interrupt music.lst >> music.inc
	./generate_common -a 0xd000 -s done_pt3_irq_handler music.lst >> music.inc
	./generate_common -a 0xd000 -s PT3_LOC music.lst >> music.inc
	./generate_common -a 0xd000 -s current_pattern_smc music.lst >> music.inc
	./generate_common -a 0xd000 -s pt3_set_pattern music.lst >> music.inc
	./generate_common -a 0xd000 -s mute_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s unmute_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s interrupt_handler music.lst >> music.inc

####

MUSIC:	music.o
	ld65 -o MUSIC music.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

music.o:	music.s zp.inc \
	music/trogdor.pt3 \
	pt3_lib_core.s \
	pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard.inc \
	pt3_lib_init.s \
	pt3_lib_mockingboard_setup.s \
	pt3_lib_irq_handler.s
	ca65 -o music.o music.s -l music.lst

###

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

title.o:	title.s \
	zp.inc hardware.inc qload.inc \
	graphics/trogdor.hgr.zx02
	ca65 -o title.o title.s -l title.lst

###

TROGDOR:	trogdor.o
	ld65 -o TROGDOR trogdor.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

trogdor.o:	trogdor.s \
	zp.inc hardware.inc qload.inc \
	graphics/trog00_trogdor.hgr.zx02
	ca65 -o trogdor.o trogdor.s -l trogdor.lst


###

graphics/trog00_trogdor.hgr.zx02:	
	cd graphics && make

###

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

###


clean:
	rm -f *~ *.o *.lst QBOOT QLOAD MUSIC TROGDOR
	rm -f qload.inc music.inc generate_common
