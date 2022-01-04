include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	flyer_512.dsk

flyer_512.dsk:	HELLO FLYER
	cp $(EMPTYDISK) flyer_512.dsk
	$(DOS33) -y flyer_512.dsk SAVE A HELLO
	$(DOS33) -y flyer_512.dsk BSAVE -a 0x800 FLYER

###

submit:	text8.zip

text8.zip:	FLYER flyer.s file_id.diz flyer_512.dsk
	mkdir -p lovebyte2021_flyer_512
	cp FLYER ./lovebyte2021_flyer_512
	cp flyer.s ./lovebyte2021_flyer_512
	cp file_id.diz ./lovebyte2021_flyer_512
	cp flyer_512.dsk ./lovebyte2021_flyer_512
	cp flyer_720p.mp4 ./lovebyte2021_flyer_512
	zip -r text8.zip lovebyte2021_flyer_512

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

FLYER:	flyer.o
	ld65 -o FLYER flyer.o -C ./apple2_800.inc

flyer.o:	flyer.s
	ca65 -o flyer.o flyer.s -l flyer.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO FLYER *.zip
