include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk

all:	raycast.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

raycast.dsk:	$(DOS33) HELLO RAYCAST
	cp $(EMPTYDISK)/empty.dsk raycast.dsk
	$(DOS33) -y raycast.dsk SAVE A HELLO
	$(DOS33) -y raycast.dsk BSAVE -a 0xc00 RAYCAST


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

RAYCAST:	raycast.o
	ld65 -o RAYCAST raycast.o -C $(LINKERSCRIPTS)/apple2_c00.inc

raycast.o:	raycast.s
	ca65 -o raycast.o raycast.s -l raycast.lst

###


clean:	
	rm -f *~ *.o HELLO RAYCAST *.lst

