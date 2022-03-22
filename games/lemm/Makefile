include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk
LINKER_SCRIPTS = ../../linker_scripts

all:	lemm.dsk

#lemm.dsk:	HELLO LEMM LEMM_TEST
#	cp $(EMPTY_DISK) lemm.dsk
#	$(DOS33) -y lemm.dsk SAVE A HELLO
#	$(DOS33) -y lemm.dsk BSAVE -a 0x6000 LEMM
#	$(DOS33) -y lemm.dsk BSAVE -a 0x4000 LEMM_TEST


lemm.dsk:	QBOOT QLOAD LEMM \
	LEVEL1 LEVEL2 LEVEL3 LEVEL4 LEVEL5
	cp $(EMPTY_DISK) lemm.dsk
	$(DOS33_RAW) lemm.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) lemm.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) lemm.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) lemm.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) lemm.dsk  3  0 LEMM       0   0
	$(DOS33_RAW) lemm.dsk  10 0 LEVEL1     0   0
	$(DOS33_RAW) lemm.dsk  13 0 LEVEL2     0   0
	$(DOS33_RAW) lemm.dsk  16 0 LEVEL3     0   0
	$(DOS33_RAW) lemm.dsk  19 0 LEVEL4     0   0
	$(DOS33_RAW) lemm.dsk  22 0 LEVEL5     0   0


###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s	qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	qload.s qboot.inc	\
	audio.s decompress_fast_v2.s gr_offsets.s \
	wait.s wait_a_bit.s
	ca65 -o qload.o qload.s -l qload.lst

###

qload.inc:	generate_common QLOAD
	./generate_common -a 0x1200 -s load_file qload.lst > qload.inc
	./generate_common -a 0x1200 -s play_audio qload.lst >> qload.inc
	./generate_common -a 0x1200 -s decompress_lzsa2_fast qload.lst >> qload.inc
	./generate_common -a 0x1200 -s getsrc_smc qload.lst >> qload.inc
	./generate_common -a 0x1200 -s gr_offsets qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait qload.lst >> qload.inc
	./generate_common -a 0x1200 -s wait_a_bit qload.lst >> qload.inc


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

LEMM_TEST:	lemm_test.o
	ld65 -o LEMM_TEST lemm_test.o -C ../../linker_scripts/apple2_4000.inc

lemm_test.o:	lemm_test.s zp.inc hardware.inc \
		graphics/graphics_test.inc \
		interrupt_handler.s
	ca65 -o lemm_test.o lemm_test.s -l lemm_test.lst

####

LEMM:	lemm.o
	ld65 -o LEMM lemm.o -C ../../linker_scripts/apple2_6000.inc

lemm.o:	lemm.s zp.inc hardware.inc qload.inc \
		graphics/sprites.inc \
		intro_level.s update_time.s hgr_sprite.s draw_flames.s  \
		draw_door.s move_lemming.s draw_lemming.s \
		hgr_hlin.s hgr_vlin.s update_menu.s init_level.s \
		interrupt_handler.s keyboard.s draw_pointer.s \
		pointer_sprites.inc particle_hgr.s release_lemming.s \
		title.s audio.s letsgo.s load_music.s
	ca65 -o lemm.o lemm.s -l lemm.lst


###

lemm.inc:	generate_common LEMM
	./generate_common -a 0x6000 -s chunk_h_smc lemm.lst > lemm.inc
	./generate_common -a 0x6000 -s chunk_l_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s load_song_chunk lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s intro_level lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s hgr_make_tables lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s play_letsgo lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s lemming_out lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s lemming_exploding lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s lemming_x lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s lemming_y lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s lemming_direction lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s lemming_status lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s draw_lemming lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s move_lemmings lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s erase_lemming lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s update_time lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s draw_door lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s draw_door_5 lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s draw_flames lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s draw_pointer lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s erase_pointer lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s handle_keypress lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s disable_music lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s outro_level lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s update_lemmings_out lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s level_preview_h_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s level_preview_l_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s r_flame_x_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s r_flame_y_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s l_flame_x_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s l_flame_y_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s exit_x1_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s exit_x2_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s exit_y1_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s exit_y2_smc lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s load_music lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s intro_text_smc_l lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s intro_text_smc_h lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s release_lemming lemm.lst >> lemm.inc
	./generate_common -a 0x6000 -s init_level lemm.lst >> lemm.inc

####

LEVEL1:	level1.o
	ld65 -o LEVEL1 level1.o -C ../../linker_scripts/apple2_9000.inc

level1.o:	level1.s zp.inc hardware.inc qload.inc lemm.inc \
		release_lemming.s \
		graphics/graphics_level1.inc
	ca65 -o level1.o level1.s -l level1.lst

####

LEVEL2:	level2.o
	ld65 -o LEVEL2 level2.o -C ../../linker_scripts/apple2_9000.inc

level2.o:	level2.s zp.inc hardware.inc qload.inc lemm.inc \
		release_lemming.s \
		graphics/graphics_level2.inc
	ca65 -o level2.o level2.s -l level2.lst

####

LEVEL3:	level3.o
	ld65 -o LEVEL3 level3.o -C ../../linker_scripts/apple2_9000.inc

level3.o:	level3.s zp.inc hardware.inc qload.inc lemm.inc \
		release_lemming.s \
		graphics/graphics_level3.inc
	ca65 -o level3.o level3.s -l level3.lst


####

LEVEL4:	level4.o
	ld65 -o LEVEL4 level4.o -C ../../linker_scripts/apple2_9000.inc

level4.o:	level4.s zp.inc hardware.inc qload.inc lemm.inc \
		release_lemming.s \
		graphics/graphics_level4.inc
	ca65 -o level4.o level4.s -l level4.lst



####

LEVEL5:	level5.o
	ld65 -o LEVEL5 level5.o -C ../../linker_scripts/apple2_9000.inc

level5.o:	level5.s zp.inc hardware.inc qload.inc lemm.inc \
		release_lemming.s \
		graphics/graphics_level5.inc
	ca65 -o level5.o level5.s -l level5.lst




####

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c


####

graphics/graphics_test.inc:
	cd	graphics && make

####

clean:		
	rm -f *~ *.o *.lst HELLO LEMM LEMM_TEST generate_common \
		LEVEL1 LEVEL2 LEVEL3 LEVEL4 LEVEL5 \
		lemm.inc

