include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts/

all:	driven.dsk

driven.dsk:	QBOOT QLOAD \
	MUSIC \
	music.inc qload.inc \
	./part00_intro/INTRO \
	./part05_atrus/ATRUS \
	./part07_maglev/MOVIE_MAGLEV_RIDE \
	./part10_graphics/GRAPHICS \
	./part20_credits/CREDITS
	cp $(EMPTY_DISK) driven.dsk
	$(DOS33_RAW) driven.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) driven.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) driven.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) driven.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) driven.dsk 2 0 MUSIC		0 0
	$(DOS33_RAW) driven.dsk 5 0 ./part07_maglev/MOVIE_MAGLEV_RIDE 0 0
	$(DOS33_RAW) driven.dsk 13 0 ./part05_atrus/ATRUS 0 0
	$(DOS33_RAW) driven.dsk 17 0 ./part00_intro/INTRO 0 0
	$(DOS33_RAW) driven.dsk 20 0 ./part10_graphics/GRAPHICS 0 0
	$(DOS33_RAW) driven.dsk 26 0 ./part20_credits/CREDITS 0 0

####

part00_intro/INTRO:	
	cd part00_intro && make

part01_dni/DNI:	
	cd part01_dni && make

part05_atrus/ATRUS:	
	cd part05_atrus && make

part07_maglev/MOVIE_MAGLEV_RIDE:	
	cd part07_maglev && make

part10_graphics/GRAPHICS:	
	cd part10_graphics && make

part20_credits/CREDITS:	
	cd part20_credits && make


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
	wait.s wait_a_bit.s \
	lc_detect.s gr_fast_clear.s \
	text_print.s start.s \
	hgr_table.s hgr_sprite.s \
	pt3_lib_detect_model.s pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s interrupt_handler.s \
	pt3_lib_mockingboard_patch.s \
	irq_wait.s vblank.s hgr_page_flip.s \
	wipes/fx.hgr.fizzle.s \
	wipes/fx.hgr.2pass.lr.s \
	hgr_clear_screen.s
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
	./generate_common -a 0x1200 -s wait_until_keypress qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_draw_sprite qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait_50xms qload.lst >> qload.inc
	./generate_common -a 0x1200 -s random8 qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait_vblank qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait_seconds qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait_for_pattern qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait_ticks qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_page_flip qload.lst >> qload.inc
	./generate_common -a 0x1200 -s gr_offsets qload.lst >> qload.inc
	./generate_common -a 0x1200 -s inc_base5 qload.lst >> qload.inc
	./generate_common -a 0x1200 -s draw_full_dni_number qload.lst >> qload.inc
	./generate_common -a 0x1200 -s gr_flip_page qload.lst >> qload.inc
	./generate_common -a 0x1200 -s do_wipe_fizzle qload.lst >> qload.inc
	./generate_common -a 0x1200 -s do_wipe_lr qload.lst >> qload.inc
	./generate_common -a 0x1200 -s do_wipe_center qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_page1_clearscreen qload.lst >> qload.inc
	./generate_common -a 0x1200 -s hgr_page2_clearscreen qload.lst >> qload.inc


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
	./generate_common -a 0xd000 -s copy_main_aux music.lst >> music.inc
	./generate_common -a 0xd000 -s copy_aux_main music.lst >> music.inc
	./generate_common -a 0xd000 -s mute_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s unmute_ay_both music.lst >> music.inc
	./generate_common -a 0xd000 -s interrupt_handler music.lst >> music.inc

####

MUSIC:	music.o
	ld65 -o MUSIC music.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

music.o:	music.s zp.inc \
	aux_memcopy.s \
	music/mA2E_3.pt3 \
	pt3_lib_core.s \
	pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard.inc \
	pt3_lib_init.s \
	pt3_lib_mockingboard_setup.s \
	pt3_lib_irq_handler.s
	ca65 -o music.o music.s -l music.lst


###

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

###


clean:
	rm -f *~ *.o *.lst HELLO SECOND QBOOT QLOAD MUSIC START
	rm -f qload.inc qload2.inc music.inc music2.inc
	cd part00_intro && make clean
	cd part01_dni && make clean
	cd part05_atrus && make clean
	cd part07_maglev && make clean
	cd part10_graphics && make clean
	cd part20_credits && make clean

###

submit:	driven.zip

driven.zip:	driven.dsk file_id.diz
	mkdir -p demosplash2024_driven
	cp file_id.diz ./demosplash2024_driven
	cp driven.dsk ./demosplash2024_driven
#	cp second_d2.dsk ./demosplash2024_driven
#	cp a2r_720p.mp4 ./demosplash2024_driven
	cp driven_screenshot.png ./demosplash2024_driven
	zip -r driven.zip demosplash2024_driven

####
