include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	rotate.dsk

rotate.dsk:	HELLO ROTATE.BAS ROTATE2.BAS ROTATE
	cp $(EMPTY_DISK) rotate.dsk
	$(DOS33) -y rotate.dsk SAVE A HELLO
	$(DOS33) -y rotate.dsk SAVE A ROTATE.BAS
	$(DOS33) -y rotate.dsk SAVE A ROTATE2.BAS
	$(DOS33) -y rotate.dsk BSAVE -a 0xc00 ROTATE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

ROTATE.BAS:	rotate.bas
	$(TOKENIZE) < rotate.bas > ROTATE.BAS

###

ROTATE2.BAS:	rotate2.bas
	$(TOKENIZE) < rotate2.bas > ROTATE2.BAS

####

ROTATE:	rotate.o
	ld65 -o ROTATE rotate.o -C $(LINKER_DIR)/apple2_c00.inc

rotate.o:	rotate.s
	ca65 -o rotate.o rotate.s -l rotate.lst


####

clean:		
		rm -f *~ *.o *.lst HELLO ROTATE.BAS ROTATE2.BAS ROTATE

