include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	starfield.dsk

starfield.dsk:	HELLO STARS FASTAR STARBOT STARTINY STAROOPS
	cp $(EMPTY_DISK)/empty.dsk starfield.dsk
	$(DOS33) -y starfield.dsk SAVE A HELLO
	$(DOS33) -y starfield.dsk BSAVE -a 0x0300 STARS
	$(DOS33) -y starfield.dsk BSAVE -a 0x0C00 FASTAR
	$(DOS33) -y starfield.dsk BSAVE -a 0x036C STARBOT
	$(DOS33) -y starfield.dsk BSAVE -a 0x0C00 STARTINY
	$(DOS33) -y starfield.dsk BSAVE -a 0x0374 STAROOPS

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

FASTAR:	fastar.o
	ld65 -o FASTAR fastar.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

fastar.o:	fastar.s
	ca65 -o fastar.o fastar.s -l fastar.lst


###

STARS:	stars.o
	ld65 -o STARS stars.o -C $(LINKER_SCRIPTS)/apple2_300.inc

stars.o:	stars.s
	ca65 -o stars.o stars.s -l stars.lst

###

STARBOT:	starbot.o
	ld65 -o STARBOT starbot.o -C $(LINKER_SCRIPTS)/apple2_36c.inc

starbot.o:	starbot.s
	ca65 -o starbot.o starbot.s -l starbot.lst

###

STARTINY:	startiny.o
	ld65 -o STARTINY startiny.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

startiny.o:	startiny.s
	ca65 -o startiny.o startiny.s -l startiny.lst

###

STAROOPS:	staroops.o
	ld65 -o STAROOPS staroops.o -C $(LINKER_SCRIPTS)/apple2_374.inc

staroops.o:	staroops.s
	ca65 -o staroops.o staroops.s -l staroops.lst



###

clean:	
	rm -f *~ *.o *.lst STARS FASTAR
