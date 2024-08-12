include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK38 \
	LEVEL_ENTRY LEVEL_PROJECTOR LEVEL_CLOSE LEVEL_MID

####

DISK38:	disk38.o
	ld65 -o DISK38 disk38.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk38.o:	disk38.s ../zp.inc
	ca65 -o disk38.o disk38.s -l disk38.lst


####

LEVEL_PROJECTOR:	level_projector.o
	ld65 -o LEVEL_PROJECTOR level_projector.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_projector.o:	level_projector.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk38_defines.inc \
		leveldata_projector.inc \
		graphics_projector/projector_graphics.inc
	ca65 -o level_projector.o level_projector.s -l level_projector.lst

####

LEVEL_ENTRY:	level_entry.o
	ld65 -o LEVEL_ENTRY level_entry.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_entry.o:	level_entry.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk38_defines.inc \
		leveldata_entry.inc \
		graphics_entry/entry_graphics.inc
	ca65 -o level_entry.o level_entry.s -l level_entry.lst

####

LEVEL_CLOSE:	level_close.o
	ld65 -o LEVEL_CLOSE level_close.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_close.o:	level_close.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk38_defines.inc \
		leveldata_close.inc \
		graphics_close/close_graphics.inc
	ca65 -o level_close.o level_close.s -l level_close.lst

####

LEVEL_MID:	level_mid.o
	ld65 -o LEVEL_MID level_mid.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

level_mid.o:	level_mid.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk38_defines.inc \
		leveldata_mid.inc \
		graphics_mid/mid_graphics.inc
	ca65 -o level_mid.o level_mid.s -l level_mid.lst




####

graphics_projector/projector_graphics.inc:
	cd graphics_projector && make

graphics_entry/entry_graphics.inc:
	cd graphics_entry && make

graphics_close/close_graphics.inc:
	cd graphics_close && make

graphics_mid/mid_graphics.inc:
	cd graphics_mid && make

####

clean:		
	rm -f *~ *.o *.lst DISK38 \
		LEVEL_PROJECTOR LEVEL_ENTRY LEVEL_CLOSE LEVEL_MID

####

distclean:
	rm -f *~ *.o *.lst DISK38 \
		LEVEL_PROJECTOR LEVEL_ENTRY LEVEL_CLOSE LEVEL_MID
	cd graphics_projector && make clean
	cd graphics_entry && make clean
	cd graphics_close && make clean
	cd graphics_mid && make clean


