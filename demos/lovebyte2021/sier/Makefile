include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	sier64.dsk

submit:	sier64.zip

sier64.zip: SIER_64 sier_64.s file_id.diz sier64.dsk
	mkdir -p lovebyte2021_sier64
	cp SIER_64 ./lovebyte2021_sier64
	cp sier_64.s ./lovebyte2021_sier64
	cp file_id.diz ./lovebyte2021_sier64
	cp sier64.dsk ./lovebyte2021_sier64
	cp sier_720p.mp4 ./lovebyte2021_sier64
	zip -r sier64.zip lovebyte2021_sier64



sier64.dsk:	HELLO SIER_64
	cp $(EMPTY_DISK) sier64.dsk
	$(DOS33) -y sier64.dsk SAVE A HELLO
	$(DOS33) -y sier64.dsk BSAVE -a 0x300 SIER_64

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SIER_64:	sier_64.o
	ld65 -o SIER_64 sier_64.o -C $(LINKERSCRIPTS)/apple2_300.inc

sier_64.o:	sier_64.s
	ca65 -o sier_64.o sier_64.s -l sier_64.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO SIER_64 *.zip
