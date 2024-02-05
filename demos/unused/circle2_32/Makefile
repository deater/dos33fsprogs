include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	xcircle.dsk

xcircle.dsk:	HELLO XCIRCLE
	cp $(EMPTYDISK) xcircle.dsk
	$(DOS33) -y xcircle.dsk SAVE A HELLO
	$(DOS33) -y xcircle.dsk BSAVE -a 0xc00 XCIRCLE

###

submit:	xcircle.zip

xcircle.zip:	XCIRCLE xcircle.s file_id.diz xcircle.dsk
	mkdir -p lovebyte2023_xcircle
	cp XCIRCLE ./lovebyte2023_xcircle
	cp xcircle.s ./lovebyte2023_xcircle
	cp file_id.diz ./lovebyte2023_xcircle
	cp xcircle.dsk ./lovebyte2023_xcircle
	cp monitor.txt ./lovebyte2023_xcircle
	cp xcircle_screen.png ./lovebyte2023_xcircle
	cp xcircle_720p.mp4 ./lovebyte2023_xcircle
	zip -r xcircle.zip lovebyte2023_xcircle

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

XCIRCLE:	xcircle.o
	ld65 -o XCIRCLE xcircle.o -C $(LINKERSCRIPTS)/apple2_c00.inc

xcircle.o:	xcircle.s
	ca65 -o xcircle.o xcircle.s -l xcircle.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO XCIRCLE *.zip
