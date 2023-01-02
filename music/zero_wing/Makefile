include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	zw.dsk

zw.dsk:	HELLO ZW
	cp $(EMPTY_DISK) zw.dsk
	$(DOS33) -y zw.dsk SAVE A HELLO
	$(DOS33) -y zw.dsk BSAVE -a 0x6000 ZW

####

ZW:	zw.o
	ld65 -o ZW zw.o -C ../../linker_scripts/apple2_6000.inc

zw.o:	zw.s zx02_optim.s \
	text_print.s \
	zp.inc hardware.inc
	ca65 -o zw.o zw.s -l zw.lst

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###


clean:
		rm -f *~ *.o *.lst HELLO ZW
