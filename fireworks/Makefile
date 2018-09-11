include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d
PNG_TO_40x48D = ../gr-utils/png_to_40x48d

all:	fireworks.dsk

fireworks.dsk:	FIREWORKS.BAS FIREWORKS
	$(DOS33) -y fireworks.dsk BSAVE -a 0x1000 FIREWORKS
	$(DOS33) -y fireworks.dsk SAVE A FIREWORKS.BAS


####

FIREWORKS:	fireworks.o
	ld65 -o FIREWORKS fireworks.o -C ../linker_scripts/apple2_1000.inc

fireworks.o:	fireworks.s gr_copy.s random16.s fw.s hgr.s \
		vapor_lock.s gr_hline.s \
		background_final.inc
	ca65 -o fireworks.o fireworks.s -l fireworks.lst


background_final.inc:	background_final.png
	$(PNG_TO_40x48D) asm background_final.png bg_final > background_final.inc


####

FIREWORKS.BAS:	fireworks.bas
	../asoft_basic-utils/tokenize_asoft < fireworks.bas > FIREWORKS.BAS

clean:		
		rm -f *~ *.o *.lst *.inc FIREWORKS.BAS
