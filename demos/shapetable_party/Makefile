include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
B2D = ../../utils/bmp2dhr/b2d
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft


all:	dsr_shape.dsk

dsr_shape.dsk:	HELLO DSRSHAPE
	cp empty.dsk dsr_shape.dsk
	$(DOS33) -y dsr_shape.dsk SAVE A HELLO
#	$(DOS33) -y dsr_shape.dsk SAVE A DSR.BAS
#	$(DOS33) -y dsr_shape.dsk BSAVE -a 0x1000 DSR
	$(DOS33) -y dsr_shape.dsk BSAVE -a 0x1000 DSRSHAPE


DSRSHAPE: dsr_shape.o
	ld65 -o DSRSHAPE dsr_shape.o -C ../../linker_scripts/apple2_1000.inc

dsr_shape.o:	dsr_shape.s
	ca65 -o dsr_shape.o dsr_shape.s -l dsr_shape.lst

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DSR.BAS:	dsr.bas
	$(TOKENIZE) < dsr.bas > DSR.BAS

####

clean:	
		rm -f *~ *.o *.lst HELLO DSR DSRSHAPE


