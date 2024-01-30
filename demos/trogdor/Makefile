include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts/

all:	trogdor.dsk

trogdor.dsk:	QBOOT QLOAD music.inc qload.inc \
	MUSIC TROGDOR TITLE FLAMES COUNTRYSIDE STRONGBAD
	cp $(EMPTY_DISK) trogdor.dsk
	$(DOS33_RAW) trogdor.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) trogdor.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) trogdor.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) trogdor.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) trogdor.dsk 4 0 MUSIC		0 0
	$(DOS33_RAW) trogdor.dsk 6 0 FLAMES		0 0
	$(DOS33_RAW) trogdor.dsk 8 0 COUNTRYSIDE	0 0
	$(DOS33_RAW) trogdor.dsk 9 0 STRONGBAD		0 0
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
	hgr_sprite_big_mask.s \
	horiz_scroll_simple.s \
	horiz_scroll_skip.s \
	hgr_copy_magnify.s \
	vertical_scroll.s \
	hgr_copy_part.s \
	gr_offsets.s vertical_scroll_down.s \
	wait.s wait_a_bit.s do_flames.s \
	lc_detect.s \
	hgr_clear_screen.s hgr_copy_fast.s \
	text_print.s start.s \
	hgr_table.s gs_interrupt.s hgr_page_flip.s \
	zx02_optim.s wait_keypress.s hardware_detect.s \
	pt3_lib_detect_model.s pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s interrupt_handler.s \
	pt3_lib_mockingboard_patch.s
	ca65 -o qload.o qload.s -l qload.lst

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
	./generate_common -a 0x1200 -s hgr_clear_screen qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_copy_fast qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_page_flip qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_copy_part qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_draw_sprite_big_mask qload.lst >> qload.inc
	./generate_common -a 0x1200 -s horiz_pan qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_vertical_scroll_right qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_vertical_scroll_left qload.lst >> qload.inc
	./generate_common -a 0x1200 -s horiz_pan_skip qload.lst >> qload.inc
	./generate_common -a 0x1200 -s horiz_pan_skip_short qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_copy_magnify qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_vertical_scroll_down_left qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_copy_right qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_copy_left qload.lst >> qload.inc
	./generate_common -a 0x1200 -s do_flames qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait_ticks qload.lst >> qload.inc
	./generate_common -a 0x1200 -s draw_twin_flames_tall_2 qload.lst >> qload.inc
	./generate_common -a 0x1200 -s draw_twin_flames_tall_1 qload.lst >> qload.inc
	./generate_common -a 0x1200 -s draw_twin_flames_low qload.lst >> qload.inc
	./generate_common -a 0x1200 -s draw_flame_tall_1 qload.lst >> qload.inc
	./generate_common -a 0x1200 -s draw_flame_tall_2 qload.lst >> qload.inc

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

flames.inc:	generate_common FLAMES
	./generate_common -a 0xe300 -s left_flame_small flames.lst > flames.inc
	./generate_common -a 0xe300 -s right_flame_small flames.lst >> flames.inc
	./generate_common -a 0xe300 -s left_flame_big flames.lst >> flames.inc
	./generate_common -a 0xe300 -s right_flame_big flames.lst >> flames.inc
	./generate_common -a 0xe300 -s left_flame_small_mask flames.lst >> flames.inc
	./generate_common -a 0xe300 -s right_flame_small_mask flames.lst >> flames.inc
	./generate_common -a 0xe300 -s left_flame_big_mask flames.lst >> flames.inc
	./generate_common -a 0xe300 -s right_flame_big_mask flames.lst >> flames.inc

####

FLAMES:	flames.o
	ld65 -o FLAMES flames.o -C $(LINKER_SCRIPTS)/apple2_e300.inc

flames.o:	flames.s \
	graphics/flame_sprites.inc
	ca65 -o flames.o flames.s -l flames.lst

####

COUNTRYSIDE:	countryside.o
	ld65 -o COUNTRYSIDE countryside.o -C $(LINKER_SCRIPTS)/apple2_fa00.inc

countryside.o:	countryside.s \
	graphics/flame_sprites.inc
	ca65 -o countryside.o countryside.s -l countryside.lst

####

STRONGBAD:	strongbad.o
	ld65 -o STRONGBAD strongbad.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

strongbad.o:	strongbad.s \
	graphics/a2_strongbad.hgr.zx02
	ca65 -o strongbad.o strongbad.s -l strongbad.lst


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
	flames.inc do_flames.s \
	zp.inc hardware.inc qload.inc \
	graphics/trog00_trogdor.hgr.zx02 \
	hgr_sprite_big_mask.s horiz_scroll_simple.s hgr_copy_magnify.s \
	horiz_scroll_skip.s vertical_scroll_down.s hgr_copy_part.s
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
	rm -f *~ *.o *.lst QBOOT QLOAD \
		MUSIC TROGDOR FLAMES COUNTRYSIDE TITLE STRONGBAD
	rm -f qload.inc music.inc generate_common
