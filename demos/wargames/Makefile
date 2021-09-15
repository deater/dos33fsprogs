include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk
PNG2HGR = ../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa


all:	wargames.dsk

wargames.dsk:	HELLO WARGAMES
	cp $(EMPTY_DISK) wargames.dsk
	$(DOS33) -y wargames.dsk SAVE A HELLO
	$(DOS33) -y wargames.dsk BSAVE -a 0xc00 WARGAMES

###

WARGAMES: wargames.o
	ld65 -o WARGAMES wargames.o -C ../../linker_scripts/apple2_c00.inc

wargames.o:	wargames.s ssi263.inc ssi263_detect.s ssi263_simple_speech.s	\
	map.lzsa coords.inc
	ca65 -o wargames.o wargames.s -l wargames.lst

###

map.lzsa:	map.hgr
	$(LZSA) -r -f2 map.hgr map.lzsa

map.hgr:	map.png
	$(PNG2HGR) map.png > map.hgr

###

coords.inc:	make_coords coords.txt
	./make_coords < coords.txt > coords.inc

###

make_coords:	make_coords.o
	$(CC) -o make_coords make_coords.o $(LFLAGS) -lm

make_coords.o:	make_coords.c
	$(CC) $(CFLAGS) -c make_coords.c

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO WARGAMES make_coords

