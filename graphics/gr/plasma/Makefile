include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	plasma.dsk

plasma.dsk:	HELLO PLASMA PLASMA2 \
	DIAMONDS STATIC \
	PLASMA_128 PLASMA_TINY PLASMA_BOT WIRES WIRES_BOT
	cp $(EMPTYDISK) plasma.dsk
	$(DOS33) -y plasma.dsk SAVE A HELLO
	$(DOS33) -y plasma.dsk BSAVE -a 0x70 PLASMA
	$(DOS33) -y plasma.dsk BSAVE -a 0x70 PLASMA_128
	$(DOS33) -y plasma.dsk BSAVE -a 0xC00 PLASMA_TINY
	$(DOS33) -y plasma.dsk BSAVE -a 0x36B PLASMA_BOT
	$(DOS33) -y plasma.dsk BSAVE -a 0xC00 WIRES
	$(DOS33) -y plasma.dsk BSAVE -a 0x36B WIRES_BOT
	$(DOS33) -y plasma.dsk BSAVE -a 0xc00 PLASMA2
	$(DOS33) -y plasma.dsk BSAVE -a 0xc00 DIAMONDS
	$(DOS33) -y plasma.dsk BSAVE -a 0xc00 STATIC

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PLASMA:	plasma.o
	ld65 -o PLASMA plasma.o -C ./apple2_70_zp.inc

plasma.o:	plasma.s
	ca65 -o plasma.o plasma.s -l plasma.lst

###

PLASMA2:	plasma2.o
	ld65 -o PLASMA2 plasma2.o -C $(LINKERSCRIPTS)/apple2_c00.inc

plasma2.o:	plasma2.s
	ca65 -o plasma2.o plasma2.s -l plasma2.lst

###

DIAMONDS:	diamonds.o
	ld65 -o DIAMONDS diamonds.o -C $(LINKERSCRIPTS)/apple2_c00.inc

diamonds.o:	diamonds.s
	ca65 -o diamonds.o diamonds.s -l diamonds.lst


###

STATIC:	static.o
	ld65 -o STATIC static.o -C $(LINKERSCRIPTS)/apple2_c00.inc

static.o:	static.s
	ca65 -o static.o static.s -l static.lst



###

PLASMA_128:	plasma_128.o
	ld65 -o PLASMA_128 plasma_128.o -C ./apple2_70_zp.inc

plasma_128.o:	plasma_128.s
	ca65 -o plasma_128.o plasma_128.s -l plasma_128.lst


###

PLASMA_BOT:	plasma_bot.o
	ld65 -o PLASMA_BOT plasma_bot.o -C ./apple2_36b.inc

plasma_bot.o:	plasma_bot.s
	ca65 -o plasma_bot.o plasma_bot.s -l plasma_bot.lst


###

PLASMA_TINY:	plasma_tiny.o
	ld65 -o PLASMA_TINY plasma_tiny.o -C $(LINKERSCRIPTS)/apple2_c00.inc

plasma_tiny.o:	plasma_tiny.s
	ca65 -o plasma_tiny.o plasma_tiny.s -l plasma_tiny.lst

###

WIRES:	wires.o
	ld65 -o WIRES wires.o -C $(LINKERSCRIPTS)/apple2_c00.inc

wires.o:	wires.s
	ca65 -o wires.o wires.s -l wires.lst


###

WIRES_BOT:	wires_bot.o
	ld65 -o WIRES_BOT wires_bot.o -C ./apple2_36b.inc

wires_bot.o:	wires_bot.s
	ca65 -o wires_bot.o wires_bot.s -l wires_bot.lst



###

clean:	
	rm -f *~ *.o *.lst PLASMA PLASMA_128 PLASMA_TINY PLASMA_BOT WIRES WIRES_BOT
