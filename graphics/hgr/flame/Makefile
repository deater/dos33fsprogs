include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	flame.dsk

flame.dsk:	HELLO FLAME FLAMING_CHECKERS
	cp $(EMPTY_DISK)/empty.dsk flame.dsk
	$(DOS33) -y flame.dsk SAVE A HELLO
	$(DOS33) -y flame.dsk BSAVE -a 0x03f5 FLAME
	$(DOS33) -y flame.dsk BSAVE -a 0x0C00 FLAMING_CHECKERS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

FLAME:	flame.o
	ld65 -o FLAME flame.o -C $(LINKER_SCRIPTS)/apple2_3f5.inc

flame.o:	flame.s
	ca65 -o flame.o flame.s -l flame.lst

####

FLAMING_CHECKERS:	flaming_checkers.o
	ld65 -o FLAMING_CHECKERS flaming_checkers.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

flaming_checkers.o:	flaming_checkers.s
	ca65 -o flaming_checkers.o flaming_checkers.s -l flaming_checkers.lst

#####

clean:	
	rm -f *~ *.o *.lst FLAME FLAMING_CHECKERS
