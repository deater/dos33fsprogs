include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	weave15.dsk

weave15.dsk:	HELLO WEAVE15
	cp $(EMPTYDISK) weave15.dsk
	$(DOS33) -y weave15.dsk SAVE A HELLO
	$(DOS33) -y weave15.dsk BSAVE -a 0xE7 WEAVE15

###

submit:	weave15.zip

weave15.zip:	WEAVE15 weave15.s file_id.diz weave15.dsk
	mkdir -p lovebyte2023_weave15
	cp WEAVE15 ./lovebyte2023_weave15
	cp weave15.s ./lovebyte2023_weave15
	cp file_id.diz ./lovebyte2023_weave15
	cp weave15.dsk ./lovebyte2023_weave15
	cp monitor.txt ./lovebyte2023_weave15
	cp weave15_screen.png ./lovebyte2023_weave15
	cp weave15_720p.mp4 ./lovebyte2023_weave15
	zip -r weave15.zip lovebyte2023_weave15

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

WEAVE15:	weave15.o
	ld65 -o WEAVE15 weave15.o -C ./apple2_e7_zp.inc

weave15.o:	weave15.s
	ca65 -o weave15.o weave15.s -l weave15.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO WEAVE15 *.zip
