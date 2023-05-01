include ../../Makefile.inc

TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
DOS33 = ../../utils/dos33fs-utils/dos33
TEXT_TO_ED = ./text_to_ed
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	eduet.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

eduet.dsk:	$(DOS33) HELLO ED HIGHWIND.ED FIGHTING.ED SA.ED \
		KERBAL.ED KORO.ED PEASANT.ED FORTNIGHT.ED
	cp $(EMPTY_DISK) eduet.dsk
	$(DOS33) -y eduet.dsk SAVE A HELLO
	$(DOS33) -y eduet.dsk BSAVE -a 0x0C00 ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 HIGHWIND.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 FIGHTING.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 SA.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 KERBAL.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 KORO.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 PEASANT.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 FORTNIGHT.ED


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

ED:	duet.o
	ld65 -o ED duet.o -C ../../linker_scripts/apple2_c00.inc

duet.o:	duet.s
	ca65 -o duet.o duet.s -l duet.lst


###

PEASANT.ED:	peasant.ed
	cp peasant.ed PEASANT.ED

peasant.ed:	$(TEXT_TO_ED) peasant.txt
	$(TEXT_TO_ED) -o 1 peasant.txt peasant

###

HIGHWIND.ED:	highwind.ed
	cp highwind.ed HIGHWIND.ED

highwind.ed:	$(TEXT_TO_ED) highwind.txt
	$(TEXT_TO_ED) -o 0 highwind.txt highwind

###

FIGHTING.ED:	fighting.ed
	cp fighting.ed FIGHTING.ED

fighting.ed:	$(TEXT_TO_ED) fighting.txt
	$(TEXT_TO_ED) -o 0 fighting.txt fighting


###

FORTNIGHT.ED:	fortnight.ed
	cp fortnight.ed FORTNIGHT.ED

fortnight.ed:	$(TEXT_TO_ED) fortnight.txt
	$(TEXT_TO_ED) -o 1 fortnight.txt fortnight


###

text_to_ed:	text_to_ed.o notes.o
	$(CC) -o text_to_ed text_to_ed.o notes.o $(LFLAGS) -lm

text_to_ed.o:	text_to_ed.c notes.h
	$(CC) $(CFLAGS) -c text_to_ed.c

notes.o:	notes.c notes.h
	$(CC) $(CFLAGS) -c notes.c

###

clean:	
	rm -f *~ *.o *.lst ED text_to_ed

