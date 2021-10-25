include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	plasma_hgr.dsk

plasma_hgr.dsk:	HELLO OVAL PURPLE_WAVES
	cp $(EMPTYDISK) plasma_hgr.dsk
	$(DOS33) -y plasma_hgr.dsk SAVE A HELLO
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 OVAL
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 PURPLE_WAVES

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

OVAL:	oval.o
	ld65 -o OVAL oval.o -C $(LINKERSCRIPTS)/apple2_c00.inc

oval.o:	oval.s
	ca65 -o oval.o oval.s -l oval.lst

###

PURPLE_WAVES:	purple_waves.o
	ld65 -o PURPLE_WAVES purple_waves.o -C $(LINKERSCRIPTS)/apple2_c00.inc

purple_waves.o:	purple_waves.s
	ca65 -o purple_waves.o purple_waves.s -l purple_waves.lst

###

clean:	
	rm -f *~ *.o *.lst OVAL PURPLE_WAVES

