include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	a2_inside.dsk

submit:	a2_inside256.zip

a2_inside256.zip:	A2_INSIDE a2_inside.s file_id.diz a2_inside.dsk
	mkdir -p lovebyte2021_a2_inside256
	cp A2_INSIDE ./lovebyte2021_a2_inside256
	cp a2_inside.s ./lovebyte2021_a2_inside256
	cp file_id.diz ./lovebyte2021_a2_inside256
	cp a2_inside.dsk ./lovebyte2021_a2_inside256
	cp a2_inside_720p.mp4 ./lovebyte2021_a2_inside256
	zip -r a2_inside256.zip lovebyte2021_a2_inside256


a2_inside.dsk:	HELLO A2_INSIDE
	cp $(EMPTYDISK) a2_inside.dsk
	$(DOS33) -y a2_inside.dsk SAVE A HELLO
	$(DOS33) -y a2_inside.dsk BSAVE -a 0xC00 A2_INSIDE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

A2_INSIDE:	a2_inside.o
	ld65 -o A2_INSIDE a2_inside.o -C $(LINKERSCRIPTS)/apple2_c00.inc

a2_inside.o:	a2_inside.s
	ca65 -o a2_inside.o a2_inside.s -l a2_inside.lst
###

clean:	
	rm -f *~ *.o *.lst HELLO A2_INSIDE *.zip
