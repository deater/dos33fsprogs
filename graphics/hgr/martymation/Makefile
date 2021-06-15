include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	marty.dsk

marty.dsk:	HELLO MARTY OREGON MARTY_TINY
	cp $(EMPTY_DISK)/empty.dsk marty.dsk
	$(DOS33) -y marty.dsk SAVE A HELLO
	$(DOS33) -y marty.dsk BSAVE -a 0x6000 MARTY
	$(DOS33) -y marty.dsk BSAVE -a 0x6000 MARTY_TINY
	$(DOS33) -y marty.dsk BSAVE -a 0x6000 OREGON

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MARTY:	marty.o ./graphics/asteroid.inc
	ld65 -o MARTY marty.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

marty.o:	marty.s
	ca65 -o marty.o marty.s -l marty.lst

###

MARTY_TINY:	marty_tiny.o
	ld65 -o MARTY_TINY marty_tiny.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

marty_tiny.o:	marty_tiny.s
	ca65 -o marty_tiny.o marty_tiny.s -l marty_tiny.lst


###

OREGON:	oregon.o ./graphics/new.inc
	ld65 -o OREGON oregon.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

oregon.o:	oregon.s
	ca65 -o oregon.o oregon.s -l oregon.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO MARTY OREGON MARTY_TINY
