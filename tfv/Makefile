include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	tfv.dsk

tfv.dsk:	TITLE.GR TFV ED HIGHWIND.ED FIGHTING.ED
	$(DOS33) -y tfv.dsk BSAVE -a 0x1000 TFV
	$(DOS33) -y tfv.dsk BSAVE -a 0x400 TITLE.GR
	$(DOS33) -y tfv.dsk BSAVE -a 0x900 ED
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 HIGHWIND.ED
	$(DOS33) -y tfv.dsk BSAVE -a 0x2000 FIGHTING.ED

TFV:	tfv.o
	ld65 -o TFV tfv.o -C ./apple2_1000.inc

tfv.o:	tfv.s title.inc
	ca65 -o tfv.o tfv.s -l tfv.lst

ED:	duet.o
	ld65 -o ED duet.o -C ./apple2_900.inc

duet.o:	duet.s
	ca65 -o duet.o duet.s -l duet.lst

TITLE.GR:	title.png
	$(PNG2GR) title.png TITLE.GR

clean:	
	rm -f *~ TITLE.GR *.o *.lst ED

