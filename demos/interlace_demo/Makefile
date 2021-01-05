include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d


all:	interlace.dsk

interlace.dsk:	INTERLACE RASTERBARS HELLO RASTERBARS_SOUND #SPRITES
	$(DOS33) -y interlace.dsk SAVE A HELLO
	$(DOS33) -y interlace.dsk BSAVE -a 0x1000 INTERLACE
	$(DOS33) -y interlace.dsk BSAVE -a 0x1000 RASTERBARS
#	$(DOS33) -y interlace.dsk BSAVE -a 0x1000 SPRITES
	$(DOS33) -y interlace.dsk BSAVE -a 0x1000 RASTERBARS_SOUND

####

HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


####

INTERLACE:	interlace.o
	ld65 -o INTERLACE interlace.o -C ../linker_scripts/apple2_1000.inc

interlace.o:	interlace.s gr_copy.s \
	k_40_48d.inc
	ca65 -o interlace.o interlace.s -l interlace.lst

####

RASTERBARS:	rasterbars.o
	ld65 -o RASTERBARS rasterbars.o -C ../linker_scripts/apple2_1000.inc

rasterbars.o:	rasterbars.s gr_copy.s \
	rasterbars_screen.s rasterbars_table.s movement_table.s rb_bg.inc
	ca65 -o rasterbars.o rasterbars.s -l rasterbars.lst

####

RASTERBARS_SOUND:	rasterbars_sound.o
	ld65 -o RASTERBARS_SOUND rasterbars_sound.o -C ../linker_scripts/apple2_1000.inc

rasterbars_sound.o:	rasterbars_sound.s gr_copy.s \
	rasterbars_screen.s rasterbars_table.s movement_table.s rb_bg.inc \
	pt3_lib_core.s pt3_lib_init.s pt3_lib_mockingboard.s \
	pt3_lib_sample_ornament.s pt3_write_frame.s pt3_lib_calculate_note.s \
	pt3_lib_decode_note.s pt3_lib_make_frame.s pt3_lib_do_frame.s \
	pt3_lib_set_pattern.s
	ca65 -o rasterbars_sound.o rasterbars_sound.s -l rasterbars_sound.lst


####

SPRITES:	sprites.o
	ld65 -o SPRITES sprites.o -C ../linker_scripts/apple2_1000.inc

sprites.o:	sprites.s gr_copy.s \
	sprites_screen.s sprites_table.s movement_table.s earth.inc asteroid.inc
	ca65 -o sprites.o sprites.s -l sprites.lst



####

k_40_48d.inc:	k_40_48d.png
	$(PNG_TO_40x48D) asm k_40_48d.png k > k_40_48d.inc

rb_bg.inc:	rb_bg.png
	$(PNG_TO_40x48D) asm rb_bg.png rb_bg > rb_bg.inc

earth.inc:	earth.png
	$(PNG_TO_40x48D) asm earth.png earth > earth.inc

###


install:	


clean:		
		rm -f *~ *.o *.lst INTERLACE RASTERBARS SPRITES HELLO RASTERBARS_SOUND
