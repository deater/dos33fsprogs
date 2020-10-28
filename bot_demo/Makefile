include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	bot_demo.dsk

bot_demo.dsk:	RLE
	cp empty.dsk bot_demo.dsk
	$(DOS33) -y bot_demo.dsk BSAVE -a 0x036c RLE


###

RLE:	rle.o
	ld65 -o RLE rle.o -C ./apple2_custom.inc

rle.o:	rle.s
	ca65 -o rle.o rle.s -l rle.lst

####

clean:	
	rm -f *~ *.o *.lst RLE
