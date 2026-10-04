include ../../Makefile.inc

EMPTY_DISK = ../../empty_disk/empty.dsk
LINKER_SCRIPTS = ../../linker_scripts/
DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
GENERATE_COMMON = ../../utils/symbols/generate_common

all:	space_bars.dsk

space_bars.dsk:	TITLE QBOOT QLOAD LEVEL3_EARTH LEVEL6_SATURN
	cp $(EMPTY_DISK) space_bars.dsk
	$(DOS33_RAW) space_bars.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) space_bars.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) space_bars.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) space_bars.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) space_bars.dsk 3 0 TITLE		0 0
	$(DOS33_RAW) space_bars.dsk 4 0 LEVEL3_EARTH	0 0
	$(DOS33_RAW) space_bars.dsk 8 0 LEVEL6_SATURN	0 0


#space_bars.dsk:	SPACE_BARS HELLO
#	$(DOS33) -y space_bars.dsk SAVE A HELLO
#	$(DOS33) -y space_bars.dsk BSAVE -a 0x6000 SPACE_BARS

####

SPACE_BARS:	space_bars.o
	ld65 -o SPACE_BARS space_bars.o -C ../../linker_scripts/apple2_6000.inc

space_bars.o:	space_bars.s instructions.s \
	level3_earth.s level6_saturn.s \
	game_over.s gr_copy.s text_print.s title.s \
	screen_split.s \
	sprites_table.s sprites_screen.s \
	vapor_lock.s delay_a.s zx02_optim.s \
	graphics/sb_background.zx02 \
	graphics/sb_title_high.zx02 graphics/sb_title_low.zx02 \
	keypress.s zp.inc hardware.inc
	ca65 -o space_bars.o space_bars.s -l space_bars.lst

####

qload.inc:	QLOAD
	$(GENERATE_COMMON) -a 0x1200 -s load_file qload.lst > qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s detect_appleii_model qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_all qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_all_color qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s set_normal qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s set_inverse qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s wait_a_bit qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s move_and_print qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s detect_language_card qload.lst >> qload.inc
#	$(GENERATE_COMMON) -a 0x1200 -s mockingboard_detect qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_bottom qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_bottoms qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_screens qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_top qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s zx02_full_decomp qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s zx_src_h qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s zx_src_l qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s gr_offsets qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s wait_until_keypressed qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s vapor_lock qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s delay_a qload.lst >> qload.inc
	$(GENERATE_COMMON) -a 0x1200 -s clear_gr qload.lst >> qload.inc


####

TITLE:	title.o
	ld65 -o TITLE title.o -C ../../linker_scripts/apple2_6000.inc

title.o:	title.s instructions.s \
	gr_copy.s text_print.s title.s \
	vapor_lock.s delay_a.s zx02_optim.s \
	graphics/sb_title_high.zx02 graphics/sb_title_low.zx02 \
	keypress.s zp.inc hardware.inc qload.inc
	ca65 -o title.o title.s -l title.lst

####

LEVEL3_EARTH:	level3_earth.o
	ld65 -o LEVEL3_EARTH level3_earth.o -C ../../linker_scripts/apple2_6000.inc

level3_earth.o:	level3_earth.s \
	gr_copy.s title.s \
	screen_split.s \
	sprites_table.s sprites_screen.s \
	vapor_lock.s delay_a.s \
	graphics/earth_high.zx02 graphics/earth_low.zx02 \
	keypress.s zp.inc hardware.inc qload.inc
	ca65 -o level3_earth.o level3_earth.s -l level3_earth.lst


####

LEVEL6_SATURN:	level6_saturn.o
	ld65 -o LEVEL6_SATURN level6_saturn.o -C ../../linker_scripts/apple2_6000.inc

level6_saturn.o:	level6_saturn.s \
	gr_copy.s text_print.s title.s \
	screen_split.s \
	sprites_table.s sprites_screen.s \
	vapor_lock.s delay_a.s \
	graphics/sb_background.zx02 \
	keypress.s zp.inc hardware.inc
	ca65 -o level6_saturn.o level6_saturn.s -l level6_saturn.lst

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

####

####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	zp.inc hardware.inc common_defines.inc qload.s \
	gr_offsets.s \
	lc_detect.s gr_fast_clear.s \
	text_print.s start.s
	ca65 -o qload.o qload.s -l qload.lst

#	pt3_lib_detect_model.s pt3_lib_mockingboard_detect.s \
#	pt3_lib_mockingboard_setup.s interrupt_handler.s \
#	pt3_lib_mockingboard_patch.s \


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

#spacebars_title.inc:	./images/spacebars_title_scaled.png
#	$(PNG_TO_40x48D) asm ./images/spacebars_title_scaled.png spacebars_title > spacebars_title.inc

####

###

clean:		
		rm -f *~ *.o *.lst SPACE_BARS TITLE \
			LEVEL3_EARTH LEVEL6_SATURN HELLO \
			qload.inc


