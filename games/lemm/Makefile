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


lemm.dsk:	QBOOT QLOAD LEMM LEMM
	cp $(EMPTY_DISK) lemm.dsk
	$(DOS33_RAW) lemm.dsk  0  0 QBOOT      0   1
	$(DOS33_RAW) lemm.dsk  0  2 QBOOT      1   1
	$(DOS33_RAW) lemm.dsk  0  4 QBOOT      2   1
	$(DOS33_RAW) lemm.dsk  1  0 QLOAD      0   0
	$(DOS33_RAW) lemm.dsk  3  0 LEMM       0   0


###

QBOOT:	qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s	qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst

###

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1200.inc

qload.o:	qload.s qboot.inc
	ca65 -o qload.o qload.s -l qload.lst


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

lemm.o:	lemm.s zp.inc hardware.inc \
		graphics/graphics_test.inc graphics/sprites.inc \
		intro_level1.s update_time.s hgr_sprite.s draw_flames.s  \
		draw_door.s move_lemming.s draw_lemming.s \
		hgr_hlin.s hgr_vlin.s update_menu.s \
		interrupt_handler.s keyboard.s draw_pointer.s \
		pointer_sprites.inc \
		level1.s level5.s title.s audio.s letsgo.s
	ca65 -o lemm.o lemm.s -l lemm.lst


####

graphics/graphics_test.inc:
	cd	graphics && make

####

clean:		
	rm -f *~ *.o *.lst HELLO LEMM LEMM_TEST

