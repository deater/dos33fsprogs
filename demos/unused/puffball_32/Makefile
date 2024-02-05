include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	puffball.dsk

puffball.dsk:	HELLO PUFFBALL
	cp $(EMPTYDISK) puffball.dsk
	$(DOS33) -y puffball.dsk SAVE A HELLO
	$(DOS33) -y puffball.dsk BSAVE -a 0xe7 PUFFBALL

###

submit:	puffball.zip

puffball.zip:	PUFFBALL puffball.s file_id.diz puffball.dsk
	mkdir -p lovebyte2024_puffball
	cp PUFFBALL ./lovebyte2024_puffball
	cp puffball.s ./lovebyte2024_puffball
	cp file_id.diz ./lovebyte2024_puffball
	cp puffball.dsk ./lovebyte2024_puffball
	cp monitor.txt ./lovebyte2024_puffball
	cp puffball_screen.png ./lovebyte2024_puffball
	cp puffball_720p.mp4 ./lovebyte2024_puffball
	zip -r puffball.zip lovebyte2024_puffball

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PUFFBALL:	puffball.o
	ld65 -o PUFFBALL puffball.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

puffball.o:	puffball.s
	ca65 -o puffball.o puffball.s -l puffball.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO PUFFBALL *.zip
