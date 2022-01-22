include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	fuzzball_32.dsk

fuzzball_32.dsk:	HELLO FUZZBALL
	cp $(EMPTYDISK) fuzzball_32.dsk
	$(DOS33) -y fuzzball_32.dsk SAVE A HELLO
	$(DOS33) -y fuzzball_32.dsk BSAVE -a 0xE7 FUZZBALL

###

submit:	fuzzball32.zip

fuzzball32.zip:	FUZZBALL fuzzball.s file_id.diz fuzzball_32.dsk
	mkdir -p lovebyte2022_fuzzball_32
	cp FUZZBALL ./lovebyte2022_fuzzball_32
	cp fuzzball.s ./lovebyte2022_fuzzball_32
	cp file_id.diz ./lovebyte2022_fuzzball_32
	cp fuzzball_32.dsk ./lovebyte2022_fuzzball_32
	cp fuzzball_720p.mp4 ./lovebyte2022_fuzzball_32
	zip -r fuzzball32.zip lovebyte2022_fuzzball_32

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

FUZZBALL:	fuzzball.o
	ld65 -o FUZZBALL fuzzball.o -C ./apple2_e7_zp.inc

fuzzball.o:	fuzzball.s
	ca65 -o fuzzball.o fuzzball.s -l fuzzball.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO FUZZBALL *.zip
