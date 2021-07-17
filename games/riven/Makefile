#include ../Makefile.inc

#include ../../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts
EMPTY_DISK = ../../empty_disk

B2D = ../../utils/bmp2dhr/b2d
PNG2GR = ../../utils/gr-utils/png2gr
LZSA = ~/research/lzsa/lzsa/lzsa


###

all:	riven.dsk

riven.dsk:	HELLO RIVEN
	cp $(EMPTY_DISK)/empty.dsk riven.dsk
	$(DOS33) -y riven.dsk SAVE A HELLO
	$(DOS33) -y riven.dsk BSAVE -a 0x6000 RIVEN
###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

RIVEN:	riven.o
	ld65 -o RIVEN riven.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

riven.o:	riven.s riven_title.lzsa riven1.lzsa riven3.lzsa
	ca65 -o riven.o riven.s -l riven.lst



riven_title.lzsa:	RIVEN_TITLEC.BIN
	$(LZSA) -r -f2 RIVEN_TITLEC.BIN riven_title.lzsa

RIVEN_TITLEC.BIN:	riven_title.bmp
	$(B2D) riven_title.bmp HGR -d

####

%.gr:	%.png
	 $(PNG2GR) $< $@

%.lzsa:	%.gr
	$(LZSA) -r -f2 $< $@


###

clean:	
	rm -f *~ *.o *.lst HELLO RIVEN

