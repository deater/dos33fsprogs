include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	mousetext.dsk

mousetext.dsk:	HELLO MT.BAS SW.BAS FLOPPY.BAS FLOPPY WAVE.BAS WAVE40.BAS
	cp $(EMPTYDISK) mousetext.dsk
	$(DOS33) -y mousetext.dsk SAVE A HELLO
	$(DOS33) -y mousetext.dsk SAVE A MT.BAS
	$(DOS33) -y mousetext.dsk SAVE A SW.BAS
	$(DOS33) -y mousetext.dsk SAVE A WAVE.BAS
	$(DOS33) -y mousetext.dsk SAVE A WAVE40.BAS
	$(DOS33) -y mousetext.dsk SAVE A FLOPPY.BAS
	$(DOS33) -y mousetext.dsk BSAVE -a 0xC00 FLOPPY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MT.BAS:	mt.bas
	$(TOKENIZE) < mt.bas > MT.BAS

###

SW.BAS:	sw.bas
	$(TOKENIZE) < sw.bas > SW.BAS

###

WAVE.BAS:	wave.bas
	$(TOKENIZE) < wave.bas > WAVE.BAS

###

WAVE40.BAS:	wave40.bas
	$(TOKENIZE) < wave40.bas > WAVE40.BAS


###

FLOPPY.BAS:	floppy.bas
	$(TOKENIZE) < floppy.bas > FLOPPY.BAS

###

FLOPPY: floppy.o
	ld65 -o FLOPPY floppy.o -C $(LINKERSCRIPTS)/apple2_c00.inc

floppy.o:       floppy.s
	ca65 -o floppy.o floppy.s -l floppy.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO MT.BAS SW.BAS FLOPPY.BAS FLOPPY WAVE.BAS WAVE40.BAS
