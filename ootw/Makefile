include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2RLE = ../gr-utils/png2rle
PNG2LZ4 = ../gr-utils/png2lz4


all:	ootw.dsk

ootw.dsk:	HELLO LOADER INTRO OOTW OOTW_C2 COMPRESS-TEST
	$(DOS33) -y ootw.dsk SAVE A HELLO
	$(DOS33) -y ootw.dsk BSAVE -a 0x1800 LOADER
	$(DOS33) -y ootw.dsk BSAVE -a 0x2000 INTRO
	$(DOS33) -y ootw.dsk BSAVE -a 0x2000 OOTW
	$(DOS33) -y ootw.dsk BSAVE -a 0x2000 OOTW_C2
	$(DOS33) -y ootw.dsk BSAVE -a 0x2000 COMPRESS-TEST


####

OOTW:	ootw.o
	ld65 -o OOTW ootw.o -C ../linker_scripts/apple2_2000.inc

ootw.o:	ootw.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s gr_putsprite.s \
	keyboard.s sluggy.s \
	ootw_rope.s earthquake.s ootw_mesa.s \
	ootw_pool.s ootw_cavern.s physicist.s random16.s \
	cutscene_slug.s cutscene_beast.s \
	ootw_pool.inc \
	ootw_cavern.inc ootw_cavern2.inc ootw_cavern3.inc ootw_underwater.inc \
	ootw_rope.inc \
	sprites_physicist.inc sprites_slugs.inc \
	sprites_ootw.inc sprites_beast.inc
	ca65 -o ootw.o ootw.s -l ootw.lst

####

OOTW_C2:	ootw_c2.o
	ld65 -o OOTW_C2 ootw_c2.o -C ../linker_scripts/apple2_2000.inc

ootw_c2.o:	ootw_c2.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s gr_putsprite.s \
	keyboard.s sluggy.s \
	sprites_physicist.inc \
	ootw_c2_cage.s \
	ootw_c2_cage.inc
	ca65 -o ootw_c2.o ootw_c2.s -l ootw_c2.lst


####

INTRO:	intro.o
	ld65 -o INTRO intro.o -C ../linker_scripts/apple2_2000.inc

intro.o:	intro.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s gr_putsprite.s \
	gr_overlay.s \
	keyboard.s random16.s text_print.s \
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
	intro_graphics/09_tunnel/intro_gone.inc
	ca65 -o intro.o intro.s -l intro.lst

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1800.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst

####


HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


#####

ootw_pool.inc:	$(PNG2RLE) another.png
	$(PNG2RLE) asm another.png pool_rle > ootw_pool.inc

ootw_cavern.inc:	$(PNG2RLE) another_cave.png
	$(PNG2RLE) asm another_cave.png cavern_rle > ootw_cavern.inc

ootw_cavern2.inc:	$(PNG2RLE) another_cave2.png
	$(PNG2RLE) asm another_cave2.png cavern2_rle > ootw_cavern2.inc

ootw_cavern3.inc:	$(PNG2RLE) another_cave3.png
	$(PNG2RLE) asm another_cave3.png cavern3_rle > ootw_cavern3.inc

ootw_rope.inc:	$(PNG2RLE) another_rope.png
	$(PNG2RLE) asm another_rope.png rope_rle > ootw_rope.inc

#####

ootw_c2_cage.inc:	$(PNG2RLE) ootw_c2_cage.png
	$(PNG2RLE) asm ootw_c2_cage.png cage_rle > ootw_c2_cage.inc

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
		rm -f *~ *.o *.lst HELLO OOTW OOTW_C2 INTRO LOADER
