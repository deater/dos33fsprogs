include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	music.inc

####

music.inc:	../generate_common MUSIC
	../generate_common -a 0xd000 -s pt3_init_song music.lst > music.inc
	../generate_common -a 0xd000 -s mockingboard_init music.lst >> music.inc
	../generate_common -a 0xd000 -s reset_ay_both music.lst >> music.inc
	../generate_common -a 0xd000 -s clear_ay_both music.lst >> music.inc
	../generate_common -a 0xd000 -s mockingboard_setup_interrupt music.lst >> music.inc
	../generate_common -a 0xd000 -s mockingboard_disable_interrupt music.lst >> music.inc
	../generate_common -a 0xd000 -s done_pt3_irq_handler music.lst >> music.inc
	../generate_common -a 0xd000 -s PT3_LOC music.lst >> music.inc
	../generate_common -a 0xd000 -s intro_knight_zx02 music.lst >> music.inc


###

MUSIC:	music.o
	ld65 -o MUSIC music.o -C $(LINKER_SCRIPTS)/apple2_d000.inc

music.o:	music.s ../zp.inc \
		peasant.pt3 \
		../pt3_lib/pt3_lib_core.s \
		../pt3_lib/pt3_lib_mockingboard_detect.s \
		../pt3_lib/pt3_lib_detect_model.s \
		../pt3_lib/pt3_lib_mockingboard.inc \
		../pt3_lib/pt3_lib_init.s \
		../pt3_lib/pt3_lib_mockingboard_setup.s \
		../pt3_lib/pt3_lib_irq_handler.s \
		../location_knight/graphics_knight/intro_knight.zx02
	ca65 -o music.o music.s -l music.lst


###

../location_knight/graphics_knight/intro_knight.zx02:
	cd ../location_knight/graphics_knight/ && make

###
distclean:
	make clean

###

clean:	
	rm -f *~ *.o *.lst MUSIC music.inc

