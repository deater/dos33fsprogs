include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	tiny_text8.dsk

tiny_text8.dsk:	HELLO TINY_TEXT
	cp $(EMPTYDISK) tiny_text8.dsk
	$(DOS33) -y tiny_text8.dsk SAVE A HELLO
	$(DOS33) -y tiny_text8.dsk BSAVE -a 0x70 TINY_TEXT

###

submit:	text8.zip

text8.zip:	TINY_TEXT tiny_text.s file_id.diz tiny_text8.dsk
	mkdir -p lovebyte2021_tiny_text8
	cp TINY_TEXT ./lovebyte2021_tiny_text8
	cp tiny_text.s ./lovebyte2021_tiny_text8
	cp file_id.diz ./lovebyte2021_tiny_text8
	cp tiny_text8.dsk ./lovebyte2021_tiny_text8
	cp tiny_text_720p.mp4 ./lovebyte2021_tiny_text8
	zip -r text8.zip lovebyte2021_tiny_text8

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TINY_TEXT:	tiny_text.o
	ld65 -o TINY_TEXT tiny_text.o -C ./apple2_70_zp.inc

tiny_text.o:	tiny_text.s
	ca65 -o tiny_text.o tiny_text.s -l tiny_text.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO TINY_TEXT *.zip
