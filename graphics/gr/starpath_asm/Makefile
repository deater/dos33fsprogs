include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk

all:	starpath_asm.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

starpath_asm.dsk:	$(DOS33) HELLO STARPATH STARPATH_SMALL \
	STARPATH_HGR STARPATH_256 STARPATH_LONG STARPATH_NOMUL
	cp $(EMPTYDISK)/empty.dsk starpath_asm.dsk
	$(DOS33) -y starpath_asm.dsk SAVE A HELLO
	$(DOS33) -y starpath_asm.dsk BSAVE -a 0xc00 STARPATH
	$(DOS33) -y starpath_asm.dsk BSAVE -a 0xc00 STARPATH_SMALL
	$(DOS33) -y starpath_asm.dsk BSAVE -a 0xc00 STARPATH_HGR
	$(DOS33) -y starpath_asm.dsk BSAVE -a 0xc00 STARPATH_256
	$(DOS33) -y starpath_asm.dsk BSAVE -a 0xc00 STARPATH_LONG
	$(DOS33) -y starpath_asm.dsk BSAVE -a 0xc00 STARPATH_NOMUL

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

STARPATH:	starpath.o
	ld65 -o STARPATH starpath.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starpath.o:	starpath.s
	ca65 -o starpath.o starpath.s -l starpath.lst

###

STARPATH_SMALL:	starpath_small.o
	ld65 -o STARPATH_SMALL starpath_small.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starpath_small.o:	starpath_small.s
	ca65 -o starpath_small.o starpath_small.s -l starpath_small.lst

###

STARPATH_HGR:	starpath_hgr.o
	ld65 -o STARPATH_HGR starpath_hgr.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starpath_hgr.o:	starpath_hgr.s
	ca65 -o starpath_hgr.o starpath_hgr.s -l starpath_hgr.lst

###

STARPATH_256:	starpath_256.o
	ld65 -o STARPATH_256 starpath_256.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starpath_256.o:	starpath_256.s
	ca65 -o starpath_256.o starpath_256.s -l starpath_256.lst

###

STARPATH_LONG:	starpath_long.o
	ld65 -o STARPATH_LONG starpath_long.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starpath_long.o:	starpath_long.s
	ca65 -o starpath_long.o starpath_long.s -l starpath_long.lst

###

STARPATH_NOMUL:	starpath_nomul.o
	ld65 -o STARPATH_NOMUL starpath_nomul.o -C $(LINKERSCRIPTS)/apple2_c00.inc

starpath_nomul.o:	starpath_nomul.s
	ca65 -o starpath_nomul.o starpath_nomul.s -l starpath_nomul.lst




####

clean:	
	rm -f *~ *.o HELLO STARPATH STARPATH_SMALL STARPATH_HGR \
		STARPATH_LONG STARPATH_256 STARPATH_NOMUL *.lst

