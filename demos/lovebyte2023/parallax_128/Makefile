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

submit:	pied.zip

pied32.zip:	PAR_TINY par_tiny.s file_id.diz parallax128.dsk
	mkdir -p lovebyte2022_pied
	cp PAR_TINY ./lovebyte2022_pied
	cp par_tiny.s ./lovebyte2022_pied
	cp file_id.diz ./lovebyte2022_pied
	cp parallax128.dsk ./lovebyte2022_pied
	cp pied_720p.mp4 ./lovebyte2022_pied
	zip -r pied32.zip lovebyte2022_pied

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PAR_TINY:	pied57.o
	ld65 -o PAR_TINY pied57.o -C ./apple2_80_zp.inc

pied57.o:	par_tiny.s
	ca65 -o pied57.o par_tiny.s -l pied57.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO PAR_TINY *.zip
