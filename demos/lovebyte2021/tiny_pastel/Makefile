include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	tiny_pastel16.dsk

tiny_pastel16.dsk:	HELLO TINY_PASTEL
	cp $(EMPTYDISK) tiny_pastel16.dsk
	$(DOS33) -y tiny_pastel16.dsk SAVE A HELLO
	$(DOS33) -y tiny_pastel16.dsk BSAVE -a 0x70 TINY_PASTEL

###

submit:	pastel16.zip

pastel16.zip:	TINY_PASTEL tiny_pastel.s file_id.diz tiny_pastel16.dsk
	mkdir -p lovebyte2021_tiny_pastel16
	cp TINY_PASTEL ./lovebyte2021_tiny_pastel16
	cp tiny_pastel.s ./lovebyte2021_tiny_pastel16
	cp file_id.diz ./lovebyte2021_tiny_pastel16
	cp tiny_pastel16.dsk ./lovebyte2021_tiny_pastel16
	cp tiny_pastel_720p.mp4 ./lovebyte2021_tiny_pastel16
	zip -r pastel16.zip lovebyte2021_tiny_pastel16

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TINY_PASTEL:	tiny_pastel.o
	ld65 -o TINY_PASTEL tiny_pastel.o -C ./apple2_70_zp.inc

tiny_pastel.o:	tiny_pastel.s
	ca65 -o tiny_pastel.o tiny_pastel.s -l tiny_pastel.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO TINY_PASTEL *.zip
