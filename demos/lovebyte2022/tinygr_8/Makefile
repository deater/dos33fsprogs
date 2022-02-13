include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	tiny_gr8.dsk

tiny_gr8.dsk:	HELLO TINY_GR
	cp $(EMPTYDISK) tiny_gr8.dsk
	$(DOS33) -y tiny_gr8.dsk SAVE A HELLO
	$(DOS33) -y tiny_gr8.dsk BSAVE -a 0xB9 TINY_GR

###

submit:	tiny_gr8.zip

tiny_gr8.zip:	TINY_GR tiny_gr.s file_id.diz tiny_gr8.dsk
	mkdir -p lovebyte2022_tiny_gr8
	cp TINY_GR ./lovebyte2022_tiny_gr8
	cp tiny_gr.s ./lovebyte2022_tiny_gr8
	cp file_id.diz ./lovebyte2022_tiny_gr8
	cp tiny_gr8.dsk ./lovebyte2022_tiny_gr8
	cp tiny_gr8_720p.mp4 ./lovebyte2022_tiny_gr8
	zip -r tiny_gr8.zip lovebyte2022_tiny_gr8

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TINY_GR:	tiny_gr.o
	ld65 -o TINY_GR tiny_gr.o -C ./apple2_b9.inc

tiny_gr.o:	tiny_gr.s
	ca65 -o tiny_gr.o tiny_gr.s -l tiny_gr.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO TINY_GR *.zip
