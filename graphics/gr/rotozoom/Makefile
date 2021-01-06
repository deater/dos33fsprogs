include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	gr.dsk

gr.dsk:	SNOW
	cp empty.dsk gr.dsk
	$(DOS33) -y gr.dsk BSAVE -a 0x0300 SNOW

###

SNOW:	snow.o
	ld65 -o SNOW snow.o -C $(LINKERSCRIPTS)/apple2_300.inc

snow.o:	snow.s
	ca65 -o snow.o snow.s -l snow.lst

###

clean:	
	rm -f *~ *.o *.lst SNOW
