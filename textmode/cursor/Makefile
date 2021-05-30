include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2GR = ../../utils/gr-utils/png2gr
PNG2RLE = ../../utils/gr-utils/png2rle
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../linker_scripts

all:	textflip.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

textflip.dsk:	$(DOS33) HELLO TEXT_DEMO
	cp empty.dsk textflip.dsk
	$(DOS33) -y textflip.dsk SAVE A HELLO
	$(DOS33) -y textflip.dsk BSAVE -a 0x1000 TEXT_DEMO


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TEXT_DEMO:	text_demo.o
	ld65 -o TEXT_DEMO text_demo.o -C $(LINKERSCRIPTS)/apple2_1000.inc

text_demo.o:	text_demo.s \
	pageflip.s \
	gr_fast_clear.s
	ca65 -o text_demo.o text_demo.s -l text_demo.lst

###

clean:	
	rm -f *~ *.o TEXT_DEMO *.lst

