include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

LINKER_SCRIPTS = ../../../linker_scripts/
EMPTY_DISK = ../../../empty_disk/

all:	letter_test.dsk

letter_test.dsk:	HELLO TEST.BAS LETTER_TEST
	cp $(EMPTY_DISK)/empty.dsk letter_test.dsk
	$(DOS33) -y letter_test.dsk SAVE A HELLO
	$(DOS33) -y letter_test.dsk SAVE A TEST.BAS
	$(DOS33) -y letter_test.dsk BSAVE -a 0x1000 LETTER_TEST


LETTER_TEST: letter_test.o
	ld65 -o LETTER_TEST letter_test.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

letter_test.o:	letter_test.s
	ca65 -o letter_test.o letter_test.s -l letter_test.lst

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TEST.BAS:	test.bas
	$(TOKENIZE) < test.bas > TEST.BAS

###

DSR.BAS:	dsr.bas
	$(TOKENIZE) < dsr.bas > DSR.BAS

####

clean:	
		rm -f *~ *.o *.lst HELLO DSR LETTER_TEST


