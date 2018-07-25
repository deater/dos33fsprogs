include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33

all:	fancy_lores_viewer.dsk png_to_40x96 katahdin_40_96.inc

fancy_lores_viewer.dsk:	DISP4096
	$(DOS33) -y fancy_lores_viewer.dsk BSAVE -a 0x1000 DISP4096

DISP4096:	disp4096.o
	ld65 -o DISP4096 disp4096.o -C ../linker_scripts/apple2_1000.inc


disp4096.o:	disp4096.s gr_copy.s \
	apple_40_96.inc katahdin_40_96.inc
	ca65 -o disp4096.o disp4096.s -l disp4096.lst

katahdin_40_96.inc:	png_to_40x96 katahdin_40_96.png
	./png_to_40x96 asm katahdin_40_96.png katahdin > katahdin_40_96.inc

apple_40_96.inc:	png_to_40x96 apple_40_96.png
	./png_to_40x96 asm apple_40_96.png apple > apple_40_96.inc

png_to_40x96:		png_to_40x96.o
	$(CC) $(LFLAGS) -lpng -o png_to_40x96 png_to_40x96.o

png_to_40x96.o:		png_to_40x96.c
	$(CC) $(CFLAGS) -c png_to_40x96.c


install:	
		cp png_to_40x96 $(INSTALL_LOC)

clean:		
		rm -f *~ *.o *.lst *.inc png_to_40x96 DISP4096


