include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	circles.dsk

circles.dsk:	HELLO CIRCLES BRES.BAS BRESBOT.BAS BRESCOOL.BAS
	cp $(EMPTY_DISK)/empty.dsk circles.dsk
	$(DOS33) -y circles.dsk SAVE A HELLO
	$(DOS33) -y circles.dsk SAVE A BRES.BAS
	$(DOS33) -y circles.dsk SAVE A BRESBOT.BAS
	$(DOS33) -y circles.dsk SAVE A BRESCOOL.BAS
	$(DOS33) -y circles.dsk BSAVE -a 0x0C00 CIRCLES

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BRES.BAS:	bres.bas
	$(TOKENIZE) < bres.bas > BRES.BAS

###

BRESBOT.BAS:	bresbot.bas
	$(TOKENIZE) < bresbot.bas > BRESBOT.BAS

###

BRESCOOL.BAS:	brescool.bas
	$(TOKENIZE) < brescool.bas > BRESCOOL.BAS


###

CIRCLES:	circles.o
	ld65 -o CIRCLES circles.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

circles.o:	circles.s
	ca65 -o circles.o circles.s -l circles.lst

###

clean:	
	rm -f *~ *.o *.lst CIRCLES BRES.BAS BRESBOT.BAS BRESCOOL.BAS
