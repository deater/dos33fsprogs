include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	field16.dsk

field16.dsk:	HELLO FIELD16
	cp $(EMPTYDISK) field16.dsk
	$(DOS33) -y field16.dsk SAVE A HELLO
	$(DOS33) -y field16.dsk BSAVE -a 0xE7 FIELD16

###

submit:	field16.zip

field16.zip:	FIELD16 field16.s file_id.diz field16.dsk
	mkdir -p lovebyte2023_field16
	cp FIELD16 ./lovebyte2023_field16
	cp field16.s ./lovebyte2023_field16
	cp file_id.diz ./lovebyte2023_field16
	cp field16.dsk ./lovebyte2023_field16
	cp monitor.txt ./lovebyte2023_field16
	cp field16_720p.mp4 ./lovebyte2023_field16
	cp field16_screen.png ./lovebyte2023_field16
	zip -r field16.zip lovebyte2023_field16

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

FIELD16:	field16.o
	ld65 -o FIELD16 field16.o -C ./apple2_e7_zp.inc

field16.o:	field16.s
	ca65 -o field16.o field16.s -l field16.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO FIELD16 *.zip
