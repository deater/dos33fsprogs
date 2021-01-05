include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	bgmusic.dsk

bgmusic.dsk:	BGMUSIC HELLO
	cp empty.dsk bgmusic.dsk
	$(DOS33) -y bgmusic.dsk BSAVE -a 0x6000 BGMUSIC
	$(DOS33) -y bgmusic.dsk SAVE A HELLO


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BGMUSIC:	bgmusic.o
	ld65 -o BGMUSIC bgmusic.o -C ../../linker_scripts/apple2_6000.inc

bgmusic.o:	bgmusic.s \
	zp.inc hardware.inc nozp.inc
	ca65 -o bgmusic.o bgmusic.s -l bgmusic.lst

####

clean:	
	rm -f *~ *.o *.lst BGMUSIC
