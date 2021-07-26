include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/
EMPTY_DISK = ../../../empty_disk/empty.dsk

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	checkers32.dsk

checkers32.dsk:	HELLO CHECKERS CHECKERS_SMALL CHECKERS_SMALL2 CHECKERS_LINE \
	CHECKERS_QUESTION CHECKERS_RAINBOW CHECKERS_ORIG CHECKERS_2000
	cp $(EMPTY_DISK) checkers32.dsk
	$(DOS33) -y checkers32.dsk SAVE A HELLO
	$(DOS33) -y checkers32.dsk BSAVE -a 0x070 CHECKERS
	$(DOS33) -y checkers32.dsk BSAVE -a 0x070 CHECKERS_SMALL
	$(DOS33) -y checkers32.dsk BSAVE -a 0x070 CHECKERS_SMALL2
	$(DOS33) -y checkers32.dsk BSAVE -a 0x070 CHECKERS_LINE
	$(DOS33) -y checkers32.dsk BSAVE -a 0x070 CHECKERS_RAINBOW
	$(DOS33) -y checkers32.dsk BSAVE -a 0x070 CHECKERS_QUESTION
	$(DOS33) -y checkers32.dsk BSAVE -a 0x070 CHECKERS_ORIG
	$(DOS33) -y checkers32.dsk BSAVE -a 0x2000 CHECKERS_2000


###

CHECKERS: checkers.o
	ld65 -o CHECKERS checkers.o -C $(LINKER_DIR)/apple2_70_zp.inc

checkers.o:	checkers.s
	ca65 -o checkers.o checkers.s -l checkers.lst

###

CHECKERS_2000: checkers_2000.o
	ld65 -o CHECKERS_2000 checkers_2000.o -C $(LINKER_DIR)/apple2_2000.inc

checkers_2000.o:	checkers_2000.s
	ca65 -o checkers_2000.o checkers_2000.s -l checkers_2000.lst


###

CHECKERS_SMALL: checkers_small.o
	ld65 -o CHECKERS_SMALL checkers_small.o -C $(LINKER_DIR)/apple2_70_zp.inc

checkers_small.o:	checkers_small.s
	ca65 -o checkers_small.o checkers_small.s -l checkers_small.lst

###

CHECKERS_LINE: checkers_line.o
	ld65 -o CHECKERS_LINE checkers_line.o -C $(LINKER_DIR)/apple2_70_zp.inc

checkers_line.o:	checkers_line.s
	ca65 -o checkers_line.o checkers_line.s -l checkers_line.lst
###

CHECKERS_QUESTION: checkers_question.o
	ld65 -o CHECKERS_QUESTION checkers_question.o -C $(LINKER_DIR)/apple2_70_zp.inc

checkers_question.o:	checkers_question.s
	ca65 -o checkers_question.o checkers_question.s -l checkers_question.lst

###

CHECKERS_RAINBOW: checkers_rainbow.o
	ld65 -o CHECKERS_RAINBOW checkers_rainbow.o -C $(LINKER_DIR)/apple2_70_zp.inc

checkers_rainbow.o:	checkers_rainbow.s
	ca65 -o checkers_rainbow.o checkers_rainbow.s -l checkers_rainbow.lst

###

CHECKERS_ORIG: checkers_orig.o
	ld65 -o CHECKERS_ORIG checkers_orig.o -C $(LINKER_DIR)/apple2_70_zp.inc

checkers_orig.o:	checkers_orig.s
	ca65 -o checkers_orig.o checkers_orig.s -l checkers_orig.lst


###

CHECKERS_SMALL2: checkers_small2.o
	ld65 -o CHECKERS_SMALL2 checkers_small2.o -C $(LINKER_DIR)/apple2_70_zp.inc

checkers_small2.o:	checkers_small2.s
	ca65 -o checkers_small2.o checkers_small2.s -l checkers_small2.lst


###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


####


clean:		
		rm -f *~ *.o *.lst HELLO CHECKERS CHECKERS_SMALL CHECKERS_SMALL2 CHECKERS_QUESTION CHECKERS_RAINBOW CHECKERS_ORIG CHECKERS_LINE

