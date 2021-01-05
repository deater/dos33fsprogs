include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_RLE = ../../utils/gr-utils/png2rle

all:	hires.dsk

hires.dsk:	HELLO HIRES bbl.img.lz4t bbl2.img.lz4t \
		girl.hgr.lz4t 1bg.hgr.lz4t fup.hgr.lz4t witch.hgr.lz4t
	$(DOS33) -y hires.dsk SAVE A HELLO
	$(DOS33) -y hires.dsk BSAVE -a 0x0c00 HIRES
	$(DOS33) -y hires.dsk BSAVE -a 0xa000 bbl.img.lz4t BBL.LZ4
	$(DOS33) -y hires.dsk BSAVE -a 0xa000 bbl2.img.lz4t BBL2.LZ4
	$(DOS33) -y hires.dsk BSAVE -a 0xa000 girl.hgr.lz4t GIRL.LZ4
	$(DOS33) -y hires.dsk BSAVE -a 0xa000 1bg.hgr.lz4t OBG.LZ4
	$(DOS33) -y hires.dsk BSAVE -a 0xa000 fup.hgr.lz4t FUP.LZ4
	$(DOS33) -y hires.dsk BSAVE -a 0xa000 witch.hgr.lz4t WITCH.LZ4

####

HIRES:	hires.o
	ld65 -o HIRES hires.o -C ../../linker_scripts/apple2_c00.inc

hires.o:	hires.s \
	zp.inc hardware.inc
	ca65 -o hires.o hires.s -l hires.lst

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

bbl.img.lz4t:	bbl.img.lz4
	dd if=bbl.img.lz4 of=bbl.img.lz4t bs=1 skip=11
	truncate bbl.img.lz4t -s -8

bbl.img.lz4:	bbl.img
	lz4 -f -16 bbl.img

bbl.img:	bbl.png
	../hgr-utils/png2hgr bbl.png > bbl.img

####

bbl2.img.lz4t:	bbl2.img.lz4
	dd if=bbl2.img.lz4 of=bbl2.img.lz4t bs=1 skip=11
	truncate bbl2.img.lz4t -s -8

bbl2.img.lz4:	bbl2.img
	lz4 -f -16 bbl2.img

bbl2.img:	bbl2.png
	../hgr-utils/png2hgr bbl2.png > bbl2.img

####

1bg.hgr.lz4t:	1bg.hgr.lz4
	dd if=1bg.hgr.lz4 of=1bg.hgr.lz4t bs=1 skip=11
	truncate 1bg.hgr.lz4t -s -8

1bg.hgr.lz4:	1bg.hgr
	lz4 -f -16 1bg.hgr

1bg.hgr:	1bg.png
	../hgr-utils/png2hgr 1bg.png > 1bg.hgr


####

fup.hgr.lz4t:	fup.hgr.lz4
	dd if=fup.hgr.lz4 of=fup.hgr.lz4t bs=1 skip=11
	truncate fup.hgr.lz4t -s -8

fup.hgr.lz4:	fup.hgr
	lz4 -f -16 fup.hgr

fup.hgr:	fup.png
	../hgr-utils/png2hgr fup.png > fup.hgr

####

witch.hgr.lz4t:	witch.hgr.lz4
	dd if=witch.hgr.lz4 of=witch.hgr.lz4t bs=1 skip=11
	truncate witch.hgr.lz4t -s -8

witch.hgr.lz4:	witch.hgr
	lz4 -f -16 witch.hgr

witch.hgr:	witch.png
	../hgr-utils/png2hgr witch.png > witch.hgr



###

girl.hgr.lz4t:	girl.hgr.lz4
	dd if=girl.hgr.lz4 of=girl.hgr.lz4t bs=1 skip=11
	truncate girl.hgr.lz4t -s -8

girl.hgr.lz4:	girl.hgr
	lz4 -f -16 girl.hgr

###


clean:
		rm -f *~ *.o *.lst HIRES

