include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	sierzoom128.dsk

submit:	sierzoom128.zip

sierzoom128.zip: SIERZOOM sierzoom.s file_id.diz sierzoom128.dsk
	mkdir -p lovebyte2021_sierzoom128
	cp SIERZOOM ./lovebyte2021_sierzoom128
	cp sierzoom.s ./lovebyte2021_sierzoom128
	cp file_id.diz ./lovebyte2021_sierzoom128
	cp sierzoom128.dsk ./lovebyte2021_sierzoom128
	cp sierzoom_720p.mp4 ./lovebyte2021_sierzoom128
	zip -r sierzoom128.zip lovebyte2021_sierzoom128



sierzoom128.dsk:	HELLO SIERZOOM
	cp $(EMPTY_DISK) sierzoom128.dsk
	$(DOS33) -y sierzoom128.dsk SAVE A HELLO
	$(DOS33) -y -x sierzoom128.dsk SAVE I HELLO "/½½½½½½½½½½½½½½½½½½½½½½½\\"
	$(DOS33) -y -x sierzoom128.dsk SAVE T HELLO "½       SIERZOOM        ½"
	$(DOS33) -y -x sierzoom128.dsk SAVE I HELLO "½     LOVEBYTE 2021     ½"
	$(DOS33) -y -x sierzoom128.dsk SAVE T HELLO ":½½½½½½½½½½½½½½½½½½½½½½½:"
	$(DOS33) -y -x sierzoom128.dsk SAVE I HELLO "½  128B DEMO BY DEATER  ½"
	$(DOS33) -y -x sierzoom128.dsk SAVE T HELLO "½   -  d e s i r e  -   ½"
	$(DOS33) -y -x sierzoom128.dsk SAVE I HELLO "\\½½½½½½½½½½½½½½½½½½½½½½½/"
	$(DOS33) -y sierzoom128.dsk BSAVE -a 0x60 SIERZOOM

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SIERZOOM:	sierzoom.o
	ld65 -o SIERZOOM sierzoom.o -C ./apple2_60_zp.inc

sierzoom.o:	sierzoom.s
	ca65 -o sierzoom.o sierzoom.s -l sierzoom.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO SIERZOOM *.zip
