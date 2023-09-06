include ../Makefile.inc

DOS33 = ../utils/dos33fs-utils/dos33
TOKENIZE = ../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../linker_scripts
EMPTYDISK = ../empty_disk/empty.dsk

all:	fac.dsk

fac.dsk:	HELLO ADD
	cp $(EMPTYDISK) fac.dsk
	$(DOS33) -y fac.dsk SAVE A HELLO
	$(DOS33) -y fac.dsk BSAVE -a 0xC00 ADD


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

ADD:	add.o
	ld65 -o ADD add.o -C $(LINKERSCRIPTS)/apple2_c00.inc

add.o:	add.s
	ca65 -o add.o add.s -l add.lst

###

clean:	
	rm -f *~ *.o *.lst ADD HELLO
