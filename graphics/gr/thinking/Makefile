include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	thinking.dsk

thinking.dsk:	HELLO THINKING RAINBOW_BOX
	cp $(EMPTYDISK) thinking.dsk
	$(DOS33) -y thinking.dsk SAVE A HELLO
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 THINKING
	$(DOS33) -y thinking.dsk BSAVE -a 0xC00 RAINBOW_BOX

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

THINKING:	thinking.o
	ld65 -o THINKING thinking.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thinking.o:	thinking.s
	ca65 -o thinking.o thinking.s -l thinking.lst

###

RAINBOW_BOX:	rainbow_box.o
	ld65 -o RAINBOW_BOX rainbow_box.o -C $(LINKERSCRIPTS)/apple2_c00.inc

rainbow_box.o:	rainbow_box.s
	ca65 -o rainbow_box.o rainbow_box.s -l rainbow_box.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO THINKING RAINBOW_BOX
