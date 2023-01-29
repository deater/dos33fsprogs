include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	field15.dsk

field15.dsk:	HELLO FIELD15
	cp $(EMPTYDISK) field15.dsk
	$(DOS33) -y field15.dsk SAVE A HELLO
	$(DOS33) -y field15.dsk BSAVE -a 0xE7 FIELD15

###

submit:	field15.zip

field1532.zip:	FIELD15 field15.s file_id.diz field15.dsk
	mkdir -p lovebyte2023_field15
	cp FIELD15 ./lovebyte2023_field15
	cp field15.s ./lovebyte2023_field15
	cp file_id.diz ./lovebyte2023_field15
	cp field15.dsk ./lovebyte2023_field15
	cp field15_720p.mp4 ./lovebyte2023_field15
	zip -r field1532.zip lovebyte2023_field15

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

FIELD15:	field15.o
	ld65 -o FIELD15 field15.o -C ./apple2_e7_zp.inc

field15.o:	field15.s
	ca65 -o field15.o field15.s -l field15.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO FIELD15 *.zip
