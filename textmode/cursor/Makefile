include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2GR = ../../utils/gr-utils/png2gr
PNG2RLE = ../../utils/gr-utils/png2rle
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts
EMPTYDISK = ../../empty_disk

all:	cursor.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

cursor.dsk:	$(DOS33) HELLO CURSOR.BAS CURSOR
	cp $(EMPTYDISK)/empty.dsk cursor.dsk
	$(DOS33) -y cursor.dsk SAVE A HELLO
	$(DOS33) -y cursor.dsk SAVE A CURSOR.BAS
	$(DOS33) -y cursor.dsk BSAVE -a 0x36C CURSOR


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

CURSOR.BAS:	cursor.bas
	$(TOKENIZE) < cursor.bas > CURSOR.BAS

###

CURSOR:	cursor.o
	ld65 -o CURSOR cursor.o -C $(LINKERSCRIPTS)/apple2_36c.inc

cursor.o:	cursor.s
	ca65 -o cursor.o cursor.s -l cursor.lst

###


clean:	
	rm -f *~ *.o HELLO CURSOR *.lst

