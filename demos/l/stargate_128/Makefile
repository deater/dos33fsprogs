include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk

all:	stargate.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

stargate.dsk:	$(DOS33) HELLO STARGATE
	cp $(EMPTYDISK)/empty.dsk stargate.dsk
	$(DOS33) -y stargate.dsk SAVE A HELLO
	$(DOS33) -y stargate.dsk BSAVE -a 0x37c STARGATE

###

submit:	stargate_128.zip

stargate_128.zip:	STARGATE stargate.s file_id.diz stargate.dsk
	mkdir -p lovebyte2022_stargate_128
	cp STARGATE ./lovebyte2022_stargate_128
	cp stargate.s ./lovebyte2022_stargate_128
	cp file_id.diz ./lovebyte2022_stargate_128
	cp stargate.dsk ./lovebyte2022_stargate_128
	cp stargate_128_720p.mp4 ./lovebyte2022_stargate_128
	zip -r stargate_128.zip lovebyte2022_stargate_128

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

STARGATE:	stargate.o
	ld65 -o STARGATE stargate.o -C $(LINKERSCRIPTS)/apple2_37c.inc

stargate.o:	stargate.s
	ca65 -o stargate.o stargate.s -l stargate.lst


###


clean:	
	rm -f *~ *.o HELLO TUNNEL.BAS TUNNEL TUNNEL2 STARGATE T.BAS T *.lst

