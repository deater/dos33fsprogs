include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	solaris.dsk

solaris.dsk:	HELLO SOLARIS SOLARIS2 SOLARIS3 SOLARIS4 SOLARIS_BOT
	cp $(EMPTYDISK) solaris.dsk
	$(DOS33) -y solaris.dsk SAVE A HELLO
	$(DOS33) -y solaris.dsk BSAVE -a 0xc00 SOLARIS
	$(DOS33) -y solaris.dsk BSAVE -a 0xc00 SOLARIS2
	$(DOS33) -y solaris.dsk BSAVE -a 0xc00 SOLARIS3
	$(DOS33) -y solaris.dsk BSAVE -a 0xc00 SOLARIS4
	$(DOS33) -y solaris.dsk BSAVE -a 0x3F5 SOLARIS_BOT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###


SOLARIS:	solaris.o
	ld65 -o SOLARIS solaris.o -C $(LINKERSCRIPTS)/apple2_c00.inc

solaris.o:	solaris.s
	ca65 -o solaris.o solaris.s -l solaris.lst

###


SOLARIS2:	solaris2.o
	ld65 -o SOLARIS2 solaris2.o -C $(LINKERSCRIPTS)/apple2_c00.inc

solaris2.o:	solaris2.s
	ca65 -o solaris2.o solaris2.s -l solaris2.lst

###

SOLARIS3:	solaris3.o
	ld65 -o SOLARIS3 solaris3.o -C $(LINKERSCRIPTS)/apple2_c00.inc

solaris3.o:	solaris3.s
	ca65 -o solaris3.o solaris3.s -l solaris3.lst

###

SOLARIS4:	solaris4.o
	ld65 -o SOLARIS4 solaris4.o -C $(LINKERSCRIPTS)/apple2_c00.inc

solaris4.o:	solaris4.s
	ca65 -o solaris4.o solaris4.s -l solaris4.lst

###

SOLARIS_BOT:	solaris_bot.o
	ld65 -o SOLARIS_BOT solaris_bot.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

solaris_bot.o:	solaris_bot.s
	ca65 -o solaris_bot.o solaris_bot.s -l solaris_bot.lst



###

clean:	
	rm -f *~ *.o *.lst HELLO SOLARIS SOLARIS2 SOLARIS3 SOLARIS4 SOLARIS_BOT

