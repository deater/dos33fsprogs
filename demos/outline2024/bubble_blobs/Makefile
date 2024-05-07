include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	bubble_blob.dsk

bubble_blob.dsk:	HELLO BUBBLE_BLOB BUBBLE_BLOB_QUIET
	cp $(EMPTYDISK) bubble_blob.dsk
	$(DOS33) -y bubble_blob.dsk SAVE A HELLO
	$(DOS33) -y bubble_blob.dsk BSAVE -a 0xc00 BUBBLE_BLOB
	$(DOS33) -y bubble_blob.dsk BSAVE -a 0xc00 BUBBLE_BLOB_QUIET

###

submit:	bubble_blob.zip bubble_blob_small.zip

bubble_blob.zip:	BUBBLE_BLOB bubble_blob.s file_id.diz bubble_blob.dsk
	mkdir -p outline2024_bubble_blob
	cp BUBBLE_BLOB ./outline2024_bubble_blob
	cp bubble_blob.s ./outline2024_bubble_blob
	cp file_id.diz ./outline2024_bubble_blob
	cp bubble_blob.dsk ./outline2024_bubble_blob
	cp bubble_blob_720p.mp4 ./outline2024_bubble_blob
	cp bubble_blob_screen.png ./outline2024_bubble_blob
	zip -r bubble_blob.zip outline2024_bubble_blob

###

bubble_blob_small.zip:	BUBBLE_BLOB bubble_blob.s file_id.diz bubble_blob.dsk
	mkdir -p outline2024_bubble_blob_small
	cp BUBBLE_BLOB ./outline2024_bubble_blob_small
	cp bubble_blob.s ./outline2024_bubble_blob_small
	cp file_id.diz ./outline2024_bubble_blob_small
	cp bubble_blob.dsk ./outline2024_bubble_blob_small
	zip -r bubble_blob_small.zip outline2024_bubble_blob_small

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BUBBLE_BLOB:	bubble_blob.o
	ld65 -o BUBBLE_BLOB bubble_blob.o -C $(LINKERSCRIPTS)/apple2_c00.inc

bubble_blob.o:	bubble_blob.s
	ca65 -o bubble_blob.o bubble_blob.s -l bubble_blob.lst

###

BUBBLE_BLOB_QUIET:	bubble_blob_quiet.o
	ld65 -o BUBBLE_BLOB_QUIET bubble_blob_quiet.o -C $(LINKERSCRIPTS)/apple2_c00.inc

bubble_blob_quiet.o:	bubble_blob.s
	ca65 -o bubble_blob_quiet.o bubble_blob.s -DQUIET=1 -l bubble_blob_quiet.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO BUBBLE_BLOB BUBBLE_BLOB_QUIET *.zip
