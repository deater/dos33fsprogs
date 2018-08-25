include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d

all:	megademo.dsk

megademo.dsk:	C64C.BIN C64_UPDATE.BIN
	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64C.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64_BW.BIN
	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 C64_UPDATE.BIN


####

C64C.BIN:	c64.bmp
	$(B2D) c64.bmp HGR

clean:		
		rm -f *~ *.o *.lst *.inc C64C.BIN

