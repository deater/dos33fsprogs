include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
B2D = ../../utils/bmp2dhr/b2d
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	polly.dsk

polly.dsk:	HELLO POLLY BOOP REPO REPO2
	cp $(EMPTY_DISK) polly.dsk
	$(DOS33) -y polly.dsk SAVE A HELLO
	$(DOS33) -y polly.dsk BSAVE -a 0x1000 POLLY
	$(DOS33) -y polly.dsk BSAVE -a 0x1000 BOOP
	$(DOS33) -y polly.dsk BSAVE -a 0x1000 REPO
	$(DOS33) -y polly.dsk BSAVE -a 0x1000 REPO2

###

BOOP: boop.o
	ld65 -o BOOP boop.o -C ../../linker_scripts/apple2_1000.inc

boop.o:	boop.s
	ca65 -o boop.o boop.s -l boop.lst

###

POLLY: polly.o
	ld65 -o POLLY polly.o -C ../../linker_scripts/apple2_1000.inc

polly.o:	polly.s
	ca65 -o polly.o polly.s -l polly.lst

###

decode_trace.o:	decode_trace.c
	$(CC) $(CFLAGS) -c decode_trace.c

decode_trace:	decode_trace.o
	$(CC) -o decode_trace decode_trace.o $(LFLAGS)

sample.inc:	poly.trace decode_trace
	./decode_trace < poly.trace > sample.inc

REPO: repo.o
	ld65 -o REPO repo.o -C ../../linker_scripts/apple2_1000.inc

repo.o:	repo.s sample.inc
	ca65 -o repo.o repo.s -l repo.lst

###

REPO2: repo2.o
	ld65 -o REPO2 repo2.o -C ../../linker_scripts/apple2_1000.inc

repo2.o:	repo2.s sample.inc
	ca65 -o repo2.o repo2.s -l repo2.lst

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO POLLY BOOP REPO REPO2 decode_trace

