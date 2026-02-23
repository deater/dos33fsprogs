include ../../../../Makefile.inc

DOS33 = ../../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../../empty_disk/empty.dsk
TOKENIZE = ../../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../../linker_scripts/

all:	farm.dsk

farm.dsk:	QBOOT QLOAD \
	qload.inc \
	BG_LOAD \
	ANIMATION
	cp $(EMPTY_DISK) farm.dsk
	$(DOS33_RAW) farm.dsk 0 0 QBOOT		0 1
	$(DOS33_RAW) farm.dsk 0 2 QBOOT		1 1
	$(DOS33_RAW) farm.dsk 0 4 QBOOT		2 1
	$(DOS33_RAW) farm.dsk 1 0 QLOAD		0 0
	$(DOS33_RAW) farm.dsk 2 0 BG_LOAD 0 0
	$(DOS33_RAW) farm.dsk 5 0 ANIMATION 0 0

####

BG_LOAD:	bg_load.o
	ld65 -o BG_LOAD bg_load.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

bg_load.o:	bg_load.s \
	zp.inc ../hardware.inc qload.inc common_defines.inc \
	graphics/a2_gentfish_farm01.hgr.zx02 \
	graphics/a2_gentfish_farm02.hgr.zx02
	ca65 -o bg_load.o bg_load.s -l bg_load.lst


####

ANIMATION:	animation.o
	ld65 -o ANIMATION animation.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

animation.o:	animation.s \
	zp.inc ../hardware.inc qload.inc common_defines.inc \
	graphics/a2_gentfish_farm01.hgr.zx02 \
	graphics/a2_gentfish_farm02.hgr.zx02
	ca65 -o animation.o animation.s -l animation.lst

####

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s  qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst


####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	zp.inc ../hardware.inc common_defines.inc qload.s \
	../gr_offsets.s \
	../wait.s ../wait_a_bit.s \
	../gr_fast_clear.s \
	../text_print.s start.s \
	../hgr_table.s \
	../hgr_page_flip.s \
	../hgr_clear_screen.s
	ca65 -o qload.o qload.s -l qload.lst

####

qload.inc:	../generate_common QLOAD
	../generate_common -a 0x1200 -s load_file qload.lst > qload.inc
	../generate_common -a 0x1200 -s clear_all qload.lst >> qload.inc
	../generate_common -a 0x1200 -s clear_all_color qload.lst >> qload.inc
	../generate_common -a 0x1200 -s set_normal qload.lst >> qload.inc
	../generate_common -a 0x1200 -s set_inverse qload.lst >> qload.inc
	../generate_common -a 0x1200 -s wait qload.lst >> qload.inc
	../generate_common -a 0x1200 -s wait_a_bit qload.lst >> qload.inc
	../generate_common -a 0x1200 -s wait_50ms qload.lst >> qload.inc
	../generate_common -a 0x1200 -s move_and_print qload.lst >> qload.inc
	../generate_common -a 0x1200 -s clear_bottom qload.lst >> qload.inc
	../generate_common -a 0x1200 -s clear_bottoms qload.lst >> qload.inc
	../generate_common -a 0x1200 -s clear_screens qload.lst >> qload.inc
	../generate_common -a 0x1200 -s clear_top qload.lst >> qload.inc
	../generate_common -a 0x1200 -s zx02_full_decomp qload.lst >> qload.inc
	../generate_common -a 0x1200 -s zx_src_h qload.lst >> qload.inc
	../generate_common -a 0x1200 -s zx_src_l qload.lst >> qload.inc
	../generate_common -a 0x1200 -s wait_until_keypress qload.lst >> qload.inc
	../generate_common -a 0x1200 -s wait_50xms qload.lst >> qload.inc
	../generate_common -a 0x1200 -s hgr_page_flip qload.lst >> qload.inc
	../generate_common -a 0x1200 -s gr_offsets qload.lst >> qload.inc
	../generate_common -a 0x1200 -s hgr_clear_screen qload.lst >> qload.inc
	../generate_common -a 0x1200 -s hgr_page1_clearscreen qload.lst >> qload.inc
	../generate_common -a 0x1200 -s hgr_page2_clearscreen qload.lst >> qload.inc



####

generate_common:	generate_common.o
	$(CC) $(LFLAGS) -o generate_common generate_common.o

generate_common.o:	generate_common.c
	$(CC) $(CFLAGS) -c generate_common.c

###


clean:
	rm -f *~ *.o *.lst ANIMATION QBOOT QLOAD BG_LOAD generate_common
	rm -f qload.inc qload2.inc


