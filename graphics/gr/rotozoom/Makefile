include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	roto.dsk

roto.dsk:	HELLO ROTO
	cp empty.dsk roto.dsk
	$(DOS33) -y roto.dsk SAVE A HELLO
	$(DOS33) -y roto.dsk BSAVE -a 0x1000 ROTO

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

ROTO:	roto.o
	ld65 -o ROTO roto.o -C $(LINKERSCRIPTS)/apple2_1000.inc

roto.o:	roto.s rotozoom.s gr_plot.s gr_scrn.s
	ca65 -o roto.o roto.s -l roto.lst

###

clean:	
	rm -f *~ *.o *.lst ROTO
