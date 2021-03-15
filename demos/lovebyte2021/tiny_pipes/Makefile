include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	tiny_pipes64.dsk

tiny_pipes64.dsk:	HELLO TINY_PIPES
	cp $(EMPTYDISK) tiny_pipes64.dsk
	$(DOS33) -y tiny_pipes64.dsk SAVE A HELLO
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO "/======================"
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO ":      TINY PIPES"
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO "\\=====================\\"
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO "       BY DEATER      :"
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO "/=====================/"
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO ":    64 BYTE DEMO"
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO ":    LOVEBYTE 2021"
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO "\\======================"
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO "   -- d e s i r e --"
	$(DOS33) -y -x tiny_pipes64.dsk SAVE T HELLO "  "
	$(DOS33) -y tiny_pipes64.dsk BSAVE -a 0x70 TINY_PIPES

###

submit:	pipes64.zip

pipes64.zip:	TINY_PIPES tiny_pipes.s file_id.diz tiny_pipes64.dsk
	mkdir -p lovebyte2021_tiny_pipes64
	cp TINY_PIPES ./lovebyte2021_tiny_pipes64
	cp tiny_pipes.s ./lovebyte2021_tiny_pipes64
	cp file_id.diz ./lovebyte2021_tiny_pipes64
	cp tiny_pipes64.dsk ./lovebyte2021_tiny_pipes64
	cp tiny_pipes_720p.mp4 ./lovebyte2021_tiny_pipes64
	zip -r pipes64.zip lovebyte2021_tiny_pipes64

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TINY_PIPES:	tiny_pipes.o
	ld65 -o TINY_PIPES tiny_pipes.o -C ./apple2_70_zp.inc

tiny_pipes.o:	tiny_pipes.s
	ca65 -o tiny_pipes.o tiny_pipes.s -l tiny_pipes.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO TINY_PIPES *.zip
