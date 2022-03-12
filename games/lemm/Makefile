include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	lemm.dsk

lemm.dsk:	HELLO LEMM LEMM_TEST
	cp $(EMPTY_DISK) lemm.dsk
	$(DOS33) -y lemm.dsk SAVE A HELLO
	$(DOS33) -y lemm.dsk BSAVE -a 0x6000 LEMM
	$(DOS33) -y lemm.dsk BSAVE -a 0x4000 LEMM_TEST


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
		interrupt_handler.s keyboard.s \
		level1.s
	ca65 -o lemm.o lemm.s -l lemm.lst


####

graphics/graphics_test.inc:
	cd	graphics && make

####

clean:		
	rm -f *~ *.o *.lst HELLO LEMM LEMM_TEST

