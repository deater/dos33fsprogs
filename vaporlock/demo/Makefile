include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk/empty.dsk

all:	demo.dsk

demo.dsk:	HELLO MIDLINE GOOD
	cp $(EMPTYDISK) demo.dsk
	$(DOS33) -y demo.dsk SAVE A HELLO
	$(DOS33) -y demo.dsk BSAVE -a 0x6000 MIDLINE
	$(DOS33) -y demo.dsk BSAVE -a 0x6000 GOOD

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MIDLINE:	midline.o
	ld65 -o MIDLINE midline.o -C $(LINKERSCRIPTS)/apple2_6000.inc

midline.o:	midline.s \
	zp.inc hardware.inc sinetable.s
	ca65 -o midline.o midline.s -l midline.lst

###

GOOD:	good.o
	ld65 -o GOOD good.o -C $(LINKERSCRIPTS)/apple2_6000.inc

good.o:	good.s \
	zp.inc hardware.inc sinetable.s
	ca65 -o good.o good.s -l good.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO MIDLINE GOOD
