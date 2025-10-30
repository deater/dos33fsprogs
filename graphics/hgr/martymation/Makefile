include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	marty.dsk

marty.dsk:	HELLO ASTEROID MARTY.ORIGINAL OREGON MARTY_TINY WOZ
	cp $(EMPTY_DISK)/empty.dsk marty.dsk
	$(DOS33) -y marty.dsk SAVE A HELLO
	$(DOS33) -y marty.dsk BSAVE -a 0x6000 MARTY.ORIGINAL
	$(DOS33) -y marty.dsk BSAVE -a 0x6000 MARTY_TINY
	$(DOS33) -y marty.dsk BSAVE -a 0x6000 OREGON
	$(DOS33) -y marty.dsk BSAVE -a 0x6000 ASTEROID
	$(DOS33) -y marty.dsk BSAVE -a 0x6000 WOZ

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MARTY.ORIGINAL:	marty_original.o ./graphics/asteroid.inc
	ld65 -o MARTY.ORIGINAL marty_original.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

marty_original.o:	marty_original.s
	ca65 -o marty_original.o marty_original.s -l marty_original.lst

###

ASTEROID:	asteroid.o
	ld65 -o ASTEROID asteroid.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

asteroid.o:	asteroid.s
	ca65 -o asteroid.o asteroid.s -l asteroid.lst

###

WOZ:	woz.o
	ld65 -o WOZ woz.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

woz.o:	woz.s graphics/woz_sprites.inc
	ca65 -o woz.o woz.s -l woz.lst



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
	rm -f *~ *.o *.lst HELLO MARTY.ORIGINAL OREGON MARTY_TINY ASTEROID WOZ
