include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d
PNG_TO_40x48D = ../gr-utils/png_to_40x48d

all:	xmas2019.dsk

xmas2019.dsk:	SNOW HELLO
	cp empty.dsk xmas2019.dsk
	$(DOS33) -y xmas2019.dsk BSAVE -a 0x1000 SNOW
	$(DOS33) -y xmas2019.dsk SAVE A HELLO


####

SNOW:	snow.o
	ld65 -o SNOW snow.o -C ../linker_scripts/apple2_1000.inc

snow.o:	snow.s
#gr_copy.s random16.s fw.s hgr.s delay_a.s \
#		vapor_lock.s gr_hline.s state_machine.s move_letters.s \
#		background_final.inc
	ca65 -o snow.o snow.s -l snow.lst


background_final.inc:	background_final.png
	$(PNG_TO_40x48D) asm background_final.png bg_final > background_final.inc


####

FIREWORKS.BAS:	fireworks.bas
	../asoft_basic-utils/tokenize_asoft < fireworks.bas > FIREWORKS.BAS

####

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


clean:		
		rm -f *~ *.o *.lst *.inc FIREWORKS.BAS
