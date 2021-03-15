include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	tiny_xdraw16.dsk

tiny_xdraw16.dsk:	HELLO TINY_XDRAW
	cp $(EMPTYDISK) tiny_xdraw16.dsk
	$(DOS33) -y tiny_xdraw16.dsk SAVE A HELLO
	$(DOS33) -y tiny_xdraw16.dsk BSAVE -a 0xE7 TINY_XDRAW

###

submit:	xdraw16.zip

xdraw16.zip:	TINY_XDRAW tiny_xdraw.s file_id.diz tiny_xdraw16.dsk
	mkdir -p lovebyte2021_tiny_xdraw16
	cp TINY_XDRAW ./lovebyte2021_tiny_xdraw16
	cp tiny_xdraw.s ./lovebyte2021_tiny_xdraw16
	cp file_id.diz ./lovebyte2021_tiny_xdraw16
	cp tiny_xdraw16.dsk ./lovebyte2021_tiny_xdraw16
	cp tiny_xdraw_720p.mp4 ./lovebyte2021_tiny_xdraw16
	zip -r xdraw16.zip lovebyte2021_tiny_xdraw16

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TINY_XDRAW:	tiny_xdraw.o
	ld65 -o TINY_XDRAW tiny_xdraw.o -C ./apple2_e7_zp.inc

tiny_xdraw.o:	tiny_xdraw.s
	ca65 -o tiny_xdraw.o tiny_xdraw.s -l tiny_xdraw.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO TINY_XDRAW *.zip
