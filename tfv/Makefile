include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr
PNG2RLE = ../gr-utils/png2rle

ARTDIR = ./art

all:	tfv.dsk

$(DOS33):	
	cd ../dos33fs-utils && make

tfv.dsk:	$(DOS33) TFV HELLO
	$(DOS33) -y tfv.dsk SAVE A HELLO
	$(DOS33) -y tfv.dsk BSAVE -a 0x1000 TFV
#	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 HIGHWIND.ED
#	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 FIGHTING.ED

###

TFV:	tfv.o
	ld65 -o TFV tfv.o -C ../linker_scripts/apple2_1000.inc

tfv.o:	tfv.s \
	tfv_flying.s tfv_info.s tfv_opener.s tfv_title.s \
	tfv_textentry.s tfv_worldmap.s \
	graphics_map/tfv_backgrounds.inc tfv_sprites.inc tfv_zp.inc \
	../asm_routines/multiply_fast.s \
	gr_fast_clear.s \
	../asm_routines/pageflip.s \
	../asm_routines/gr_setpage.s \
	../asm_routines/keypress.s \
	../asm_routines/gr_putsprite.s \
	../asm_routines/text_print.s \
	../asm_routines/memset.s \
	../asm_routines/gr_vlin.s \
	../asm_routines/gr_copy.s \
	../asm_routines/gr_unrle.s
	ca65 -o tfv.o tfv.s -l tfv.lst

graphics_map/tfv_backgrounds.inc:
	cd graphics_map && make

###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


###

clean:	
	rm -f *~ TITLE.GR *.o *.lst ED TFV

