include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	roto.dsk make_sine_table

roto.dsk:	HELLO ROTO ROTOPLASMA ROTOPLASMA_TINY
	cp empty.dsk roto.dsk
	$(DOS33) -y roto.dsk SAVE A HELLO
	$(DOS33) -y roto.dsk BSAVE -a 0x1000 ROTO
	$(DOS33) -y roto.dsk BSAVE -a 0x1000 ROTOPLASMA
	$(DOS33) -y roto.dsk BSAVE -a 0x1000 ROTOPLASMA_TINY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

ROTO:	roto.o
	ld65 -o ROTO roto.o -C $(LINKERSCRIPTS)/apple2_1000.inc

roto.o:	roto.s rotozoom.s gr_plot.s gr_scrn.s
	ca65 -o roto.o roto.s -l roto.lst

###

ROTOPLASMA:	rotoplasma.o
	ld65 -o ROTOPLASMA rotoplasma.o -C $(LINKERSCRIPTS)/apple2_1000.inc

rotoplasma.o:	rotoplasma.s rotozoom_texture.s plasma.s
	ca65 -o rotoplasma.o rotoplasma.s -l rotoplasma.lst

###

ROTOPLASMA_TINY:	rotoplasma_tiny.o
	ld65 -o ROTOPLASMA_TINY rotoplasma_tiny.o -C $(LINKERSCRIPTS)/apple2_1000.inc

rotoplasma_tiny.o:	rotoplasma_tiny.s rotozoom_texture.s plasma.s
	ca65 -o rotoplasma_tiny.o rotoplasma_tiny.s -l rotoplasma_tiny.lst



###

make_sine_table:	make_sine_table.o
	$(CC) -o make_sine_table make_sine_table.o -lm

make_sine_table.o:	make_sine_table.c
	$(CC) $(CFLAGS) -c make_sine_table.c

###

clean:	
	rm -f *~ *.o *.lst ROTO ROTOPLASMA ROTOPLASMA_TINY make_sine_table
