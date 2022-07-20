include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_RLE = ../../utils/gr-utils/png2rle
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	hires_plain.dsk hires_special.dsk hires_jiskey.dsk

hires_special.dsk:	HELLO HIRES_SPECIAL \
		special/bbl.hgr.zx02 special/bbl2.hgr.zx02 \
		special/grl.hgr.zx02 special/1bg.hgr.zx02 \
		special/fup.hgr.zx02 special/witch.hgr.zx02
	cp $(EMPTY_DISK) hires_special.dsk
	$(DOS33) -y hires_special.dsk SAVE A HELLO
	$(DOS33) -y hires_special.dsk BSAVE -a 0x0c00 HIRES_SPECIAL HIRES
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/bbl.hgr.zx02 BBL.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/bbl2.hgr.zx02 BBL2.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/grl.hgr.zx02 GRL.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/1bg.hgr.zx02 OBG.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/fup.hgr.zx02 FUP.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/witch.hgr.zx02 WITCH.ZX02

####

hires_plain.dsk:	HELLO HIRES_PLAIN \
		./plain/gp.hgr.zx02 ./plain/peddle.hgr.zx02
	cp $(EMPTY_DISK) hires_plain.dsk
	$(DOS33) -y hires_plain.dsk SAVE A HELLO
	$(DOS33) -y hires_plain.dsk BSAVE -a 0x0c00 HIRES_PLAIN HIRES
	$(DOS33) -y hires_plain.dsk BSAVE -a 0xa000 ./plain/gp.hgr.zx02 GP.ZX02
	$(DOS33) -y hires_plain.dsk BSAVE -a 0xa000 ./plain/peddle.hgr.zx02 PEDDLE.ZX02

####

hires_jiskey.dsk:	HELLO HIRES_JISKEY \
		jiskey/grl.hgr.zx02 jiskey/witch.hgr.zx02 \
		jiskey/mona.hgr.zx02 jiskey/gw.hgr.zx02
	cp $(EMPTY_DISK) hires_jiskey.dsk
	$(DOS33) -y hires_jiskey.dsk SAVE A HELLO
	$(DOS33) -y hires_jiskey.dsk BSAVE -a 0x0c00 HIRES_JISKEY HIRES
	$(DOS33) -y hires_jiskey.dsk BSAVE -a 0xa000 ./jiskey/grl.hgr.zx02 GRL.ZX02
	$(DOS33) -y hires_jiskey.dsk BSAVE -a 0xa000 ./jiskey/witch.hgr.zx02 WITCH.ZX02
	$(DOS33) -y hires_jiskey.dsk BSAVE -a 0xa000 ./jiskey/mona.hgr.zx02 MONA.ZX02
	$(DOS33) -y hires_jiskey.dsk BSAVE -a 0xa000 ./jiskey/gw.hgr.zx02 GW.ZX02


####

HIRES_SPECIAL:	hires_special.o
	ld65 -o HIRES_SPECIAL hires_special.o -C ../../linker_scripts/apple2_c00.inc

hires_special.o:	hires_special.s zx02_optim.s \
	zp.inc hardware.inc
	ca65 -o hires_special.o hires_special.s -l hires_special.lst

####

HIRES_PLAIN:	hires_plain.o
	ld65 -o HIRES_PLAIN hires_plain.o -C ../../linker_scripts/apple2_c00.inc

hires_plain.o:	hires_plain.s \
	zp.inc hardware.inc
	ca65 -o hires_plain.o hires_plain.s -l hires_plain.lst

####

HIRES_JISKEY:	hires_jiskey.o
	ld65 -o HIRES_JISKEY hires_jiskey.o -C ../../linker_scripts/apple2_c00.inc

hires_jiskey.o:	hires_jiskey.s \
	zp.inc hardware.inc
	ca65 -o hires_jiskey.o hires_jiskey.s -l hires_jiskey.lst


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###


clean:
		rm -f *~ *.o *.lst HIRES_PLAIN HIRES_SPECIAL HIRES_JISKEY HELLO

