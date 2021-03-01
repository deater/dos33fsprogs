include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	drops.dsk

drops.dsk:	HELLO DROPS DROPS_TINY DROPS_BOT
	cp $(EMPTY_DISK) drops.dsk
	$(DOS33) -y drops.dsk SAVE A HELLO
	$(DOS33) -y drops.dsk BSAVE -a 0x300 DROPS
	$(DOS33) -y drops.dsk BSAVE -a 0x36B DROPS_BOT
	$(DOS33) -y drops.dsk BSAVE -a 0xC00 DROPS_TINY


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DROPS:	drops.o
	ld65 -o DROPS drops.o -C $(LINKERSCRIPTS)/apple2_300.inc

drops.o:	drops.s
	ca65 -o drops.o drops.s -l drops.lst

###

DROPS_TINY:	drops_tiny.o
	ld65 -o DROPS_TINY drops_tiny.o -C $(LINKERSCRIPTS)/apple2_c00.inc

drops_tiny.o:	drops_tiny.s
	ca65 -o drops_tiny.o drops_tiny.s -l drops_tiny.lst


###

DROPS_BOT:	drops_bot.o
	ld65 -o DROPS_BOT drops_bot.o -C ./apple2_36b.inc

drops_bot.o:	drops_bot.s
	ca65 -o drops_bot.o drops_bot.s -l drops_bot.lst



###

clean:	
	rm -f *~ *.o *.lst HELLO DROPS DROPS_TINY DROPS_BOT
