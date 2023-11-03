include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts/

all:	second_d1.dsk second_d2.dsk

second_d1.dsk:	QBOOT QLOAD music.inc qload.inc \
	MUSIC_INTRO \
	MUSIC \
	./part01_intropan/INTRO \
	./part04_chess_shapes/CHESS \
	./part05_dot_tunnel/TUNNEL \
	./part08_gorilla/GORILLA \
	./part09_leaves/LEAVES \
	./part10_lens_rotozoom/LENS \
	./part12_plasma/PLASMA \
	./part13_plasmacube/PLASMACUBE	\
	./part14_dotbounce/DOTS	\
	./part15_transmission/SPHERES \
	./part16_ocean/OCEAN \
	./part17_polar/POLAR
	cp $(EMPTY_DISK) second_d1.dsk
	$(DOS33_RAW) second_d1.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) second_d1.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) second_d1.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) second_d1.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) second_d1.dsk 2 0 MUSIC_INTRO	0 0
	$(DOS33_RAW) second_d1.dsk 4 0 MUSIC		0 0
	$(DOS33_RAW) second_d1.dsk 10 0 ./part01_intropan/INTRO	0 0
	$(DOS33_RAW) second_d1.dsk 15 0 ./part04_chess_shapes/CHESS	0 0
#	$(DOS33_RAW) second_d1.dsk 16 0 ./part05_dot_tunnel/TUNNEL	0 0
	$(DOS33_RAW) second_d1.dsk 19 0 ./part08_gorilla/GORILLA	0 0
	$(DOS33_RAW) second_d1.dsk 21 0 ./part09_leaves/LEAVES		0 0
	$(DOS33_RAW) second_d1.dsk 23 0 ./part10_lens_rotozoom/LENS		0 0
	$(DOS33_RAW) second_d1.dsk 24 0 ./part12_plasma/PLASMA		0 0
	$(DOS33_RAW) second_d1.dsk 25 0 ./part13_plasmacube/PLASMACUBE	0 0
	$(DOS33_RAW) second_d1.dsk 26 0 ./part14_dotbounce/DOTS	0 0
	$(DOS33_RAW) second_d1.dsk 27 0 ./part15_transmission/SPHERES	0 0
	$(DOS33_RAW) second_d1.dsk 28 0 ./part16_ocean/OCEAN 0 0
	$(DOS33_RAW) second_d1.dsk 34 0 ./part17_polar/POLAR	0 0


####

part01_intropan/INTRO:	
	cd part01_intropan && make

part04_chess_shapes/CHESS:	
	cd part04_chess_shapes && make

part08_gorilla/GORILLA:	
	cd part08_gorilla && make

part09_leaves/LEAVES:	
	cd part09_leaves && make

part10_lens_rotozoom/LENS:	
	cd part10_lens_rotozoom && make

part12_plasma/PLASMA:	
	cd part12_plasma && make

part13_plasmacube/PLASMACUBE:	
	cd part13_plasmacube && make

part14_dotbounce/DOTS:	
	cd part14_dotbounce && make

part15_transmission/SPHERES:	
	cd part15_transmission && make

part16_ocean/OCEAN:	
	cd part16_ocean && make

part17_polar/POLAR:	
	cd part17_polar && make


second_d2.dsk:	QBOOT QLOAD2 MUSIC2 music2.inc qload2.inc \
	./part18_3d/THREED \
	./part19_nuts/NUTS \
	./part20_credits/CREDITS
	cp $(EMPTY_DISK) second_d2.dsk
	$(DOS33_RAW) second_d2.dsk 0 0 QBOOT	0 1
	$(DOS33_RAW) second_d2.dsk 0 2 QBOOT	1 1
	$(DOS33_RAW) second_d2.dsk 0 4 QBOOT	2 1
	$(DOS33_RAW) second_d2.dsk 1 0 QLOAD2	0 0
	$(DOS33_RAW) second_d2.dsk 3 0 MUSIC2	0 0
	$(DOS33_RAW) second_d2.dsk  8 0 ./part19_nuts/NUTS		0 0
	$(DOS33_RAW) second_d2.dsk 12 0 ./part20_credits/CREDITS	0 0
	$(DOS33_RAW) second_d2.dsk 20 0 ./part18_3d/THREED		0 0

####

part18_3d/THREED:	
	cd part18_3d && make

part19_nuts/NUTS:	
	cd part19_nuts && make

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

qload.o:	zp.inc hardware.inc music.inc qload.s \
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

#SECOND:	second.o
#	ld65 -o SECOND second.o -C ../../linker_scripts/apple2_6000.inc
#
#second.o:	second.s zx02_optim.s \
#	text_print.s title.s \
#	graphics/icekngdm.hgr.zx02 \
#	graphics/final3.hgr.zx02 \
#	graphics/mntscrl3.hgr.zx02 \
#	zp.inc hardware.inc qload.inc music.inc
#	ca65 -o second.o second.s -l second.lst

####

#START:	start.o
#	ld65 -o START start.o -C ../../linker_scripts/apple2_2000.inc

#start.o:	start.s zx02_optim.s \
#	text_print.s title.s \
#	zp.inc hardware.inc qload.inc music.inc
#	ca65 -o start.o start.s -l start.lst

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


#	./generate_common -a 0x1200 -s mockingboard_patch qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s mockingboard_init qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s mockingboard_setup_interrupt qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s disable_music qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s reset_ay_both qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s clear_ay_both qload.lst >> qload.inc

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

####

MUSIC:	music.o
	ld65 -o MUSIC music.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

music.o:	music.s zp.inc \
	aux_memcopy.s \
	music/z00m_unreal2_part1.pt3 \
	pt3_lib_core.s \
	pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard.inc \
	pt3_lib_init.s \
	pt3_lib_mockingboard_setup.s \
	pt3_lib_irq_handler.s
	ca65 -o music.o music.s -l music.lst

####

MUSIC_INTRO:	music_intro.o
	ld65 -o MUSIC_INTRO music_intro.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

music_intro.o:	music_intro.s zp.inc \
	aux_memcopy.s \
	music/z00m_unreal2_part1.pt3 \
	pt3_lib_core.s \
	pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard.inc \
	pt3_lib_init.s \
	pt3_lib_mockingboard_setup.s \
	pt3_lib_irq_handler.s
	ca65 -o music_intro.o music_intro.s -l music_intro.lst


####

MUSIC2:	music2.o
	ld65 -o MUSIC2 music2.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

music2.o:	music2.s zp.inc \
	aux_memcopy.s \
	music/second_3d.pt3 \
	pt3_lib_core.s \
	pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard.inc \
	pt3_lib_init.s \
	pt3_lib_mockingboard_setup.s \
	pt3_lib_irq_handler.s
	ca65 -o music2.o music2.s -l music2.lst



###

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

###


clean:
	rm -f *~ *.o *.lst HELLO SECOND QBOOT QLOAD MUSIC START
	rm -f qload.inc qload2.inc music.inc music2.inc
	cd part01_intropan && make clean
	cd part04_chess_shapes && make clean
	cd part08_gorilla && make clean
	cd part09_leaves && make clean
	cd part10_lens_rotozoom && make clean
	cd part12_plasma && make clean
	cd part13_plasmacube && make clean
	cd part14_dotbounce && make clean
	cd part15_transmission && make clean
	cd part16_ocean && make clean
	cd part17_polar && make clean
	cd part18_3d && make clean
	cd part19_nuts && make clean
	cd part20_credits && make clean
