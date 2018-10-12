include ../../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_RLE = ../gr-utils/png2rle

all:	FASTLD6 RTS

#megademo.dsk:	MEGADEMO
#	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 MEGADEMO
#	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 D_HGRC.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 FS_HGRC.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64C.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x2000 C64_BW.BIN
#	$(DOS33) -y megademo.dsk BSAVE -a 0x4000 C64_UPDATE.BIN

####

FASTLD6:	fastld6.o
	ld65 -o FASTLD6 fastld6.o -C ../../linker_scripts/apple2_800.inc

fastld6.o:	fastld6.s
	ca65 -o fastld6.o fastld6.s -l fastld6.lst

####

RTS:	rts.o
	ld65 -o RTS rts.o -C ../../linker_scripts/apple2_800.inc

rts.o:	rts.s
	ca65 -o rts.o rts.s -l rts.lst

#####


clean:		
		rm -f *~ *.o *.lst FASTLD6
