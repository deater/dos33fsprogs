include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	wargames.dsk

wargames.dsk:	HELLO WARGAMES
	cp $(EMPTY_DISK) speech.dsk
	$(DOS33) -y speech.dsk SAVE A HELLO
	$(DOS33) -y speech.dsk BSAVE -a 0x1000 WARGAMES

###

WARGAMES: wargames.o
	ld65 -o WARGAMES wargames.o -C ../../linker_scripts/apple2_1000.inc

wargames.o:	wargames.s ssi263.inc ssi263_detect.s ssi263_simple_speech.s
	ca65 -o wargames.o wargames.s -l wargames.lst


###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO WARGAMES


