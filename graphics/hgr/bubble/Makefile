include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	bubble.dsk

bubble.dsk:	HELLO BUBBLE.BAS BUBBLE BUBBLE_ORIG DIAMOND
	cp $(EMPTY_DISK)/empty.dsk bubble.dsk
	$(DOS33) -y bubble.dsk SAVE A HELLO
	$(DOS33) -y bubble.dsk SAVE A BUBBLE.BAS
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE_ORIG
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 DIAMOND

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BUBBLE:	bubble.o
	ld65 -o BUBBLE bubble.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble.o:	bubble.s hgr_clear_screen.s
	ca65 -o bubble.o bubble.s -l bubble.lst

###

BUBBLE_ORIG:	bubble_orig.o
	ld65 -o BUBBLE_ORIG bubble_orig.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble_orig.o:	bubble_orig.s
	ca65 -o bubble_orig.o bubble_orig.s -l bubble_orig.lst


###

DIAMOND:	diamond.o
	ld65 -o DIAMOND diamond.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

diamond.o:	diamond.s
	ca65 -o diamond.o diamond.s -l diamond.lst


###

BUBBLE.BAS:	bubble.bas
	$(TOKENIZE) < bubble.bas > BUBBLE.BAS


###

clean:	
	rm -f *~ *.o *.lst BUBBLE.BAS HELLO BUBBLE DIAMOND BUBBLE_ORIG
