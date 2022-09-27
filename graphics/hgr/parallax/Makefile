include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	paralax.dsk

paralax.dsk:	HELLO BOXES PAR WEIRD
	cp $(EMPTY_DISK) paralax.dsk
	$(DOS33) -y paralax.dsk SAVE A HELLO
	$(DOS33) -y paralax.dsk BSAVE -a 0xc00 BOXES
#	$(DOS33) -y paralax.dsk BSAVE -a 0x3B7 BOXES_BOT
#	$(DOS33) -y paralax.dsk BSAVE -a 0xc00 LARGE
#	$(DOS33) -y paralax.dsk BSAVE -a 0x386 LARGE_BOT
	$(DOS33) -y paralax.dsk BSAVE -a 0x3f5 PAR
#	$(DOS33) -y paralax.dsk BSAVE -a 0x37B PAR_BOT
	$(DOS33) -y paralax.dsk BSAVE -a 0xc00 WEIRD

###

BOXES: boxes.o
	ld65 -o BOXES boxes.o -C $(LINKER_DIR)/apple2_c00.inc

boxes.o:	boxes.s
	ca65 -o boxes.o boxes.s -l boxes.lst

###

LARGE: large.o
	ld65 -o LARGE large.o -C $(LINKER_DIR)/apple2_c00.inc

large.o:	large.s
	ca65 -o large.o large.s -l large.lst

###

PAR: par.o
	ld65 -o PAR par.o -C $(LINKER_DIR)/apple2_3f5.inc

par.o:	par.s
	ca65 -o par.o par.s -l par.lst


###

WEIRD: weird.o
	ld65 -o WEIRD weird.o -C $(LINKER_DIR)/apple2_c00.inc

weird.o:	weird.s
	ca65 -o weird.o weird.s -l weird.lst




###

BOXES_BOT: boxes_bot.o
	ld65 -o BOXES_BOT boxes_bot.o -C $(LINKER_DIR)/apple2_3b7.inc

boxes_bot.o:	boxes_bot.s
	ca65 -o boxes_bot.o boxes_bot.s -l boxes_bot.lst


###

LARGE_BOT: large_bot.o
	ld65 -o LARGE_BOT large_bot.o -C $(LINKER_DIR)/apple2_386.inc

large_bot.o:	large_bot.s
	ca65 -o large_bot.o large_bot.s -l large_bot.lst

###

PAR_BOT: par_bot.o
	ld65 -o PAR_BOT par_bot.o -C $(LINKER_DIR)/apple2_37b.inc

par_bot.o:	par_bot.s
	ca65 -o par_bot.o par_bot.s -l par_bot.lst


###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####


clean:		
		rm -f *~ *.o *.lst HELLO BOXES BOXES_BOT LARGE LARGE_BOT PAR PAR_BOT

