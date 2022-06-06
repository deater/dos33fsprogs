PNG2RLE = ../../utils/gr-utils/png2rle
PNG2GR = ../../utils/gr-utils/png2gr
PNG2HGR = ../../utils/hgr-utils/png2hgr
LZSA = ~/research/lzsa/lzsa/lzsa
B2D = ../../utils/bmp2dhr/b2d
EXOMIZER = ~/research/6502_compression/exomizer.git/src/exomizer
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../linker_scripts/



all:	compression_test.dsk

compression_test.dsk: HELLO LZSA_TEST EXOMIZER_TEST ZX02_TEST
	cp $(EMPTYDISK) compression_test.dsk
	$(DOS33) -y compression_test.dsk SAVE A HELLO
	$(DOS33) -y compression_test.dsk BSAVE -a 0x6000 LZSA_TEST
	$(DOS33) -y compression_test.dsk BSAVE -a 0x6000 EXOMIZER_TEST
	$(DOS33) -y compression_test.dsk BSAVE -a 0x6000 ZX02_TEST



####

HELLO:  hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

LZSA_TEST:	lzsa_test.o
	ld65 -o LZSA_TEST lzsa_test.o -C $(LINKERSCRIPTS)/apple2_6000.inc

lzsa_test.o:	lzsa_test.s decompress_fast_v2.s level5.lzsa
	ca65 -o lzsa_test.o lzsa_test.s -l lzsa_test.lst

###

level5.lzsa:	level5.hgr
	$(LZSA) -r -f2 level5.hgr level5.lzsa

###

EXOMIZER_TEST:	exomizer_test.o
	ld65 -o EXOMIZER_TEST exomizer_test.o -C $(LINKERSCRIPTS)/apple2_6000.inc

exomizer_test.o:	exomizer_test.s exodecrunch.s level5.exo
	ca65 -o exomizer_test.o exomizer_test.s -l exomizer_test.lst

###

level5.exo:	level5.hgr
#	$(EXOMIZER) mem level5.hgr -o level5.exo
	$(EXOMIZER) mem -l "$$6000" "level5.hgr,$$2000" -o level5.exo


###

ZX02_TEST:	zx02_test.o
	ld65 -o ZX02_TEST zx02_test.o -C $(LINKERSCRIPTS)/apple2_6000.inc

zx02_test.o:	zx02_test.s zx02_optim.s level5.zx02
	ca65 -o zx02_test.o zx02_test.s -l zx02_test.lst

###

level5.zx02:	level5.hgr
	$(ZX02) level5.hgr level5.zx02


###

level5.hgr:	level5.png
	$(PNG2HGR) level5.png > level5.hgr


clean:	
	rm -f HELLO LZSA_TEST EXOMIZER_TEST *~ *.o *.lst level5.lzsa
