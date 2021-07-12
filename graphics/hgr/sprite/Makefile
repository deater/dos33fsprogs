include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	sprite.dsk

sprite.dsk:	HELLO SPRITE
	cp $(EMPTY_DISK)/empty.dsk sprite.dsk
	$(DOS33) -y sprite.dsk SAVE A HELLO
	$(DOS33) -y sprite.dsk BSAVE -a 0x6000 SPRITE
###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SPRITE:	sprite.o
	ld65 -o SPRITE sprite.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

sprite.o:	sprite.s graphics/graphics.inc
	ca65 -o sprite.o sprite.s -l sprite.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO SPRITE

