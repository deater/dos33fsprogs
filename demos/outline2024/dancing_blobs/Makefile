include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	dancing_blobs.dsk

dancing_blobs.dsk:	HELLO DANCING_BLOBS DANCING_BLOBS_QUIET
	cp $(EMPTYDISK) dancing_blobs.dsk
	$(DOS33) -y dancing_blobs.dsk SAVE A HELLO
	$(DOS33) -y dancing_blobs.dsk BSAVE -a 0xc00 DANCING_BLOBS
	$(DOS33) -y dancing_blobs.dsk BSAVE -a 0xc00 DANCING_BLOBS_QUIET

###

submit:	dancing_blobs.zip dancing_blobs_small.zip

dancing_blobs.zip:	DANCING_BLOBS dancing_blobs.s file_id.diz dancing_blobs.dsk
	mkdir -p outline2024_dancing_blobs
	cp DANCING_BLOBS ./outline2024_dancing_blobs
	cp dancing_blobs.s ./outline2024_dancing_blobs
	cp file_id.diz ./outline2024_dancing_blobs
	cp dancing_blobs.dsk ./outline2024_dancing_blobs
	cp dancing_blobs_720p.mp4 ./outline2024_dancing_blobs
	cp dancing_blobs_screen.png ./outline2024_dancing_blobs
	zip -r dancing_blobs.zip outline2024_dancing_blobs

###

dancing_blobs_small.zip:	DANCING_BLOBS dancing_blobs.s file_id.diz dancing_blobs.dsk
	mkdir -p outline2024_dancing_blobs_small
	cp DANCING_BLOBS ./outline2024_dancing_blobs_small
	cp dancing_blobs.s ./outline2024_dancing_blobs_small
	cp file_id.diz ./outline2024_dancing_blobs_small
	cp dancing_blobs.dsk ./outline2024_dancing_blobs_small
	zip -r dancing_blobs_small.zip outline2024_dancing_blobs_small

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DANCING_BLOBS:	dancing_blobs.o
	ld65 -o DANCING_BLOBS dancing_blobs.o -C $(LINKERSCRIPTS)/apple2_c00.inc

dancing_blobs.o:	dancing_blobs.s
	ca65 -o dancing_blobs.o dancing_blobs.s -l dancing_blobs.lst

###

DANCING_BLOBS_QUIET:	dancing_blobs_quiet.o
	ld65 -o DANCING_BLOBS_QUIET dancing_blobs_quiet.o -C $(LINKERSCRIPTS)/apple2_c00.inc

dancing_blobs_quiet.o:	dancing_blobs.s
	ca65 -o dancing_blobs_quiet.o dancing_blobs.s -DQUIET=1 -l dancing_blobs_quiet.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO DANCING_BLOBS DANCING_BLOBS_QUIET *.zip
