include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	lovebyte_15.dsk

lovebyte_15.dsk:	HELLO LOVEBYTE_15
	cp $(EMPTYDISK) lovebyte_15.dsk
	$(DOS33) -y lovebyte_15.dsk SAVE A HELLO
	$(DOS33) -y lovebyte_15.dsk BSAVE -a 0xC00 LOVEBYTE_15

###

submit:	lovebyte15.zip

lovebyte15.zip:	LOVEBYTE_15 lovebyte_15.s file_id.diz lovebyte_15.dsk
	mkdir -p lovebyte_15
	cp LOVEBYTE_15 ./lovebyte_15
	cp lovebyte_15.s ./lovebyte_15
	cp file_id.diz ./lovebyte_15
	cp lovebyte_15.dsk ./lovebyte_15
	cp dsr_720p.mp4 ./lovebyte_15
	zip -r lovebyte15.zip lovebyte_15

###

submit_small:	lovebyte15_small.zip

lovebyte15_small.zip:	LOVEBYTE_15 lovebyte_15.s file_id.diz lovebyte_15.dsk
	mkdir -p lovebyte_15
	cp LOVEBYTE_15 ./lovebyte_15
	cp lovebyte_15.s ./lovebyte_15
	cp file_id.diz ./lovebyte_15
	cp lovebyte_15.dsk ./lovebyte_15
	zip -r lovebyte15_small.zip lovebyte_15


####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

LOVEBYTE_15:	lovebyte_15.o
	ld65 -o LOVEBYTE_15 lovebyte_15.o -C $(LINKERSCRIPTS)/apple2_c00.inc

lovebyte_15.o:	lovebyte_15.s
	ca65 -o lovebyte_15.o lovebyte_15.s -l lovebyte_15.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO LOVEBYTE_15 *.zip
