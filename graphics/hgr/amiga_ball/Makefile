include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	sprite.dsk

sprite.dsk:	HELLO BALL PATTERN TINY
	cp $(EMPTY_DISK) sprite.dsk
	$(DOS33) -y sprite.dsk SAVE A HELLO
	$(DOS33) -y sprite.dsk BSAVE -a 0x0300 BALL
	$(DOS33) -y sprite.dsk BSAVE -a 0x036B PATTERN
	$(DOS33) -y sprite.dsk BSAVE -a 0x070 TINY

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

BALL:	ball.o
	ld65 -o BALL ball.o -C $(LINKER_SCRIPTS)/apple2_300.inc

ball.o:	ball.s
	ca65 -o ball.o ball.s -l ball.lst

###

PATTERN:	pattern.o
	ld65 -o PATTERN pattern.o -C $(LINKER_SCRIPTS)/apple2_3f5.inc

pattern.o:	pattern.s
	ca65 -o pattern.o pattern.s -l pattern.lst

###

TINY:	tiny.o
	ld65 -o TINY tiny.o -C $(LINKER_SCRIPTS)/apple2_70_zp.inc

tiny.o:	tiny.s
	ca65 -o tiny.o tiny.s -l tiny.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO BALL PATTERN TINY
