include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK00 ATRUS CYAN CAPTURED CHO LEVEL_START

####

DISK00:	disk00.o
	ld65 -o DISK00 disk00.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk00.o:	disk00.s ../zp.inc
	ca65 -o disk00.o disk00.s -l disk00.lst

####

ATRUS:	atrus.o
	ld65 -o ATRUS atrus.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

atrus.o:	atrus.s \
		../zp.inc ../hardware.inc ../qload.inc \
		graphics_atrus/atrus_graphics.inc
	ca65 -o atrus.o atrus.s -l atrus.lst

####

CAPTURED:	captured.o
	ld65 -o CAPTURED captured.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

captured.o:	captured.s \
		flip_pages.s draw_scene.s gr_fade.s \
		../zp.inc ../hardware.inc ../qload.inc \
		graphics_captured/captured_graphics.inc \
		audio/capture.btc.zx02
	ca65 -o captured.o captured.s -l captured.lst

####

CHO:	cho.o
	ld65 -o CHO cho.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

cho.o:	cho.s \
		flip_pages.s draw_scene.s gr_fade.s \
		../zp.inc ../hardware.inc ../qload.inc \
		graphics_cho/cho_graphics.inc \
		audio/capture.btc.zx02
	ca65 -o cho.o cho.s -l cho.lst


####

LEVEL_START:	level_start.o
	ld65 -o LEVEL_START level_start.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_start.o:	level_start.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk00_defines.inc \
		leveldata_start.inc \
		graphics_start/start_graphics.inc
	ca65 -o level_start.o level_start.s -l level_start.lst

####

CYAN:	cyan.o
	ld65 -o CYAN cyan.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

cyan.o:	cyan.s \
		../zp.inc ../hardware.inc ../qload.inc \
		graphics_cyan/cyan_graphics.inc
	ca65 -o cyan.o cyan.s -l cyan.lst


####

audio/capture.btc.zx02:
	cd audio && make

graphics_atrus/atrus_graphics.inc:
	cd graphics_atrus && make

graphics_captured/captured_graphics.inc:
	cd graphics_captured && make

graphics_cho/cho_graphics.inc:
	cd graphics_cho && make

graphics_cyan/cyan_graphics.inc:
	cd graphics_cyan && make

graphics_start/start_graphics.inc:
	cd graphics_start && make

####

clean:		
	rm -f *~ *.o *.lst \
		DISK00 ATRUS CYAN CAPTURED CHO LEVEL_START

####

distclean:
	rm -f *~ *.o *.lst \
		DISK00 ATRUS CYAN CHO LEVEL_START
	cd graphics_atrus && make clean
	cd graphics_cyan && make clean
	cd graphics_captured && make clean
	cd graphics_cho && make clean
	cd graphics_start && make clean
	cd audio && make clean

