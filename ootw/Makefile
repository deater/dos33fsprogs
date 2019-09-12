include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2RLE = ../gr-utils/png2rle
PNG2LZ4 = ../gr-utils/png2lz4


all:	ootw.dsk ootw_side2.dsk

ootw.dsk:	HELLO LOADER INTRO OOTW_C1 OOTW_C2 OOTW_C3 OOTW_C4 OOTW_C5
	cp empty.dsk ootw.dsk
	$(DOS33) -y ootw.dsk SAVE A HELLO
	$(DOS33) -y ootw.dsk BSAVE -a 0x1400 LOADER
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 INTRO
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 OOTW_C1
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 OOTW_C2
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 OOTW_C3
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 OOTW_C4
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 OOTW_C5
#	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 AUDIO_TEST
#	$(DOS33) -y ootw.dsk BSAVE -a 0x2000 COMPRESS-TEST

ootw_side2.dsk:	HELLO2 LOADER2 ENDING
	cp empty.dsk ootw_side2.dsk
	$(DOS33) -y ootw_side2.dsk SAVE A HELLO2 HELLO
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1400 LOADER2 LOADER
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ENDING



####

OOTW_C1:	ootw_c1.o
	ld65 -o OOTW_C1 ootw_c1.o -C ../linker_scripts/apple2_1700.inc

ootw_c1.o:	ootw_c1.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s \
	gr_putsprite.s gr_putsprite_flipped.s gr_putsprite_crop.s \
	gr_hlin.s gr_make_quake.s gr_overlay.s zp.inc keyboard.s \
	collision.s \
	ootw_c1_sluggy.s ootw_c1_beast.s \
	ootw_c1_arrival.s ootw_c1_rope.s earthquake.s ootw_c1_mesa.s \
	ootw_c1_pool.s ootw_c1_cavern.s physicist.s random16.s \
	ootw_graphics/l1pool/ootw_pool.inc \
	ootw_graphics/l1underwater/ootw_underwater.inc \
	ootw_graphics/l1caves/ootw_cavern.inc \
	ootw_graphics/l1caves/ootw_cavern2.inc \
	ootw_graphics/l1caves/ootw_cavern3.inc \
	ootw_graphics/l1rope/ootw_rope.inc \
	ootw_graphics/l1rope/ootw_swing.inc \
	ootw_graphics/l1end/ootw_l1end.inc \
	ootw_graphics/sprites/physicist.inc \
	ootw_graphics/sprites/physicist_l1_swim.inc \
	ootw_graphics/sprites/slugs.inc \
	ootw_graphics/sprites/l1_background.inc \
	ootw_graphics/sprites/beast.inc \
	ootw_graphics/l1end_scenes/ootw_beast_end.inc \
	ootw_graphics/l1end_scenes/ootw_beast_intro.inc \
	ootw_graphics/l1end_scenes/ootw_slug_end.inc
	ca65 -o ootw_c1.o ootw_c1.s -l ootw_c1.lst

####

OOTW_C2:	ootw_c2.o
	ld65 -o OOTW_C2 ootw_c2.o -C ../linker_scripts/apple2_1700.inc

ootw_c2.o:	ootw_c2.s \
	gr_copy.s gr_copy_offset.s gr_fast_clear.s gr_pageflip.s gr_unrle.s \
	gr_hlin.s gr_putsprite.s gr_putsprite_flipped.s gr_putsprite_crop.s \
	keyboard.s gr_run_sequence.s audio.s \
	alien_laser.s \
	physicist.s alien.s friend.s \
	collision.s door.s laser.s shield.s blast.s gun.s \
	ootw_c2_miners.s \
	ootw_graphics/sprites/physicist.inc \
	ootw_graphics/sprites/alien.inc \
	ootw_graphics/sprites/friend.inc \
	ootw_c2_cage.s ootw_c2_jail.s ootw_c2_elevator.s ootw_c2_intro.s \
	ootw_graphics/l2cage/ootw_c2_cage.inc \
	ootw_graphics/l2jail/ootw_c2_jail.inc \
	ootw_graphics/l2intro/ootw_l2intro.inc \
	ootw_graphics/l2laser/ootw_c2_laser.inc
	ca65 -o ootw_c2.o ootw_c2.s -l ootw_c2.lst

####

OOTW_C3:	ootw_c3.o
	ld65 -o OOTW_C3 ootw_c3.o -C ../linker_scripts/apple2_1700.inc

