include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	plasma.dsk

plasma.dsk:	HELLO PLASMA PLASMA_TINY PLASMA_BOT
	cp empty.dsk plasma.dsk
	$(DOS33) -y plasma.dsk SAVE A HELLO
	$(DOS33) -y plasma.dsk BSAVE -a 0x300 PLASMA
	$(DOS33) -y plasma.dsk BSAVE -a 0xC00 PLASMA_TINY
	$(DOS33) -y plasma.dsk BSAVE -a 0x368 PLASMA_BOT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PLASMA:	plasma.o
	ld65 -o PLASMA plasma.o -C $(LINKERSCRIPTS)/apple2_300.inc

plasma.o:	plasma.s
	ca65 -o plasma.o plasma.s -l plasma.lst

###

PLASMA_BOT:	plasma_bot.o
	ld65 -o PLASMA_BOT plasma_bot.o -C ./apple2_368.inc

plasma_bot.o:	plasma_bot.s
	ca65 -o plasma_bot.o plasma_bot.s -l plasma_bot.lst


###

PLASMA_TINY:	plasma_tiny.o
	ld65 -o PLASMA_TINY plasma_tiny.o -C $(LINKERSCRIPTS)/apple2_c00.inc

plasma_tiny.o:	plasma_tiny.s
	ca65 -o plasma_tiny.o plasma_tiny.s -l plasma_tiny.lst


###

clean:	
	rm -f *~ *.o *.lst PLASMA PLASMA_TINY PLASMA_BOT
