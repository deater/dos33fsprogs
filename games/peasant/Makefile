include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts
EMPTY_DISK = ../../empty_disk

all:	peasant.dsk

peasant.dsk:	QBOOT QLOAD VID_LOGO TITLE PEASANT COPY_CHECK
	cp $(EMPTY_DISK)/empty.dsk peasant.dsk
#	$(DOS33) -y peasant.dsk BSAVE -a 0x6000 PEASANT
	$(DOS33_RAW) peasant.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) peasant.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) peasant.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) peasant.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) peasant.dsk  3  0 VID_LOGO   0   0
	$(DOS33_RAW) peasant.dsk  10 0 TITLE      0   0
	$(DOS33_RAW) peasant.dsk  17 0 PEASANT    0   0
	$(DOS33_RAW) peasant.dsk  24 0 COPY_CHECK 0   0

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s	qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_e00.inc

qload.o:	qload.s qboot.inc
	ca65 -o qload.o qload.s -l qload.lst

###

VID_LOGO:	intro.o
	ld65 -o VID_LOGO intro.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

intro.o:	vid_logo.s decompress_fast_v2.s hgr_overlay.s \
		graphics_vid/vid_graphics.inc
	ca65 -o intro.o vid_logo.s -l intro.lst

###

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

title.o:	title.s \
		graphics_title/title_graphics.inc \
		graphics_title/altfire.inc \
		directions.s
	ca65 -o title.o title.s -l title.lst

###

PEASANT:	peasant.o
	ld65 -o PEASANT peasant.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant.o:	peasant.s graphics/graphics.inc sprites/peasant_sprite.inc \
		draw_box.s hgr_rectangle.s hgr_font.s hgr_input.s \
		hgr_7x30_sprite.s hgr_1x5_sprite.s hgr_save_restore.s \
		wait_a_bit.s draw_peasant.s \
		title.s directions.s \
		cottage.s lake_w.s lake_e.s river.s knight.s
	ca65 -o peasant.o peasant.s -l peasant.lst

###

COPY_CHECK:	copy_check.o
	ld65 -o COPY_CHECK copy_check.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

copy_check.o:	copy_check.s graphics_copy/copy_graphics.inc \
		hgr_input.s \
		draw_box.s hgr_rectangle.s hgr_font.s \
		copy_check.s
	ca65 -o copy_check.o copy_check.s -l copy_check.lst


###

FONT_TEST:	font_test.o
	ld65 -o FONT_TEST font_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_test.o:	font_test.s hgr_font.s hgr_1x8_sprite.s
	ca65 -o font_test.o font_test.s -l font_test.lst


####

graphics_vid/vid_graphics.inc:
	cd graphics_vid && make

graphics_title/title_graphics.inc:
	cd graphics_title && make


graphics/graphics.inc:
	cd graphics && make

graphics_copy/copy_graphics.inc:
	cd graphics_copy && make


###

clean:	
	rm -f *~ *.o *.lst HELLO VID_LOGO TITLE PEASANT COPY_CHECK

