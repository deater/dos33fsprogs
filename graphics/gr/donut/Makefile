include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	donut.dsk

donut.dsk:	HELLO DONUT
	cp $(EMPTY_DISK) donut.dsk
	$(DOS33) -y donut.dsk SAVE A HELLO
	$(DOS33) -y donut.dsk BSAVE -a 0xc00 DONUT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

DONUT:	donut.o
	ld65 -o DONUT donut.o -C $(LINKER_DIR)/apple2_c00.inc

donut.o:	donut.s
	ca65 -o donut.o donut.s -l donut.lst


####

clean:		
		rm -f *~ *.o *.lst HELLO DONUT

