include ../../../Makefile.inc

COMMON = ..
LINKER_SCRIPTS = ../../../linker_scripts

all:	INTRO

####

INTRO:	intro.o
	ld65 -o INTRO intro.o -C $(LINKER_SCRIPTS)/apple2_1700.inc

intro.o:	intro.s \
	$(COMMON)/gr_copy.s \
	$(COMMON)/gr_fast_clear.s \
	$(COMMON)/gr_pageflip.s \
	$(COMMON)/gr_unrle.s \
	$(COMMON)/gr_putsprite.s \
	$(COMMON)/gr_overlay.s \
	gr_run_sequence.s \
	$(COMMON)/keyboard.s \
	$(COMMON)/random16.s \
	$(COMMON)/text_print.s \
	$(COMMON)/zp.inc \
	intro_01_building.s \
	intro_02_outer_door.s \
	intro_03_elevator.s \
	intro_04_keypad.s \
	intro_05_scanner.s \
	intro_06_console.s \
	intro_07_soda.s \
	graphics/01_building/intro_car.inc \
	graphics/01_building/intro_building.inc \
	graphics/01_building/intro_building_car.inc \
	graphics/02_outer_door/outer_door.inc \
	graphics/02_outer_door/feet.inc \
	graphics/03_elevator/intro_elevator.inc \
	graphics/03_elevator/intro_off_elevator.inc \
	graphics/03_elevator/intro_walking.inc \
	graphics/04_keypad/intro_scanner_door.inc \
	graphics/04_keypad/intro_approach.inc \
	graphics/04_keypad/intro_keypad_bg.inc \
	graphics/04_keypad/intro_hands.inc \
	graphics/04_keypad/intro_opening.inc \
	graphics/05_scanner/intro_scanner.inc \
	graphics/05_scanner/intro_scanning.inc \
	graphics/05_scanner/intro_ai_bg.inc \
	graphics/05_scanner/intro_ai.inc \
	graphics/06_console/intro_desktop.inc \
	graphics/06_console/intro_cursor.inc \
	graphics/06_console/intro_collider.inc \
	graphics/07_soda/intro_open_soda.inc \
	graphics/07_soda/intro_drinking.inc \
	graphics/08_lightning/lightning.inc \
	graphics/09_tunnel/intro_tunnel1.inc \
	graphics/09_tunnel/intro_tunnel2.inc \
	graphics/10_gone/intro_zappo.inc \
	graphics/10_gone/intro_gone.inc
	ca65 -o intro.o intro.s -l intro.lst

####

graphics/01_building/intro_car.inc:
	cd graphics && make

####

clean:	
	rm -f *~ *.o *.lst *.lz4 *.lzsa INTRO \
			intro_data_01 intro_data_04 intro_data_06 \
			intro_data_08 intro_data_09

distclean:
	cd graphics && make clean
