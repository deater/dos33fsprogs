include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr
PNG2RLE = ../gr-utils/png2rle

ARTDIR = ./art

all:	tfv.dsk

$(DOS33):	
	cd ../dos33fs-utils && make

tfv.dsk:	$(DOS33) HELLO LOADER TFV_TITLE TFV_FLYING TFV_WORLD
	$(DOS33) -y tfv.dsk SAVE A HELLO
	$(DOS33) -y tfv.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 TFV_TITLE
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 TFV_FLYING
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 TFV_WORLD

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1000.inc

loader.o:	loader.s init_vars.s common_defines.inc
	ca65 -o loader.o loader.s -l loader.lst

###

TFV_TITLE:	tfv_title.o
	ld65 -o TFV_TITLE tfv_title.o -C ../linker_scripts/apple2_2000.inc

tfv_title.o:	tfv_title.s \
	gr_vlin.s tfv_opener.s \
	draw_menu.s keyboard.s joystick.s \
	graphics_title/tfv_title.inc
	ca65 -o tfv_title.o tfv_title.s -l tfv_title.lst

###

###

TFV_FLYING:	tfv_flying.o
	ld65 -o TFV_FLYING tfv_flying.o -C ../linker_scripts/apple2_2000.inc

tfv_flying.o:	tfv_flying.s \
	gr_hlin.s gr_putsprite.s \
	tfv_help.s \
	tfv_sprites.inc
	ca65 -o tfv_flying.o tfv_flying.s -l tfv_flying.lst

###

TFV_WORLD:	tfv_world.o
	ld65 -o TFV_WORLD tfv_world.o -C ../linker_scripts/apple2_2000.inc

tfv_world.o:	tfv_world.s \
	tfv_overworld.s tfv_drawmap.s \
	graphics_map/tfv_backgrounds.inc tfv_sprites.inc zp.inc
	ca65 -o tfv_world.o tfv_world.s -l tfv_world.lst

graphics_map/tfv_backgrounds.inc:
	cd graphics_map && make



###

clean:	
	rm -f *~ TITLE.GR *.o *.lst TFV TFV_TITLE TFV_FLYING TFV_WORLD HELLO LOADER

