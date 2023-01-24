include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	lemm256.dsk

lemm256.dsk:	HELLO LEMM
	cp $(EMPTYDISK) lemm256.dsk
	$(DOS33) -y lemm256.dsk SAVE A HELLO
	$(DOS33) -y lemm256.dsk SAVE A LEMM

###

submit:	lemm256.zip

lemm256.zip:	PAR_TINY lemm.bas file_id.diz lemm256.dsk
	mkdir -p lovebyte2023_lemm256
	cp LEMM ./lovebyte2023_lemm256
	cp lemm.bas ./lovebyte2023_lemm256
	cp file_id.diz ./lovebyte2023_lemm256
	cp lemm256.dsk ./lovebyte2023_lemm256
	cp lemm_720p.mp4 ./lovebyte2023_lemm256
	zip -r lemm256.zip lovebyte2023_lemm256

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

LEMM:	lemm.bas
	$(TOKENIZE) < lemm.bas > LEMM



####

clean:	
	rm -f *~ *.o *.lst HELLO LEMM *.zip
