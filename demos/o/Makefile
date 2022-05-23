include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk

all:	dsr_64.dsk

dsr_64.dsk:	HELLO DSR
	cp $(EMPTYDISK) dsr_64.dsk
	$(DOS33) -y dsr_64.dsk SAVE A HELLO
	$(DOS33) -y dsr_64.dsk BSAVE -a 0x70 DSR

###

submit:	dsr64.zip

dsr64.zip:	DSR dsr.s file_id.diz dsr_64.dsk
	mkdir -p lovebyte2022_dsr_64
	cp DSR ./lovebyte2022_dsr_64
	cp dsr.s ./lovebyte2022_dsr_64
	cp file_id.diz ./lovebyte2022_dsr_64
	cp dsr_64.dsk ./lovebyte2022_dsr_64
	cp dsr_720p.mp4 ./lovebyte2022_dsr_64
	zip -r dsr64.zip lovebyte2022_dsr_64

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DSR:	dsr.o
	ld65 -o DSR dsr.o -C ./apple2_70_zp.inc

dsr.o:	dsr.s
	ca65 -o dsr.o dsr.s -l dsr.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO DSR *.zip
