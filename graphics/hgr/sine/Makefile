include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	plasma_hgr.dsk

plasma_hgr.dsk:	HELLO APPROX_SINE THICK_SINE ROM_SINE
	cp $(EMPTYDISK) plasma_hgr.dsk
	$(DOS33) -y plasma_hgr.dsk SAVE A HELLO
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 APPROX_SINE
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 THICK_SINE
	$(DOS33) -y plasma_hgr.dsk BSAVE -a 0xc00 ROM_SINE


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

APPROX_SINE:	approx_sine.o
	ld65 -o APPROX_SINE approx_sine.o -C $(LINKERSCRIPTS)/apple2_c00.inc

approx_sine.o:	approx_sine.s
	ca65 -o approx_sine.o approx_sine.s -l approx_sine.lst

###

THICK_SINE:	thick_sine.o
	ld65 -o THICK_SINE thick_sine.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thick_sine.o:	thick_sine.s
	ca65 -o thick_sine.o thick_sine.s -l thick_sine.lst

###

ROM_SINE:	rom_sine.o
	ld65 -o ROM_SINE rom_sine.o -C $(LINKERSCRIPTS)/apple2_c00.inc

rom_sine.o:	rom_sine.s
	ca65 -o rom_sine.o rom_sine.s -l rom_sine.lst

###

clean:	
	rm -f *~ *.o *.lst THICK_SINE ROM_SINE APPROX_SINE

