include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	tfv.dsk

tfv.dsk:	TITLE.GR ED
	$(DOS33) -y tfv.dsk BSAVE -a 0x400 TITLE.GR
	$(DOS33) -y tfv.dsk BSAVE -a 0x900 ED

ED:	duet.o
	ld65 -o ED duet.o -C ./apple2_900.inc

duet.o:	duet.s
	ca65 -o duet.o duet.s -l duet.lst

TITLE.GR:	title.png
	$(PNG2GR) title.png TITLE.GR

clean:	
	rm -f *~ TITLE.GR *.o *.lst ED
