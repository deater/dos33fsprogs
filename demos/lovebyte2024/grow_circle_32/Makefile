include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	gcircle.dsk

gcircle.dsk:	HELLO GCIRCLE
	cp $(EMPTYDISK) gcircle.dsk
	$(DOS33) -y gcircle.dsk SAVE A HELLO
	$(DOS33) -y gcircle.dsk BSAVE -a 0xc00 GCIRCLE

###

submit:	gcircle.zip

gcircle.zip:	GCIRCLE gcircle.s file_id.diz gcircle.dsk
	mkdir -p lovebyte2023_gcircle
	cp GCIRCLE ./lovebyte2023_gcircle
	cp gcircle.s ./lovebyte2023_gcircle
	cp file_id.diz ./lovebyte2023_gcircle
	cp gcircle.dsk ./lovebyte2023_gcircle
	cp monitor.txt ./lovebyte2023_gcircle
	cp gcircle_screen.png ./lovebyte2023_gcircle
	cp gcircle_720p.mp4 ./lovebyte2023_gcircle
	zip -r gcircle.zip lovebyte2023_gcircle

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

GCIRCLE:	gcircle.o
	ld65 -o GCIRCLE gcircle.o -C $(LINKERSCRIPTS)/apple2_c00.inc

gcircle.o:	gcircle.s
	ca65 -o gcircle.o gcircle.s -l gcircle.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO GCIRCLE *.zip
