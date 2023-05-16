include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	midline.dsk

midline.dsk:	HELLO SATHER
	cp $(EMPTYDISK) midline.dsk
	$(DOS33) -y midline.dsk SAVE A HELLO
	$(DOS33) -y midline.dsk BSAVE -a 0x1f00 SATHER

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SATHER:	sather.o
	ld65 -o SATHER sather.o -C $(LINKERSCRIPTS)/apple2_1f00.inc

sather.o:	sather.s
	ca65 -o sather.o sather.s -l sather.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO SATHER
