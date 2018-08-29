include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d

all:	megademo.dsk

megademo.dsk:	MEGADEMO
	$(DOS33) -y megademo.dsk BSAVE -a 0x1000 MEGADEMO
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64C.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64_BW.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 C64_UPDATE.BIN

####

MEGADEMO:	megademo.o
	ld65 -o MEGADEMO megademo.o -C ../linker_scripts/apple2_1000.inc

megademo.o:	megademo.s
	ca65 -o megademo.o megademo.s -l megademo.lst


####

C64C.BIN:	c64.bmp
	$(B2D) c64.bmp HGR

clean:		
		rm -f *~ *.o *.lst *.inc MEGADEMO
