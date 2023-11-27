include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	dots.dsk

dots.dsk:	HELLO DOTS
	cp $(EMPTY_DISK) dots.dsk
	$(DOS33) -y dots.dsk SAVE A HELLO
	$(DOS33) -y dots.dsk BSAVE -a 0xc00 DOTS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

DOTS:	dots.o
	ld65 -o DOTS dots.o -C $(LINKER_DIR)/apple2_c00.inc

dots.o:	dots.s
	ca65 -o dots.o dots.s -l dots.lst


####

clean:		
		rm -f *~ *.o *.lst HELLO DOTS

