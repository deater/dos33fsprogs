include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	bubble.dsk

bubble.dsk:	HELLO BUBBLE_TINY
	cp $(EMPTY_DISK)/empty.dsk bubble.dsk
	$(DOS33) -y bubble.dsk SAVE A HELLO
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE_TINY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BUBBLE_TINY:	bubble_tiny.o
	ld65 -o BUBBLE_TINY bubble_tiny.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble_tiny.o:	bubble_tiny.s
	ca65 -o bubble_tiny.o bubble_tiny.s -l bubble_tiny.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO BUBBLE_TINY

