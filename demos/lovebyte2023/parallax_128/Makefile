include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	parallax128.dsk

parallax128.dsk:	HELLO PAR_TINY
	cp $(EMPTYDISK) parallax128.dsk
	$(DOS33) -y parallax128.dsk SAVE A HELLO
	$(DOS33) -y parallax128.dsk BSAVE -a 0x80 PAR_TINY

###

submit:	parallax128.zip

parallax128.zip:	PAR_TINY par_tiny.s file_id.diz parallax128.dsk
	mkdir -p lovebyte2023_parallax
	cp PAR_TINY ./lovebyte2023_parallax
	cp par_tiny.s ./lovebyte2023_parallax
	cp file_id.diz ./lovebyte2023_parallax
	cp parallax128.dsk ./lovebyte2023_parallax
	cp parallax_720p.mp4 ./lovebyte2023_parallax
	zip -r parallax128.zip lovebyte2023_parallax

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PAR_TINY:	par_tiny.o
	ld65 -o PAR_TINY par_tiny.o -C ./apple2_80_zp.inc

par_tiny.o:	par_tiny.s
	ca65 -o par_tiny.o par_tiny.s -l par_tiny.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO PAR_TINY *.zip
