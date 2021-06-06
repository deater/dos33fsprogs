include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk

all:	tunnel.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

tunnel.dsk:	$(DOS33) HELLO TUNNEL.BAS TUNNEL WEIRD
	cp $(EMPTYDISK)/empty.dsk tunnel.dsk
	$(DOS33) -y tunnel.dsk SAVE A HELLO
	$(DOS33) -y tunnel.dsk SAVE A TUNNEL.BAS
	$(DOS33) -y tunnel.dsk BSAVE -a 0xc00 TUNNEL
	$(DOS33) -y tunnel.dsk BSAVE -a 0x37c WEIRD

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TUNNEL.BAS:	tunnel.bas
	$(TOKENIZE) < tunnel.bas > TUNNEL.BAS


###

TUNNEL:	tunnel.o
	ld65 -o TUNNEL tunnel.o -C $(LINKERSCRIPTS)/apple2_c00.inc

tunnel.o:	tunnel.s
	ca65 -o tunnel.o tunnel.s -l tunnel.lst

###

WEIRD:	weird.o
	ld65 -o WEIRD weird.o -C $(LINKERSCRIPTS)/apple2_37c.inc

weird.o:	weird.s
	ca65 -o weird.o weird.s -l weird.lst


###


clean:	
	rm -f *~ *.o HELLO TUNNEL.BAS TUNNEL WEIRD *.lst

