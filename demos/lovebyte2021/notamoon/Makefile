include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	notamoon128.dsk

submit:	notamoon128.zip

notamoon128.zip: NOTAMOON notamoon.s file_id.diz notamoon128.dsk
	mkdir -p lovebyte2021_notamoon128
	cp NOTAMOON ./lovebyte2021_notamoon128
	cp notamoon.s ./lovebyte2021_notamoon128
	cp file_id.diz ./lovebyte2021_notamoon128
	cp notamoon128.dsk ./lovebyte2021_notamoon128
	cp notamoon_720p.mp4 ./lovebyte2021_notamoon128
	zip -r notamoon128.zip lovebyte2021_notamoon128

notamoon128.dsk:	HELLO NOTAMOON
	cp $(EMPTYDISK) notamoon128.dsk
	$(DOS33) -y notamoon128.dsk SAVE A HELLO
	$(DOS33) -y notamoon128.dsk BSAVE -a 0x70 NOTAMOON

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

NOTAMOON:	notamoon.o
	ld65 -o NOTAMOON notamoon.o -C ./apple2_70_zp.inc

notamoon.o:	notamoon.s
	ca65 -o notamoon.o notamoon.s -l notamoon.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO NOTAMOON notamoon128.dsk *.zip
