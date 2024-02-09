include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	hhhh_16.dsk

hhhh_16.dsk:	HELLO HHHH_16
	cp $(EMPTYDISK) hhhh_16.dsk
	$(DOS33) -y hhhh_16.dsk SAVE A HELLO
	$(DOS33) -y hhhh_16.dsk BSAVE -a 0xE7 HHHH_16

###

submit:	hhhh_16.zip

hhhh_16.zip:	HHHH_16 hhhh_16.s file_id.diz hhhh_16.dsk
	mkdir -p lovebyte2024_hhhh_16
	cp HHHH_16 ./lovebyte2024_hhhh_16
	cp hhhh_16.s ./lovebyte2024_hhhh_16
	cp file_id.diz ./lovebyte2024_hhhh_16
	cp hhhh_16.dsk ./lovebyte2024_hhhh_16
	cp monitor.txt ./lovebyte2024_hhhh_16
	cp hhhh_16_720p.mp4 ./lovebyte2024_hhhh_16
	cp hhhh_16_screen.png ./lovebyte2024_hhhh_16
	zip -r hhhh_16.zip lovebyte2024_hhhh_16

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

HHHH_16:	hhhh_16.o
	ld65 -o HHHH_16 hhhh_16.o -C ./apple2_e7_zp.inc

hhhh_16.o:	hhhh_16.s
	ca65 -o hhhh_16.o hhhh_16.s -l hhhh_16.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO HHHH_16 *.zip
