include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	xdraw2_16.dsk

xdraw2_16.dsk:	HELLO XDRAW2
	cp $(EMPTYDISK) xdraw2_16.dsk
	$(DOS33) -y xdraw2_16.dsk SAVE A HELLO
	$(DOS33) -y xdraw2_16.dsk BSAVE -a 0xE7 XDRAW2

###

submit:	xdraw16.zip

xdraw16.zip:	XDRAW2 xdraw2.s file_id.diz xdraw2_16.dsk
	mkdir -p lovebyte2021_xdraw2_16
	cp XDRAW2 ./lovebyte2021_xdraw2_16
	cp xdraw2.s ./lovebyte2021_xdraw2_16
	cp file_id.diz ./lovebyte2021_xdraw2_16
	cp xdraw2_16.dsk ./lovebyte2021_xdraw2_16
	cp xdraw2_720p.mp4 ./lovebyte2021_xdraw2_16
	zip -r xdraw16.zip lovebyte2021_xdraw2_16

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

XDRAW2:	xdraw2.o
	ld65 -o XDRAW2 xdraw2.o -C ./apple2_e7_zp.inc

xdraw2.o:	xdraw2.s
	ca65 -o xdraw2.o xdraw2.s -l xdraw2.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO XDRAW2 *.zip
