include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	xw.dsk

xw.dsk:	HELLO XW XW.BAS
	cp $(EMPTY_DISK) xw.dsk
	$(DOS33) -y xw.dsk SAVE A HELLO
	$(DOS33) -y xw.dsk SAVE A XW.BAS
	$(DOS33) -y xw.dsk BSAVE -a 0x70 XW


###

HELLO:  hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

XW.BAS:  xw.bas
	$(TOKENIZE) < xw.bas > XW.BAS



###

XW:	xw.o
	ld65 -o XW xw.o -C $(LINKER_SCRIPTS)/apple2_70_zp.inc

xw.o:	xw.s
	ca65 -o xw.o xw.s -l xw.lst
###

clean:	
	rm -f *~ *.o *.lst XW
