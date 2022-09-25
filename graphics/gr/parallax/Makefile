include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	paralax.dsk

paralax.dsk:	HELLO BOXES BOXES_BOT
	cp $(EMPTY_DISK) paralax.dsk
	$(DOS33) -y paralax.dsk SAVE A HELLO
	$(DOS33) -y paralax.dsk BSAVE -a 0xc00 BOXES
	$(DOS33) -y paralax.dsk BSAVE -a 0x3B7 BOXES_BOT

###

BOXES: boxes.o
	ld65 -o BOXES boxes.o -C $(LINKER_DIR)/apple2_c00.inc

boxes.o:	boxes.s
	ca65 -o boxes.o boxes.s -l boxes.lst

###

BOXES_BOT: boxes_bot.o
	ld65 -o BOXES_BOT boxes_bot.o -C $(LINKER_DIR)/apple2_3b7.inc

boxes_bot.o:	boxes_bot.s
	ca65 -o boxes_bot.o boxes_bot.s -l boxes_bot.lst


###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####


clean:		
		rm -f *~ *.o *.lst HELLO BOXES *.zip

