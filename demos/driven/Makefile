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
	./part01_dni/DNI \
	./part05_atrus/ATRUS \
	./part10_graphics/GRAPHICS \
	./part20_credits/CREDITS
	cp $(EMPTY_DISK) driven.dsk
	$(DOS33_RAW) driven.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) driven.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) driven.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) driven.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) driven.dsk 4 0 MUSIC		0 0
	$(DOS33_RAW) driven.dsk 9 0 ./part00_intro/INTRO 0 0
	$(DOS33_RAW) driven.dsk 13 0 ./part20_credits/CREDITS 0 0
	$(DOS33_RAW) driven.dsk 17 0 ./part01_dni/DNI 0 0
	$(DOS33_RAW) driven.dsk 21 0 ./part05_atrus/ATRUS 0 0
	$(DOS33_RAW) driven.dsk 25 0 ./part10_graphics/GRAPHICS 0 0

#second_d1.dsk:	QBOOT QLOAD \
#	music.inc qload.inc \
#	MUSIC_INTRO \
#	MUSIC \
#	./part00_boot/FAKE_BIOS \
#	./part01_intropan/INTRO \
#	./part04_chess_shapes/CHESS \
#	./part05_dot_tunnel/TUNNEL \
#	./part08_gorilla/GORILLA \
#	./part09_leaves/LEAVES \
#	./part10_lens_rotozoom/LENS \
#	./part12_plasma/PLASMA \
#	./part13_plasmacube/PLASMACUBE	\
#	./part14_dotbounce/DOTS	\
#	./part15_transmission/SPHERES \
#	./part16_ocean/OCEAN \
#	./part17_polar/POLAR
#	cp $(EMPTY_DISK) second_d1.dsk
#	$(DOS33_RAW) second_d1.dsk 0 0 QBOOT		0 1
#	$(DOS33_RAW) second_d1.dsk 0 2 QBOOT		1 1
#	$(DOS33_RAW) second_d1.dsk 0 4 QBOOT		2 1
#	$(DOS33_RAW) second_d1.dsk 1 0 QLOAD		0 0
#	$(DOS33_RAW) second_d1.dsk 2 0 MUSIC_INTRO	0 0
#	$(DOS33_RAW) second_d1.dsk 4 0 MUSIC		0 0
#	$(DOS33_RAW) second_d1.dsk  9 0 ./part00_boot/FAKE_BIOS 0 0
#	$(DOS33_RAW) second_d1.dsk 10 0 ./part01_intropan/INTRO	0 0
#	$(DOS33_RAW) second_d1.dsk 15 0 ./part04_chess_shapes/CHESS	0 0
#	$(DOS33_RAW) second_d1.dsk 16 0 ./part05_dot_tunnel/TUNNEL	0 0
#	$(DOS33_RAW) second_d1.dsk 19 0 ./part08_gorilla/GORILLA	0 0
#	$(DOS33_RAW) second_d1.dsk 21 0 ./part09_leaves/LEAVES		0 0
#	$(DOS33_RAW) second_d1.dsk 23 0 ./part10_lens_rotozoom/LENS		0 0
#	$(DOS33_RAW) second_d1.dsk 24 0 ./part12_plasma/PLASMA		0 0
#	$(DOS33_RAW) second_d1.dsk 25 0 ./part13_plasmacube/PLASMACUBE	0 0
#	$(DOS33_RAW) second_d1.dsk 26 0 ./part14_dotbounce/DOTS	0 0
#	$(DOS33_RAW) second_d1.dsk 27 0 ./part15_transmission/SPHERES	0 0
#	$(DOS33_RAW) second_d1.dsk 28 0 ./part16_ocean/OCEAN 0 0
#	$(DOS33_RAW) second_d1.dsk 34 0 ./part17_polar/POLAR	0 0


####

part00_intro/INTRO:	
	cd part00_intro && make

part01_dni/DNI:	
	cd part01_dni && make

part05_atrus/ATRUS:	
	cd part05_atrus && make

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

qload.o:	zp.inc hardware.inc qload.s \
	music.inc \
	gr_offsets.s \
	wait.s wait_a_bit.s \
	lc_detect.s gr_fast_clear.s \
	text_print.s start.s \
	hgr_table.s \
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

####

qload2.inc:	generate_common QLOAD2
	./generate_common -a 0x1200 -s load_file qload2.lst > qload2.inc
	./generate_common -a 0x1200 -s detect_appleii_model qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s clear_all qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s clear_all_color qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s set_normal qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s set_inverse qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s wait qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s wait_a_bit qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s move_and_print qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s detect_language_card qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s mockingboard_detect qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s clear_bottom qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s clear_bottoms qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s clear_screens qload2.lst >> qload2.inc
	./generate_common -a 0x1200 -s hgr_make_tables qload2.lst >> qload2.inc

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

music2.inc:	generate_common MUSIC2
	./generate_common -a 0xd000 -s pt3_init_song music2.lst > music2.inc
	./generate_common -a 0xd000 -s mockingboard_init music2.lst >> music2.inc
	./generate_common -a 0xd000 -s reset_ay_both music2.lst >> music2.inc
	./generate_common -a 0xd000 -s clear_ay_both music2.lst >> music2.inc
	./generate_common -a 0xd000 -s mockingboard_setup_interrupt music2.lst >> music2.inc
	./generate_common -a 0xd000 -s mockingboard_disable_interrupt music2.lst >> music2.inc
	./generate_common -a 0xd000 -s done_pt3_irq_handler music2.lst >> music2.inc
	./generate_common -a 0xd000 -s PT3_LOC music2.lst >> music2.inc
	./generate_common -a 0xd000 -s current_pattern_smc music2.lst >> music2.inc
	./generate_common -a 0xd000 -s copy_main_aux music2.lst >> music2.inc
	./generate_common -a 0xd000 -s copy_aux_main music2.lst >> music2.inc
	./generate_common -a 0xd000 -s mute_ay_both music2.lst >> music2.inc
	./generate_common -a 0xd000 -s unmute_ay_both music2.lst >> music2.inc
	./generate_common -a 0xd000 -s interrupt_handler music2.lst >> music2.inc

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
	cd part20_credits && make clean

###

submit:	driven.zip

driven.zip:	driven.dsk file_id.diz
	mkdir -p demosplash2024_driven
	cp file_id.diz ./demosplash2024_driven
	cp second_d1.dsk ./demosplash2024_driven
	cp second_d2.dsk ./demosplash2024_driven
#	cp a2r_720p.mp4 ./demosplash2024_driven
	cp a2r_screen.png ./demosplash2024_driven
	zip -r a2_reality.zip demosplash2024_driven

####
