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

tunnel.dsk:	$(DOS33) HELLO TUNNEL.BAS TUNNEL TUNNEL2 STARGATE T.BAS T
	cp $(EMPTYDISK)/empty.dsk tunnel.dsk
	$(DOS33) -y tunnel.dsk SAVE A HELLO
	$(DOS33) -y tunnel.dsk SAVE A TUNNEL.BAS
	$(DOS33) -y tunnel.dsk SAVE A T.BAS
	$(DOS33) -y tunnel.dsk BSAVE -a 0x36B T
	$(DOS33) -y tunnel.dsk BSAVE -a 0xc00 TUNNEL
	$(DOS33) -y tunnel.dsk BSAVE -a 0xc00 TUNNEL2
	$(DOS33) -y tunnel.dsk BSAVE -a 0x37c STARGATE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TUNNEL.BAS:	tunnel.bas
	$(TOKENIZE) < tunnel.bas > TUNNEL.BAS

###

T.BAS:	t.bas
	$(TOKENIZE) < t.bas > T.BAS



###

TUNNEL:	tunnel.o
	ld65 -o TUNNEL tunnel.o -C $(LINKERSCRIPTS)/apple2_c00.inc

tunnel.o:	tunnel.s
	ca65 -o tunnel.o tunnel.s -l tunnel.lst

###

T:	t.o
	ld65 -o T t.o -C $(LINKERSCRIPTS)/apple2_36b.inc

t.o:	t.s
	ca65 -o t.o t.s -l t.lst


###

TUNNEL2:	tunnel2.o
	ld65 -o TUNNEL2 tunnel2.o -C $(LINKERSCRIPTS)/apple2_c00.inc

tunnel2.o:	tunnel2.s
	ca65 -o tunnel2.o tunnel2.s -l tunnel2.lst


###

STARGATE:	stargate.o
	ld65 -o STARGATE stargate.o -C $(LINKERSCRIPTS)/apple2_37c.inc

stargate.o:	stargate.s
	ca65 -o stargate.o stargate.s -l stargate.lst


###


clean:	
	rm -f *~ *.o HELLO TUNNEL.BAS TUNNEL TUNNEL2 STARGATE T.BAS T *.lst

