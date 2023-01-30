include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	ooze32.dsk

ooze32.dsk:	HELLO OOZE32
	cp $(EMPTYDISK) ooze32.dsk
	$(DOS33) -y ooze32.dsk SAVE A HELLO
	$(DOS33) -y ooze32.dsk BSAVE -a 0xC00 OOZE32

###

submit:	ooze32.zip

ooze32.zip:	OOZE32 ooze32.s file_id.diz ooze32.dsk
	mkdir -p lovebyte2023_ooze32
	cp OOZE32 ./lovebyte2023_ooze32
	cp ooze32.s ./lovebyte2023_ooze32
	cp file_id.diz ./lovebyte2023_ooze32
	cp ooze32.dsk ./lovebyte2023_ooze32
	cp ooze32_720p.mp4 ./lovebyte2023_ooze32
	cp ooze32_screen.png ./lovebyte2023_ooze32
	cp monitor.txt ./lovebyte2023_ooze32
	zip -r ooze32.zip lovebyte2023_ooze32

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

OOZE32:	ooze32.o
	ld65 -o OOZE32 ooze32.o -C ./apple2_c00.inc

ooze32.o:	ooze32.s
	ca65 -o ooze32.o ooze32.s -l ooze32.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO OOZE32 *.zip
