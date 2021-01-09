include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	plasma.dsk

plasma.dsk:	HELLO PLASMA
	cp empty.dsk plasma.dsk
	$(DOS33) -y plasma.dsk SAVE A HELLO
	$(DOS33) -y plasma.dsk BSAVE -a 0x1000 PLASMA

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PLASMA:	plasma.o
	ld65 -o PLASMA plasma.o -C $(LINKERSCRIPTS)/apple2_1000.inc

plasma.o:	plasma.s gr_plot.s gr_scrn.s
	ca65 -o plasma.o plasma.s -l plasma.lst

###

clean:	
	rm -f *~ *.o *.lst PLASMA
