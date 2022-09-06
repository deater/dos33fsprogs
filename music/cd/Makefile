include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	cd.dsk

cd.dsk:	HELLO HORIZ HORIZ_BOT
	cp $(EMPTYDISK) cd.dsk
	$(DOS33) -y cd.dsk SAVE A HELLO
	$(DOS33) -y cd.dsk BSAVE -a 0xC00 HORIZ
	$(DOS33) -y cd.dsk BSAVE -a 0x370 HORIZ_BOT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

HORIZ:	horiz.o
	ld65 -o HORIZ horiz.o -C $(LINKERSCRIPTS)/apple2_c00.inc

horiz.o:	horiz.s
	ca65 -o horiz.o horiz.s -l horiz.lst

###

HORIZ_BOT:	horiz_bot.o
	ld65 -o HORIZ_BOT horiz_bot.o -C $(LINKERSCRIPTS)/apple2_370.inc

horiz_bot.o:	horiz_bot.s
	ca65 -o horiz_bot.o horiz_bot.s -l horiz_bot.lst


####

clean:	
	rm -f *~ *.o *.lst HORIZ HORIZ_BOT
