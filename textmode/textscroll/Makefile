include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	textscroll.dsk

textscroll.dsk:	HELLO MOVE COMET MOVE_BOT
	cp $(EMPTYDISK) textscroll.dsk
	$(DOS33) -y textscroll.dsk SAVE A HELLO
	$(DOS33) -y textscroll.dsk BSAVE -a 0xC00 MOVE
	$(DOS33) -y textscroll.dsk BSAVE -a 0x372 MOVE_BOT
	$(DOS33) -y textscroll.dsk BSAVE -a 0xC00 COMET

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MOVE: move.o
	ld65 -o MOVE move.o -C $(LINKERSCRIPTS)/apple2_c00.inc

move.o:       move.s
	ca65 -o move.o move.s -l move.lst

###

MOVE_BOT: move_bot.o
	ld65 -o MOVE_BOT move_bot.o -C ./apple2_372.inc

move_bot.o:       move_bot.s
	ca65 -o move_bot.o move_bot.s -l move_bot.lst

###

COMET: comet.o
	ld65 -o COMET comet.o -C $(LINKERSCRIPTS)/apple2_c00.inc

comet.o:       comet.s
	ca65 -o comet.o comet.s -l comet.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO MOVE
