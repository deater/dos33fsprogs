include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	tfv.dsk

tfv.dsk:	TITLE.GR
	$(DOS33) -y tfv.dsk BSAVE -a 0x400 TITLE.GR


TITLE.GR:	title.png
	$(PNG2GR) title.png TITLE.GR

clean:	
	rm -f *~ TITLE.GR
