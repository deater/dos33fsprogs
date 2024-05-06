include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	bubble.dsk

bubble.dsk:	HELLO BUBBLE_TINY BUBBLE_SQUARES BUBBLE_ROM BUBBLE_BLOB
	cp $(EMPTY_DISK)/empty.dsk bubble.dsk
	$(DOS33) -y bubble.dsk SAVE A HELLO
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE_TINY
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE_SQUARES
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE_ROM
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE_BLOB

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BUBBLE_TINY:	bubble_tiny.o
	ld65 -o BUBBLE_TINY bubble_tiny.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble_tiny.o:	bubble_tiny.s
	ca65 -o bubble_tiny.o bubble_tiny.s -l bubble_tiny.lst

###

BUBBLE_SQUARES:	bubble_squares.o
	ld65 -o BUBBLE_SQUARES bubble_squares.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble_squares.o:	bubble_squares.s hgr_clear_codegen.s
	ca65 -o bubble_squares.o bubble_squares.s -l bubble_squares.lst

###

BUBBLE_ROM:	bubble_rom.o
	ld65 -o BUBBLE_ROM bubble_rom.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble_rom.o:	bubble_rom.s
	ca65 -o bubble_rom.o bubble_rom.s -l bubble_rom.lst

###

BUBBLE_BLOB:	bubble_blob.o
	ld65 -o BUBBLE_BLOB bubble_blob.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble_blob.o:	bubble_blob.s
	ca65 -o bubble_blob.o bubble_blob.s -l bubble_blob.lst



###

clean:	
	rm -f *~ *.o *.lst HELLO BUBBLE_TINY BUBBLE_ROM \
		BUBBLE_SQUARES BUBBLE_BLOB

