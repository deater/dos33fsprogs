include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
B2D = ../bmp2dhr/b2d
PNG_TO_40x48D = ../gr-utils/png_to_40x48d

all:	galaxy.dsk

galaxy.dsk:	GALAXY_GR GALAXY_HGR HELLO
	cp empty.dsk galaxy.dsk
	$(DOS33) -y galaxy.dsk SAVE A HELLO
	$(DOS33) -y galaxy.dsk SAVE A GALAXY_GR
	$(DOS33) -y galaxy.dsk SAVE A GALAXY_HGR


########

GALAXY_GR:	galaxy_gr.bas
	../asoft_basic-utils/tokenize_asoft < galaxy_gr.bas > GALAXY_GR

########

GALAXY_HGR:	galaxy_hgr.bas
	../asoft_basic-utils/tokenize_asoft < galaxy_hgr.bas > GALAXY_HGR


####

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


clean:		
		rm -f *~ *.o *.lst *.inc GALAXY GALAXY_GR GALAXY_HGR