ootw_c3.o:	ootw_c3.s \
	gr_copy.s gr_copy_offset.s gr_fast_clear.s gr_pageflip.s gr_unrle.s \
	gr_putsprite.s gr_putsprite_flipped.s gr_putsprite_crop.s \
	keyboard.s \
	ootw_c3_vent.s \
	ootw_graphics/sprites/physicist_rolling.inc \
	ootw_graphics/l3vent/ootw_c3_vent.inc
	ca65 -o ootw_c3.o ootw_c3.s -l ootw_c3.lst

###

OOTW_C4:	ootw_c4.o
	ld65 -o OOTW_C4 ootw_c4.o -C ../linker_scripts/apple2_1700.inc

ootw_c4.o:	ootw_c4.s \
	gr_copy.s gr_twoscreen_scroll.s gr_fast_clear.s gr_pageflip.s \
	gr_unrle.s gr_hlin.s \
	gr_putsprite.s gr_putsprite_flipped.s gr_putsprite_crop.s \
	keyboard.s gr_run_sequence.s physicist.s \
	collision.s alien.s alien_laser.s \
	ootw_c4_city.s ootw_c4_action.s \
	door.s laser.s shield.s blast.s gun.s charger.s \
	ootw_graphics/sprites/physicist.inc \
	ootw_graphics/l4city/ootw_c4_city.inc
	ca65 -o ootw_c4.o ootw_c4.s -l ootw_c4.lst

###

OOTW_C5:	ootw_c5.o
	ld65 -o OOTW_C5 ootw_c5.o -C ../linker_scripts/apple2_1700.inc

ootw_c5.o:	ootw_c5.s \
	gr_copy.s gr_copy_offset.s gr_fast_clear.s gr_pageflip.s gr_unrle.s \
	gr_putsprite.s gr_putsprite_flipped.s gr_putsprite_crop.s \
	keyboard.s gr_run_sequence.s physicist.s ootw_c5_cave.s \
	collision.s door.s gun.s blast.s shield.s \
	ootw_graphics/sprites/physicist.inc \
	ootw_graphics/l5cave/ootw_c5_cave.inc
	ca65 -o ootw_c5.o ootw_c5.s -l ootw_c5.lst


####

AUDIO_TEST:	audio.o
	ld65 -o AUDIO_TEST audio.o -C ../linker_scripts/apple2_1700.inc

audio.o:	audio.s
	ca65 -o audio.o audio.s -l audio.lst


####

INTRO:	intro.o
	ld65 -o INTRO intro.o -C ../linker_scripts/apple2_1700_9000.inc

intro.o:	intro.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s gr_putsprite.s \
	gr_overlay.s gr_run_sequence.s \
	keyboard.s random16.s text_print.s zp.inc \
	intro_graphics/01_building/intro_car.inc \
	intro_graphics/01_building/intro_building_car.inc \
	intro_graphics/01_building/intro_building.inc \
	intro_graphics/02_outer_door/outer_door.inc \
	intro_graphics/02_outer_door/feet.inc \
	intro_graphics/03_elevator/intro_elevator.inc \
	intro_graphics/03_elevator/intro_off_elevator.inc \
	intro_graphics/03_elevator/intro_walking.inc \
	intro_graphics/04_keypad/intro_scanner_door.inc \
	intro_graphics/04_keypad/intro_approach.inc \
	intro_graphics/04_keypad/intro_keypad_bg.inc \
	intro_graphics/04_keypad/intro_hands.inc \
	intro_graphics/04_keypad/intro_opening.inc \
	intro_graphics/05_scanner/intro_scanner.inc \
	intro_graphics/05_scanner/intro_scanning.inc \
	intro_graphics/05_scanner/intro_ai_bg.inc \
	intro_graphics/05_scanner/intro_ai.inc \
	intro_graphics/06_console/intro_desktop.inc \
	intro_graphics/06_console/intro_cursor.inc \
	intro_graphics/06_console/intro_collider.inc \
	intro_graphics/07_soda/intro_open_soda.inc \
	intro_graphics/07_soda/intro_drinking.inc \
	intro_graphics/08_lightning/lightning.inc \
	intro_graphics/09_tunnel/intro_tunnel1.inc \
	intro_graphics/09_tunnel/intro_tunnel2.inc \
	intro_graphics/10_gone/intro_zappo.inc \
	intro_graphics/10_gone/intro_gone.inc \
	intro_data_01.lz4 \
	intro_data_04.lz4 \
	intro_data_06.lz4 \
	intro_data_08.lz4 \
	intro_data_09.lz4
	ca65 -o intro.o intro.s -l intro.lst

