include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	diamond_xdraw16.dsk

diamond_xdraw16.dsk:	HELLO DIAMOND_XDRAW
	cp $(EMPTYDISK) diamond_xdraw16.dsk
	$(DOS33) -y diamond_xdraw16.dsk SAVE A HELLO
	$(DOS33) -y diamond_xdraw16.dsk BSAVE -a 0xE7 DIAMOND_XDRAW

###

submit:	xdraw16.zip

xdraw16.zip:	DIAMOND_XDRAW diamond_xdraw.s file_id.diz diamond_xdraw16.dsk
	mkdir -p lovebyte2021_diamond_xdraw16
	cp DIAMOND_XDRAW ./lovebyte2021_diamond_xdraw16
	cp diamond_xdraw.s ./lovebyte2021_diamond_xdraw16
	cp file_id.diz ./lovebyte2021_diamond_xdraw16
	cp diamond_xdraw16.dsk ./lovebyte2021_diamond_xdraw16
	cp diamond_xdraw_720p.mp4 ./lovebyte2021_diamond_xdraw16
	zip -r xdraw16.zip lovebyte2021_diamond_xdraw16

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DIAMOND_XDRAW:	diamond_xdraw.o
	ld65 -o DIAMOND_XDRAW diamond_xdraw.o -C ./apple2_e7_zp.inc

diamond_xdraw.o:	diamond_xdraw.s
	ca65 -o diamond_xdraw.o diamond_xdraw.s -l diamond_xdraw.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO DIAMOND_XDRAW *.zip
