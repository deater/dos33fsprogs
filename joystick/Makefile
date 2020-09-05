include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
DOS33_RAW = ../dos33fs-utils/dos33_raw
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d
PNG2RLE = ../gr-utils/png2rle
B2D = ../bmp2dhr/b2d

all:	js.dsk

js.dsk:	JS
	cp empty.dsk js.dsk
	$(DOS33) -y js.dsk BSAVE -a 0x1000 JS

####

JS:	js_test.o
	ld65 -o JS js_test.o -C ../linker_scripts/apple2_1000.inc

js_test.o:	js_test.s keyboard.s joystick.s
	ca65 -o js_test.o js_test.s -l js_test.lst

####

clean:		
	rm -f *~ *.o *.lst JS
