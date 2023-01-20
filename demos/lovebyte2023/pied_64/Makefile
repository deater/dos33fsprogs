include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	pied64.dsk

pied64.dsk:	HELLO PIED57
	cp $(EMPTYDISK) pied64.dsk
	$(DOS33) -y pied64.dsk SAVE A HELLO
	$(DOS33) -y pied64.dsk BSAVE -a 0x80 PIED57

###

submit:	pied.zip

pied32.zip:	PIED57 pied57.s file_id.diz pied64.dsk
	mkdir -p lovebyte2022_pied
	cp PIED57 ./lovebyte2022_pied
	cp pied57.s ./lovebyte2022_pied
	cp file_id.diz ./lovebyte2022_pied
	cp pied64.dsk ./lovebyte2022_pied
	cp pied_720p.mp4 ./lovebyte2022_pied
	zip -r pied32.zip lovebyte2022_pied

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PIED57:	pied57.o
	ld65 -o PIED57 pied57.o -C ./apple2_80_zp.inc

pied57.o:	pied57.s
	ca65 -o pied57.o pied57.s -l pied57.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO PIED57 *.zip