####

intro_data_01.lz4:	intro_data_01
	lz4 -f -16 intro_data_01
	truncate -s-8 intro_data_01.lz4

intro_data_01:	intro_data_01.o
	ld65 -o intro_data_01 intro_data_01.o -C ../linker_scripts/apple2_9000.inc

intro_data_01.o:	intro_data_01.s
	ca65 -o intro_data_01.o intro_data_01.s -l intro_data_01.lst


intro_data_04.lz4:	intro_data_04
	lz4 -f -16 intro_data_04
	truncate -s-8 intro_data_04.lz4

intro_data_04:	intro_data_04.o
	ld65 -o intro_data_04 intro_data_04.o -C ../linker_scripts/apple2_9000.inc

intro_data_04.o:	intro_data_04.s
	ca65 -o intro_data_04.o intro_data_04.s -l intro_data_04.lst


intro_data_06.lz4:	intro_data_06
	lz4 -f -16 intro_data_06
	truncate -s-8 intro_data_06.lz4

intro_data_06:	intro_data_06.o
	ld65 -o intro_data_06 intro_data_06.o -C ../linker_scripts/apple2_9000.inc

intro_data_06.o:	intro_data_06.s
	ca65 -o intro_data_06.o intro_data_06.s -l intro_data_06.lst


intro_data_08.lz4:	intro_data_08
	lz4 -f -16 intro_data_08
	truncate -s-8 intro_data_08.lz4

intro_data_08:	intro_data_08.o
	ld65 -o intro_data_08 intro_data_08.o -C ../linker_scripts/apple2_9000.inc

intro_data_08.o:	intro_data_08.s
	ca65 -o intro_data_08.o intro_data_08.s -l intro_data_08.lst


intro_data_09.lz4:	intro_data_09
	lz4 -f -16 intro_data_09
	truncate -s-8 intro_data_09.lz4

intro_data_09:	intro_data_09.o
	ld65 -o intro_data_09 intro_data_09.o -C ../linker_scripts/apple2_9000.inc

intro_data_09.o:	intro_data_09.s
	ca65 -o intro_data_09.o intro_data_09.s -l intro_data_09.lst




####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1400.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst

####

LOADER2:	loader2.o
	ld65 -o LOADER2 loader2.o -C ../linker_scripts/apple2_1400.inc

loader2.o:	loader2.s
	ca65 -o loader2.o loader2.s -l loader2.lst


####


HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####


HELLO2:  hello2.bas
	../asoft_basic-utils/tokenize_asoft < hello2.bas > HELLO2


#####

ENDING:	ending.o
	ld65 -o ENDING ending.o -C ../linker_scripts/apple2_1700.inc

ending.o:	ending.s \
	pt3_lib_core.s pt3_lib_init.s pt3_lib_mockingboard.s \
	pt3_setup.s pt3_lib_irq_handler.s interrupt_handler.s \
	ootw_graphics/l15final/ootw_c15_final.inc \
	ootw_graphics/l16end/ootw_c16_end.inc \
	ootw_audio/ootw_outro.pt3
	ca65 -o ending.o ending.s -l ending.lst
#####

compress_test.inc:	intro_graphics/07_soda/drinking01.png
	$(PNG2RLE) asm intro_graphics/07_soda/drinking01.png test_rle > compress_test.inc
	$(PNG2LZ4) asm intro_graphics/07_soda/drinking01.png test_lz4 >> compress_test.inc

COMPRESS-TEST:	compress_test.o
	ld65 -o COMPRESS-TEST compress_test.o -C ../linker_scripts/apple2_2000.inc

compress_test.o:	compress_test.s lz4_decode.s compress_test.inc
	ca65 -o compress_test.o compress_test.s -l compress_test.lst


#####

clean:		
		rm -f *~ *.o *.lst *.lz4 HELLO \
			OOTW_C1 OOTW_C2 OOTW_C3 OOTW_C4 INTRO LOADER \
			COMPRESS-TEST AUDIO_TEST \
			intro_data_01 intro_data_04 intro_data_06 \
			intro_data_08 intro_data_09
