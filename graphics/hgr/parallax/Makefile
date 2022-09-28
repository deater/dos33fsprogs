include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	paralax.dsk

paralax.dsk:	HELLO BOXES PAR WEIRD WEIRD2 SIER SIER_FAST
	cp $(EMPTY_DISK) paralax.dsk
	$(DOS33) -y paralax.dsk SAVE A HELLO
	$(DOS33) -y paralax.dsk BSAVE -a 0xc00 BOXES
	$(DOS33) -y paralax.dsk BSAVE -a 0x3f5 PAR
	$(DOS33) -y paralax.dsk BSAVE -a 0xc00 WEIRD
	$(DOS33) -y paralax.dsk BSAVE -a 0xc00 WEIRD2
	$(DOS33) -y paralax.dsk BSAVE -a 0xc00 SIER
	$(DOS33) -y paralax.dsk BSAVE -a 0xc00 SIER_FAST

###

BOXES: boxes.o
	ld65 -o BOXES boxes.o -C $(LINKER_DIR)/apple2_c00.inc

boxes.o:	boxes.s
	ca65 -o boxes.o boxes.s -l boxes.lst


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

WEIRD2: weird2.o
	ld65 -o WEIRD2 weird2.o -C $(LINKER_DIR)/apple2_c00.inc

weird2.o:	weird2.s
	ca65 -o weird2.o weird2.s -l weird2.lst


###

SIER: sier.o
	ld65 -o SIER sier.o -C $(LINKER_DIR)/apple2_c00.inc

sier.o:	sier.s
	ca65 -o sier.o sier.s -l sier.lst






###

SIER_FAST: sier_fast.o
	ld65 -o SIER_FAST sier_fast.o -C $(LINKER_DIR)/apple2_c00.inc

sier_fast.o:	sier_fast.s
	ca65 -o sier_fast.o sier_fast.s -l sier_fast.lst

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####


clean:		
		rm -f *~ *.o *.lst HELLO BOXES BOXES_BOT LARGE LARGE_BOT PAR PAR_BOT

