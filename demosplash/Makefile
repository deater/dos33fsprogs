include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2RLE = ../gr-utils/png2rle
PNG2LZ4 = ../gr-utils/png2lz4
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
B2D = ../bmp2dhr/b2d

all:	demosplash.dsk

demosplash.dsk:	HELLO LOADER DEMOSPLASH
	cp empty.dsk demosplash.dsk
	$(DOS33) -y demosplash.dsk SAVE A HELLO
	$(DOS33) -y demosplash.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y demosplash.dsk BSAVE -a 0x1400 DEMOSPLASH
#	$(DOS33) -y demosplash.dsk BSAVE -a 0x1700 MUSICTEST

####


HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


#####

#DEMOSPLASH:	demosplash.o
#	ld65 -o DEMOSPLASH demosplash.o -C ../linker_scripts/apple2_1700.inc

#demosplash.o:	demosplash.s \
#	zp.inc hardware.inc \
#	appleII_intro.s vapor_lock.s delay_a.s \
#	pt3_lib_init.s pt3_lib_core.s pt3_lib_mockingboard.s \
#	interrupt_handler.s \
#	starbase.s starbase_action.s \
#	graphics/starbase/starbase.inc \
#	graphics/sprites/alien.inc graphics/sprites/astronaut.inc \
#	dya_space_demo.pt3 appleII_40_96.inc \
#	book.s book_40_48d.inc \
#	missing.s \
#	escape.s
#	ca65 -o demosplash.o demosplash.s -l demosplash.lst

#####

DEMOSPLASH:	demosplash.o
	ld65 -o DEMOSPLASH demosplash.o -C ../linker_scripts/apple2_1400.inc

demosplash.o:	demosplash.s \
	zp.inc hardware.inc \
	appleII_intro.s font.s \
	pt3_lib_init.s pt3_lib_core.s pt3_lib_mockingboard.s \
	pt3_lib_play_frame.s pt3_lib_write_frame.s \
	interrupt_handler.s \
	missing.s k_40_48d.inc create_update_type1.s \
	open_book.s graphics/book_open/book_open.inc \
	starbase.s starbase_keyboard.s \
	starbase_action.s starbase_laser.s starbase_blast.s \
	gr_run_sequence.s \
	graphics/starbase/starbase.inc \
	graphics/starbase/ship_flames.inc \
	graphics/starbase/star_wipe.inc \
	graphics/sprites/alien.inc graphics/sprites/astronaut.inc \
	escape.s create_update_type2.s offsets_table2.s \
	reading.s book_40_48d.inc \
	credits.s credits_bg.inc offsets_table.s \
	dya_space_demo2.pt3
	ca65 -o demosplash.o demosplash.s -l demosplash.lst


#####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1000.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst


#####

appleII_40_96.inc:	appleII_40_96.png
	$(PNG_TO_40x96)	asm appleII_40_96.png appleII > appleII_40_96.inc

#####


#ball.img.lz4:	ball.img
#	lz4 -f -16 ball.img

#ball.img:	BALLC.BIN
#	cp BALLC.BIN ball.img

BOOK_HGR2C.BIN:	book_hgr2.bmp
	$(B2D) book_hgr2.bmp HGR -d

#####

credits_bg.inc:   credits_bg.png
	$(PNG_TO_40x48D) asm credits_bg.png credits > credits_bg.inc

book_40_48d.inc:   book_40_48d.png
	$(PNG_TO_40x48D) asm book_40_48d.png book > book_40_48d.inc

k_40_48d.inc:   k_40_48d.png
	$(PNG_TO_40x48D) asm k_40_48d.png k > k_40_48d.inc

#####

clean:		
		rm -f *~ *.o *.lst *.lz4 HELLO \
			DEMOSPLASH
