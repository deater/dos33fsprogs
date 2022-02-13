include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts

all:	rotate.dsk

rotate.dsk:	HELLO ROTATE
	cp $(EMPTYDISK) rotate.dsk
	$(DOS33) -y rotate.dsk SAVE A HELLO
	$(DOS33) -y rotate.dsk BSAVE -a 0x3f5 ROTATE

###

submit:	rotate128.zip

rotate128.zip:	ROTATE rotate.s file_id.diz rotate.dsk
	mkdir -p lovebyte2022_rotate_128
	cp ROTATE ./lovebyte2022_rotate_128
	cp rotate.s ./lovebyte2022_rotate_128
	cp file_id.diz ./lovebyte2022_rotate_128
	cp rotate.dsk ./lovebyte2022_rotate_128
	cp rotate_720p.mp4 ./lovebyte2022_rotate_128
	zip -r rotate128.zip lovebyte2022_rotate_128

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

ROTATE:	rotate.o
	ld65 -o ROTATE rotate.o -C $(LINKERSCRIPTS)/apple2_3f5.inc

rotate.o:	rotate.s
	ca65 -o rotate.o rotate.s -l rotate.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO ROTATE *.zip
