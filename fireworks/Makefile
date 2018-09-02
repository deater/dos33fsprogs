include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d

all:	fireworks.dsk

fireworks.dsk:	FIREWORKS.BAS
	$(DOS33) -y fireworks.dsk SAVE A FIREWORKS.BAS


####

FIREWORKS.BAS:	fireworks.bas
	../asoft_basic-utils/tokenize_asoft < fireworks.bas > FIREWORKS.BAS

clean:		
		rm -f *~ *.o *.lst *.inc FIREWORKS.BAS
