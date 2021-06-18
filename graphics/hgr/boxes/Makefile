include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	boxes.dsk make_boxes_asm

boxes.dsk:	HELLO MYST.BAS MYST_TINY.BAS MYST_TINY COOL_PATTERN COOL_BOT
	cp $(EMPTYDISK) boxes.dsk
	$(DOS33) -y boxes.dsk SAVE A HELLO
	$(DOS33) -y boxes.dsk SAVE A MYST.BAS
	$(DOS33) -y boxes.dsk SAVE A MYST_TINY.BAS
	$(DOS33) -y boxes.dsk BSAVE -a 0xC00 MYST_TINY
	$(DOS33) -y boxes.dsk BSAVE -a 0xC00 COOL_PATTERN
	$(DOS33) -y boxes.dsk BSAVE -a 0x370 COOL_BOT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

MYST_TINY:	myst_tiny.o
	ld65 -o MYST_TINY myst_tiny.o -C $(LINKERSCRIPTS)/apple2_c00.inc

myst_tiny.o: myst_tiny.s
	ca65 -o myst_tiny.o myst_tiny.s -l myst_tiny.lst

###

COOL_PATTERN:	cool_pattern.o
	ld65 -o COOL_PATTERN cool_pattern.o -C $(LINKERSCRIPTS)/apple2_c00.inc

cool_pattern.o: cool_pattern.s
	ca65 -o cool_pattern.o cool_pattern.s -l cool_pattern.lst

###

COOL_BOT:	cool_bot.o
	ld65 -o COOL_BOT cool_bot.o -C $(LINKERSCRIPTS)/apple2_370.inc

cool_bot.o: cool_bot.s
	ca65 -o cool_bot.o cool_bot.s -l cool_bot.lst




###

MYST.BAS:	myst.bas
	$(TOKENIZE) < myst.bas > MYST.BAS

###

MYST_TINY.BAS:	myst_tiny.bas
	$(TOKENIZE) < myst_tiny.bas > MYST_TINY.BAS


###

make_boxes:	make_boxes.o
	$(CC) -o make_boxes make_boxes.o $(LFLAGS)

make_boxes.o:	make_boxes.c
	$(CC) $(CFLAGS) -c make_boxes.c

###

make_boxes_asm:	make_boxes_asm.o
	$(CC) -o make_boxes_asm make_boxes_asm.o $(LFLAGS)

make_boxes_asm.o:	make_boxes_asm.c
	$(CC) $(CFLAGS) -c make_boxes_asm.c

###

clean:	
	rm -f *~ *.o *.lst MYST.BAS MYST_TINY.BAS MYST_TINY make_boxes make_boxes_asm COOL_PATTERN
