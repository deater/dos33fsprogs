include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk

all:	starpath.dsk ANDOR

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

starpath.dsk:	$(DOS33) HELLO STARPATH.BAS STARPATH STARPATH_HGR
	cp $(EMPTYDISK)/empty.dsk starpath.dsk
	$(DOS33) -y starpath.dsk SAVE A HELLO
	$(DOS33) -y starpath.dsk SAVE A STARPATH.BAS
	$(DOS33) -y starpath.dsk BSAVE -a 0xc00 STARPATH
	$(DOS33) -y starpath.dsk BSAVE -a 0xc00 STARPATH_HGR



###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

STARPATH.BAS:	starpath.bas
	$(TOKENIZE) < starpath.bas > STARPATH.BAS


####

ANDOR:	andor.o
	ld65 -o ANDOR andor.o -C $(LINKERSCRIPTS)/apple2_300.inc

andor.o:	andor.s
	ca65 -o andor.o andor.s -l andor.lst

####

STARPATH:	starpath.o
	ld65 -o STARPATH starpath.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starpath.o:	starpath.s
	ca65 -o starpath.o starpath.s -l starpath.lst

####

STARPATH_HGR:	starpath_hgr.o
	ld65 -o STARPATH_HGR starpath_hgr.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starpath_hgr.o:	starpath_hgr.s
	ca65 -o starpath_hgr.o starpath_hgr.s -l starpath_hgr.lst


###


clean:	
	rm -f *~ *.o HELLO STARPATH.BAS STARPATH STARPATH_HGR *.lst

