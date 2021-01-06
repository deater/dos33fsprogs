include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft



all:	xmas2019.dsk sine_table

xmas2019.dsk:	SNOW TREE XMAS2019 XMAS2019_LZ4 LOADER HELLO
	cp empty.dsk xmas2019.dsk
	$(DOS33) -y xmas2019.dsk SAVE A HELLO
	$(DOS33) -y xmas2019.dsk BSAVE -a 0x4000 XMAS2019
	$(DOS33) -y xmas2019.dsk BSAVE -a 0x2000 XMAS2019_LZ4
	$(DOS33) -y xmas2019.dsk BSAVE -a 0x1000 SNOW
	$(DOS33) -y xmas2019.dsk BSAVE -a 0x1000 TREE
	$(DOS33) -y xmas2019.dsk BSAVE -a 0x800 LOADER

####

TREE:	tree.o
	ld65 -o TREE tree.o -C ../../linker_scripts/apple2_1000.inc

tree.o:	tree.s
#gr_copy.s random16.s fw.s hgr.s delay_a.s \
#		vapor_lock.s gr_hline.s state_machine.s move_letters.s \
#		background_final.inc
	ca65 -o tree.o tree.s -l tree.lst

####

SNOW:	snow.o
	ld65 -o SNOW snow.o -C ../../linker_scripts/apple2_1000.inc

snow.o:	snow.s
#gr_copy.s random16.s fw.s hgr.s delay_a.s \
#		vapor_lock.s gr_hline.s state_machine.s move_letters.s \
#		background_final.inc
	ca65 -o snow.o snow.s -l snow.lst

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../../linker_scripts/apple2_800.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst


####

XMAS2019:	xmas2019.o
	ld65 -o XMAS2019 xmas2019.o -C ../../linker_scripts/apple2_4000.inc

xmas2019.o:	xmas2019.s \
	delay_a.s vapor_lock.s message.inc gr_unrle.s sines.inc \
	move_letters.s letters.s \
	pt3_lib_mockingboard_setup.s pt3_lib_core.s pt3_lib_init.s
	ca65 -o xmas2019.o xmas2019.s -l xmas2019.lst

####

XMAS2019_LZ4:	XMAS2019
	lz4 -f -16 XMAS2019 XMAS2019_LZ4

#####

message.inc:      message.png
	$(PNG_TO_40x96) asm message.png message > message.inc


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

sine_table:	sine_table.o
	$(CC) -o sine_table sine_table.o -lm

sine_table.o:	sine_table.c
	$(CC) -c sine_table.c

####

clean:		
		rm -f *~ *.o *.lst XMAS2019 LOADER HELLO sine_table
