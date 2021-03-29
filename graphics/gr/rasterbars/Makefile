include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts

all:	gr_rasterbars.dsk

$(DOS33):	
	cd ../../../utils/dos33fs-utils && make

gr_rasterbars.dsk:	$(DOS33) HELLO RASTERBARS
	cp empty.dsk gr_rasterbars.dsk
	$(DOS33) -y gr_rasterbars.dsk SAVE A HELLO
	$(DOS33) -y gr_rasterbars.dsk BSAVE -a 0x1000 RASTERBARS


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

RASTERBARS:	rasterbars.o
	ld65 -o RASTERBARS rasterbars.o -C $(LINKERSCRIPTS)/apple2_1000.inc

rasterbars.o:	rasterbars.s \
	gr_scroll.s \
	pageflip.s \
	gr_setpage.s \
	gr_fast_clear.s
	ca65 -o rasterbars.o rasterbars.s -l rasterbars.lst

###

clean:	
	rm -f *~ *.o RASTERBARS *.lst

