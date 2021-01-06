include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft


all:	galaxy.dsk

galaxy.dsk:	GALAXY_GR GALAXY_HGR HELLO
	cp empty.dsk galaxy.dsk
	$(DOS33) -y galaxy.dsk SAVE A HELLO
	$(DOS33) -y galaxy.dsk SAVE A GALAXY_GR
	$(DOS33) -y galaxy.dsk SAVE A GALAXY_HGR


########

GALAXY_GR:	galaxy_gr.bas
	$(TOKENIZE) < galaxy_gr.bas > GALAXY_GR

########

GALAXY_HGR:	galaxy_hgr.bas
	$(TOKENIZE) < galaxy_hgr.bas > GALAXY_HGR


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


clean:		
		rm -f *~ *.o *.lst *.inc GALAXY GALAXY_GR GALAXY_HGR
