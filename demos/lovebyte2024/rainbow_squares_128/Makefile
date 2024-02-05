include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	rainbow_squares.dsk

rainbow_squares.dsk:	HELLO RAINBOW_SQUARES
	cp $(EMPTYDISK) rainbow_squares.dsk
	$(DOS33) -y rainbow_squares.dsk SAVE A HELLO
	$(DOS33) -y rainbow_squares.dsk BSAVE -a 0xc00 RAINBOW_SQUARES

###

submit:	rainbow_squares.zip

rainbow_squares.zip:	RAINBOW_SQUARES rainbow_squares.s file_id.diz rainbow_squares.dsk
	mkdir -p lovebyte2024_rainbow_squares
	cp RAINBOW_SQUARES ./lovebyte2024_rainbow_squares
	cp rainbow_squares.s ./lovebyte2024_rainbow_squares
	cp file_id.diz ./lovebyte2024_rainbow_squares
	cp rainbow_squares.dsk ./lovebyte2024_rainbow_squares
	cp rainbow_squares_screen.png ./lovebyte2024_rainbow_squares
	cp rainbow_squares_720p.mp4 ./lovebyte2024_rainbow_squares
	zip -r rainbow_squares.zip lovebyte2024_rainbow_squares

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

RAINBOW_SQUARES:	rainbow_squares.o
	ld65 -o RAINBOW_SQUARES rainbow_squares.o -C $(LINKERSCRIPTS)/apple2_c00.inc

rainbow_squares.o:	rainbow_squares.s
	ca65 -o rainbow_squares.o rainbow_squares.s -l rainbow_squares.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO RAINBOW_SQUARES *.zip
