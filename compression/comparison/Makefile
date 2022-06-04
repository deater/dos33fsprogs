PNG2RLE = ../../utils/gr-utils/png2rle
PNG2GR = ../../utils/gr-utils/png2gr
PNG2HGR = ../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../utils/bmp2dhr/b2d

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../linker_scripts/



all:	compression_test.dsk

compression_test.dsk: HELLO LZSA_TEST
	cp $(EMPTYDISK) compression_test.dsk
	$(DOS33) -y compression_test.dsk SAVE A HELLO
	$(DOS33) -y compression_test.dsk BSAVE -a 0x6000 LZSA_TEST


####

HELLO:  hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

LZSA_TEST:	lzsa_test.o
	ld65 -o LZSA_TEST lzsa_test.o -C $(LINKERSCRIPTS)/apple2_6000.inc

lzsa_test.o:	lzsa_test.s graphics_level5.inc
	ca65 -o lzsa_test.o lzsa_test.s -l lzsa_test.lst

###

graphics_level5.inc:	level5.lzsa
	echo "level5_lzsa: .incbin \"level5.lzsa\"" > graphics_level5.inc

###

level5.lzsa:	level5.hgr
	$(LZSA) -r -f2 level5.hgr level5.lzsa

level5.hgr:	level5.png
	$(PNG2HGR) level5.png > level5.hgr


clean:	
	rm -f HELLO LZSA_TEST *~ *.o *.lst level5.lzsa
