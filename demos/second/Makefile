include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts/

all:	second.dsk

#second.dsk:	HELLO ZW
#	cp $(EMPTY_DISK) second.dsk
#	$(DOS33) -y second.dsk SAVE A HELLO
#	$(DOS33) -y second.dsk BSAVE -a 0x6000 ZW

second.dsk:	QBOOT QLOAD SECOND MUSIC \
	./part18_3d/THREED
	cp $(EMPTY_DISK) second.dsk
	$(DOS33_RAW) second.dsk 0 0 QBOOT	0 1
	$(DOS33_RAW) second.dsk 0 2 QBOOT	1 1
	$(DOS33_RAW) second.dsk 0 4 QBOOT	2 1
	$(DOS33_RAW) second.dsk 1 0 QLOAD	0 0
	$(DOS33_RAW) second.dsk 3 0 MUSIC	0 0
#	$(DOS33_RAW) second.dsk 5 0 SECOND	0 0
	$(DOS33_RAW) second.dsk 5 0 ./part18_3d/THREED	0 0

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst


####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	qload.s \
	gr_offsets.s \
	wait.s wait_a_bit.s \
	lc_detect.s gr_fast_clear.s \
	text_print.s \
	pt3_lib_detect_model.s pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s interrupt_handler.s \
	pt3_lib_mockingboard_patch.s
#        hgr.inc simple_sounds.s \
#       audio.s decompress_fast_v2.s
#        hgr_hlin.s hgr_vlin.s hgr_box.s hgr_tables.s hgr_14x14_sprite.s \
#        hgr_sprite.s hgr_partial_restore.s
	ca65 -o qload.o qload.s -l qload.lst

####

SECOND:	second.o
	ld65 -o SECOND second.o -C ../../linker_scripts/apple2_6000.inc

second.o:	second.s zx02_optim.s \
	text_print.s title.s \
	graphics/icekngdm.hgr.zx02 \
	graphics/final3.hgr.zx02 \
	graphics/mntscrl3.hgr.zx02 \
	roto.s rotozoom.s \
	zp.inc hardware.inc qload.inc music.inc
	ca65 -o second.o second.s -l second.lst

####

qload.inc:	generate_common QLOAD
	./generate_common -a 0x1200 -s load_file qload.lst > qload.inc
	./generate_common -a 0x1200 -s detect_appleii_model qload.lst >> qload.inc
	./generate_common -a 0x1200 -s clear_all qload.lst >> qload.inc
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

#	./generate_common -a 0x1200 -s mockingboard_patch qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s mockingboard_init qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s mockingboard_setup_interrupt qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s disable_music qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s reset_ay_both qload.lst >> qload.inc
#	./generate_common -a 0x1200 -s clear_ay_both qload.lst >> qload.inc

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

####

MUSIC:	music.o
	ld65 -o MUSIC music.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

music.o:	music.s zp.inc \
	music/z00m_unreal2_part1.pt3 \
	pt3_lib_core.s \
	pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard.inc \
	pt3_lib_init.s \
	pt3_lib_mockingboard_setup.s \
	pt3_lib_irq_handler.s
	ca65 -o music.o music.s -l music.lst





generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

###


clean:
		rm -f *~ *.o *.lst HELLO SECOND QBOOT QLOAD MUSIC
