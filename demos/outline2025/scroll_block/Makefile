include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	scroll_block.dsk

scroll_block.dsk:	QBOOT QLOAD \
	MUSIC ROAD \
	music.inc qload.inc
	cp $(EMPTY_DISK) scroll_block.dsk
	$(DOS33_RAW) scroll_block.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) scroll_block.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) scroll_block.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) scroll_block.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) scroll_block.dsk 2 0 MUSIC		0 0
	$(DOS33_RAW) scroll_block.dsk 13 0 ROAD 0 0


###

submit: a2_scroll_block.zip a2_scroll_block_small.zip

a2_scroll_block.zip:	file_id.diz scroll_block.dsk
	mkdir -p outline2025_a2_scroll_block
	mkdir -p outline2025_a2_scroll_block/code
	cp *.s ./outline2025_a2_scroll_block/code
	cp *.inc ./outline2025_a2_scroll_block/code
	cp file_id.diz ./outline2025_a2_scroll_block
	cp scroll_block.dsk ./outline2025_a2_scroll_block
	cp a2_scroll_block_720p.mp4 ./outline2025_a2_scroll_block
	cp a2_scroll_block_screen.png ./outline2025_a2_scroll_block
	zip -r a2_scroll_block.zip outline2025_a2_scroll_block

a2_scroll_block_small.zip:	file_id.diz scroll_block.dsk
	mkdir -p outline2025_a2_scroll_block_small
	mkdir -p outline2025_a2_scroll_block_small/code
	cp *.s ./outline2025_a2_scroll_block_small/code
	cp *.inc ./outline2025_a2_scroll_block_small/code
	cp file_id.diz ./outline2025_a2_scroll_block_small
	cp scroll_block.dsk ./outline2025_a2_scroll_block_small
	zip -r a2_scroll_block_small.zip outline2025_a2_scroll_block_small

###

ROAD:	road.o
	ld65 -o ROAD road.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

road.o:	road.s \
	zp.inc hardware.inc qload.inc common_defines.inc \
	grongy/sroad000.zx02 grongy/sroad001.zx02 grongy/sroad002.zx02 \
	grongy/sroad003.zx02 grongy/sroad004.zx02 grongy/sroad005.zx02 \
	grongy/sroad006.zx02 grongy/sroad007.zx02 grongy/sroad008.zx02 \
	grongy/sroad009.zx02 grongy/sroad010.zx02 grongy/sroad011.zx02 \
	wipes.s
	ca65 -o road.o road.s -l road.lst



####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst


####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	zp.inc hardware.inc common_defines.inc music.inc qload.s \
	gr_offsets.s \
	lc_detect.s gr_fast_clear.s \
	text_print.s start.s \
	pt3_lib_detect_model.s pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s interrupt_handler.s \
	pt3_lib_mockingboard_patch.s \
	irq_wait.s vblank.s
	ca65 -o qload.o qload.s -l qload.lst

####

qload.inc:	generate_common QLOAD
	./generate_common -a 0x1200 -s load_file qload.lst > qload.inc
	./generate_common -a 0x1200 -s detect_appleii_model qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_all qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_all_color qload.lst >> qload.inc
	./generate_common -a 0x1200 -s set_normal qload.lst >> qload.inc
	./generate_common -a 0x1200 -s set_inverse qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s wait qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s wait_a_bit qload.lst >> qload.inc
	./generate_common -a 0x1200 -s move_and_print qload.lst >> qload.inc
	./generate_common -a 0x1200 -s detect_language_card qload.lst >> qload.inc
	./generate_common -a 0x1200 -s mockingboard_detect qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_bottom qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_bottoms qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_screens qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_top qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s zx02_full_decomp qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s zx_src_h qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s zx_src_l qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s interrupt_handler music.lst >> music.inc
#	./generate_common -a 0x1200 -s zx02_full_decomp qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s zx02_full_decomp_aux qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s zx02_full_decomp_main qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s zx_src_h qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s zx_src_l qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s wait_until_keypress qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s wait_50xms qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s wait_vblank qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s wait_seconds qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait_for_pattern qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s wait_ticks qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s gr_offsets qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s gr_flip_page qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s check_timeout qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s copy_to_400 qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s copy_to_400_main qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s copy_to_400_aux qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s draw_road qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s PT3_LOC qload.lst >> qload.inc

####

music.inc:	generate_common MUSIC
	./generate_common -a 0xd000 -s pt3_init_song music.lst > music.inc
	./generate_common -a 0xd000 -s mockingboard_init music.lst >> music.inc
	./generate_common -a 0xd000 -s reset_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s clear_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s mockingboard_setup_interrupt music.lst >> music.inc
	./generate_common -a 0xd000 -s mockingboard_disable_interrupt music.lst >> music.inc
	./generate_common -a 0xd000 -s done_pt3_irq_handler music.lst >> music.inc
#	./generate_common -a 0xd000 -s PT3_LOC music.lst >> music.inc
	./generate_common -a 0xd000 -s current_pattern_smc music.lst >> music.inc
	./generate_common -a 0xd000 -s pt3_set_pattern music.lst >> music.inc
#	./generate_common -a 0xd000 -s copy_main_aux music.lst >> music.inc
#	./generate_common -a 0xd000 -s copy_aux_main music.lst >> music.inc
	./generate_common -a 0xd000 -s mute_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s unmute_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s interrupt_handler music.lst >> music.inc
#	./generate_common -a 0xd000 -s copy_to_400 music.lst >> music.inc
#	./generate_common -a 0xd000 -s copy_to_400_main music.lst >> music.inc
#	./generate_common -a 0xd000 -s copy_to_400_aux music.lst >> music.inc
	./generate_common -a 0xd000 -s zx02_full_decomp music.lst >> music.inc
	./generate_common -a 0xd000 -s zx02_full_decomp_aux music.lst >> music.inc
	./generate_common -a 0xd000 -s zx02_full_decomp_main music.lst >> music.inc
	./generate_common -a 0xd000 -s zx_src_h music.lst >> music.inc
	./generate_common -a 0xd000 -s zx_src_l music.lst >> music.inc
	./generate_common -a 0xd000 -s title_graphic music.lst >> music.inc
#	./generate_common -a 0xd000 -s road21_zx02 music.lst >> music.inc
#	./generate_common -a 0xd000 -s road22_zx02 music.lst >> music.inc
#	./generate_common -a 0xd000 -s road23_zx02 music.lst >> music.inc
#	./generate_common -a 0xd000 -s road24_zx02 music.lst >> music.inc


####

MUSIC:	music.o
	ld65 -o MUSIC music.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

music.o:	music.s zp.inc \
	copy_400.s \
	zx02_optim.s \
	draw_road.s \
	music/Alex\ Winston\ -\ Scroll\ Block\ (2024)\ (Deadline\ 2024).pt3 \
	pt3_lib_core.s \
	pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard.inc \
	pt3_lib_init.s \
	pt3_lib_mockingboard_setup.s \
	pt3_lib_irq_handler.s \
	graphics/title1.hgr.zx02
	ca65 -o music.o music.s -l music.lst


###

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

###


clean:
	rm -f *~ *.o *.lst QBOOT QLOAD MUSIC ROAD generate_common
	rm -f qload.inc qload2.inc music.inc music2.inc









