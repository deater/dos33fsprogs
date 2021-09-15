include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	speech.dsk

speech.dsk:	HELLO SSI263_TEST TROGDOR MYST
	cp $(EMPTY_DISK) speech.dsk
	$(DOS33) -y speech.dsk SAVE A HELLO
	$(DOS33) -y speech.dsk BSAVE -a 0x1000 SSI263_TEST
	$(DOS33) -y speech.dsk BSAVE -a 0x1000 TROGDOR
	$(DOS33) -y speech.dsk BSAVE -a 0x1000 MYST

###

SSI263_TEST: ssi263_test.o
	ld65 -o SSI263_TEST ssi263_test.o -C ../../linker_scripts/apple2_1000.inc

ssi263_test.o:	ssi263_test.s ssi263.inc ssi263_detect.s ssi263_speech.s
	ca65 -o ssi263_test.o ssi263_test.s -l ssi263_test.lst

###

TROGDOR: trogdor.o
	ld65 -o TROGDOR trogdor.o -C ../../linker_scripts/apple2_1000.inc

trogdor.o:	trogdor.s ssi263.inc ssi263_detect.s ssi263_simple_speech.s
	ca65 -o trogdor.o trogdor.s -l trogdor.lst

###

MYST: myst.o
	ld65 -o MYST myst.o -C ../../linker_scripts/apple2_1000.inc

myst.o:	myst.s ssi263.inc ssi263_detect.s ssi263_simple_speech.s
	ca65 -o myst.o myst.s -l myst.lst


###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO SSI263_TEST TROGDOR MYST


