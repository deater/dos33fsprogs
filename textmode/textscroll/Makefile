include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	textscroll.dsk

textscroll.dsk:	HELLO MOVE COMET MOVE_BOT SINE SINE_BOT SCROLL.BAS MATRIX.BAS
	cp $(EMPTYDISK) textscroll.dsk
	$(DOS33) -y textscroll.dsk SAVE A HELLO
	$(DOS33) -y textscroll.dsk SAVE A SCROLL.BAS
	$(DOS33) -y textscroll.dsk SAVE A MATRIX.BAS
	$(DOS33) -y textscroll.dsk BSAVE -a 0xC00 MOVE
	$(DOS33) -y textscroll.dsk BSAVE -a 0x372 MOVE_BOT
	$(DOS33) -y textscroll.dsk BSAVE -a 0xC00 COMET
	$(DOS33) -y textscroll.dsk BSAVE -a 0xC00 SINE
	$(DOS33) -y textscroll.dsk BSAVE -a 0x372 SINE_BOT



###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SCROLL.BAS:	scroll.bas
	$(TOKENIZE) < scroll.bas > SCROLL.BAS

###

MATRIX.BAS:	matrix.bas
	$(TOKENIZE) < matrix.bas > MATRIX.BAS

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

SINE: sine.o
	ld65 -o SINE sine.o -C $(LINKERSCRIPTS)/apple2_c00.inc

sine.o:       sine.s
	ca65 -o sine.o sine.s -l sine.lst


###

SINE_BOT: sine_bot.o
	ld65 -o SINE_BOT sine_bot.o -C ./apple2_372.inc

sine_bot.o:       sine_bot.s
	ca65 -o sine_bot.o sine_bot.s -l sine_bot.lst

###

COMET: comet.o
	ld65 -o COMET comet.o -C $(LINKERSCRIPTS)/apple2_c00.inc

comet.o:       comet.s
	ca65 -o comet.o comet.s -l comet.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO MOVE
