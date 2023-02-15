include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	flood.dsk

flood.dsk:	HELLO FLOOD
	cp $(EMPTY_DISK)/empty.dsk flood.dsk
	$(DOS33) -y flood.dsk SAVE A HELLO
	$(DOS33) -y flood.dsk BSAVE -a 0x6800 FLOOD


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


####

FLOOD:	flood.o
	ld65 -o FLOOD flood.o -C $(LINKER_SCRIPTS)/apple2_6800.inc

flood.o:	flood.s
	ca65 -o flood.o flood.s -l flood.lst

####
clean:
	rm -f *~ *.o *.lst HELLO FLOOD
