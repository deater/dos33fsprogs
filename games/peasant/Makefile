include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts
EMPTY_DISK = ../../empty_disk

all:	peasant.dsk

peasant.dsk:	HELLO PEASANT
	cp $(EMPTY_DISK)/empty.dsk peasant.dsk
	$(DOS33) -y peasant.dsk SAVE A HELLO
	$(DOS33) -y peasant.dsk BSAVE -a 0x6000 PEASANT
###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PEASANT:	peasant.o
	ld65 -o PEASANT peasant.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

peasant.o:	peasant.s graphics/graphics.inc
	ca65 -o peasant.o peasant.s -l peasant.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO PEASANT

