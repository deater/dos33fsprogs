include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	fakepal128.dsk

submit: fakepal128.zip

fakepal128.zip: FAKEPAL fakepal.s file_id.diz fakepal128.dsk
	mkdir -p lovebyte2021_fakepal128
	cp FAKEPAL ./lovebyte2021_fakepal128
	cp fakepal.s ./lovebyte2021_fakepal128
	cp file_id.diz ./lovebyte2021_fakepal128
	cp fakepal128.dsk ./lovebyte2021_fakepal128
	cp fakepal_720p.mp4 ./lovebyte2021_fakepal128
	zip -r fakepal128.zip lovebyte2021_fakepal128


fakepal128.dsk:	HELLO FAKEPAL
	cp $(EMPTYDISK) fakepal128.dsk
	$(DOS33) -y fakepal128.dsk SAVE A HELLO
	$(DOS33) -y fakepal128.dsk BSAVE -a 0x70 FAKEPAL

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

FAKEPAL:	fakepal.o
	ld65 -o FAKEPAL fakepal.o -C ./apple2_70_zp.inc

fakepal.o:	fakepal.s
	ca65 -o fakepal.o fakepal.s -l fakepal.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO FAKEPAL *.zip

