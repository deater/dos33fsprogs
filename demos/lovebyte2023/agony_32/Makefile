include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	agony17.dsk

agony17.dsk:	HELLO AGONY17
	cp $(EMPTYDISK) agony17.dsk
	$(DOS33) -y agony17.dsk SAVE A HELLO
	$(DOS33) -y agony17.dsk BSAVE -a 0xE7 AGONY17

###

submit:	agony17.zip

agony17.zip:	AGONY17 agony17.s file_id.diz agony17.dsk
	mkdir -p lovebyte2023_agony17
	cp AGONY17 ./lovebyte2023_agony17
	cp agony17.s ./lovebyte2023_agony17
	cp file_id.diz ./lovebyte2023_agony17
	cp agony17.dsk ./lovebyte2023_agony17
	cp monitor.txt ./lovebyte2023_agony17
	cp agony17_720p.mp4 ./lovebyte2023_agony17
	cp agony17_screen.png ./lovebyte2023_agony17
	zip -r agony17.zip lovebyte2023_agony17

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

AGONY17:	agony17.o
	ld65 -o AGONY17 agony17.o -C ./apple2_e7_zp.inc

agony17.o:	agony17.s
	ca65 -o agony17.o agony17.s -l agony17.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO AGONY17 *.zip
