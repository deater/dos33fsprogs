include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	gears128.dsk

gears128.dsk:	HELLO GEARS_FANCY
	cp $(EMPTYDISK) gears128.dsk
	$(DOS33) -y gears128.dsk SAVE A HELLO
	$(DOS33) -y gears128.dsk BSAVE -a 0x50 GEARS_FANCY

###

submit:	gears128.zip

gears128.zip:	GEARS_FANCY gears_fancy.s file_id.diz gears128.dsk
	mkdir -p lovebyte2023_gears
	cp GEARS_FANCY ./lovebyte2023_gears
	cp gears_fancy.s ./lovebyte2023_gears
	cp file_id.diz ./lovebyte2023_gears
	cp gears128.dsk ./lovebyte2023_gears
	cp gears128_720p.mp4 ./lovebyte2023_gears
	cp gears128_screen.png ./lovebyte2023_gears
	zip -r gears128.zip lovebyte2023_gears

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

GEARS_FANCY:	gears_fancy.o
	ld65 -o GEARS_FANCY gears_fancy.o -C ./apple2_50_zp.inc

gears_fancy.o:	gears_fancy.s
	ca65 -o gears_fancy.o gears_fancy.s -l gears_fancy.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO GEARS_FANCY *.zip
