include ../Makefile.inc

DOS33 = ../utils/dos33fs-utils/dos33
DOS33_RAW = ../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../linker_scripts
EMPTY_DISK = ../empty_disk

all:	keyboard.dsk

keyboard.dsk:	HELLO KEYBOARD
	cp $(EMPTY_DISK)/empty.dsk keyboard.dsk
	$(DOS33) -y keyboard.dsk SAVE A HELLO
	$(DOS33) -y keyboard.dsk BSAVE -a 0xc00 KEYBOARD

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

KEYBOARD:	keyboard.o
	ld65 -o KEYBOARD keyboard.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

keyboard.o:	keyboard.s
	ca65 -o keyboard.o keyboard.s -l keyboard.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO KEYBOARD

