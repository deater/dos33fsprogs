include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
B2D = ../../utils/bmp2dhr/b2d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_RLE = ../../utils/gr-utils/png2rle
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	hires_plain.dsk make_hgr_viewer


###

make_hgr_viewer:	make_hgr_viewer.o
	$(CC) $(LFLAGS) -o make_hgr_viewer make_hgr_viewer.o

make_hgr_viewer.o:	make_hgr_viewer.c
	$(CC) $(CFLAGS) -c make_hgr_viewer.c

###

hires_special.dsk:	HELLO HIRES_SPECIAL \
		special/bbl.hgr.zx02 special/bbl2.hgr.zx02 \
		special/grl.hgr.zx02 special/1bg.hgr.zx02 \
		special/fup.hgr.zx02 special/witch.hgr.zx02 \
		special/ob.hgr.zx02 special/bg2.hgr.zx02 \
		special/oopb.hgr.zx02 special/ooc5.hgr.zx02 \
		special/fze.hgr.zx02 special/fjj.hgr.zx02 \
		special/dadz.hgr.zx02 special/mope_a2.hgr.zx02 \
		special/lh.hgr.zx02 special/fcd.hgr.zx02 \
		special/facd.hgr.zx02 special/fif.hgr.zx02 \
		special/fif2.hgr.zx02 special/oo4.hgr.zx02 \
		special/oo2.hgr.zx02 special/fwq.hgr.zx02 \
		special/piz.hgr.zx02 special/cit.hgr.zx02 \
		special/cel.hgr.zx02 special/mug.hgr.zx02 \
		special/jis.hgr.zx02 special/ojm.hgr.zx02 \
		special/nda.hgr.zx02 special/fri.hgr.zx02 \
		special/win.hgr.zx02 special/bar.hgr.zx02 \
		special/ani.hgr.zx02 special/gld.hgr.zx02 \
		special/rnu.hgr.zx02 special/ooh.hgr.zx02 \
		special/two.hgr.zx02 special/rug.hgr.zx02 \
		special/ndz.hgr.zx02 special/crd.hgr.zx02 \
		special/gfa.hgr.zx02 special/sxy.hgr.zx02
	cp $(EMPTY_DISK) hires_special.dsk
	$(DOS33) -y hires_special.dsk SAVE A HELLO
	$(DOS33) -y hires_special.dsk BSAVE -a 0x0c00 HIRES_SPECIAL HIRES
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/bbl.hgr.zx02 BBL.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/bbl2.hgr.zx02 BBL2.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/grl.hgr.zx02 GRL.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/1bg.hgr.zx02 OBG.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/fup.hgr.zx02 FUP.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/witch.hgr.zx02 WITCH.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/ob.hgr.zx02 OB.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/bg2.hgr.zx02 BG2.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/oopb.hgr.zx02 OOPB.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/ooc5.hgr.zx02 OOC5.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/fze.hgr.zx02 FZE.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/fjj.hgr.zx02 FJJ.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/dadz.hgr.zx02 DADZ.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/mope_a2.hgr.zx02 MOPE.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/lh.hgr.zx02 LH.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/fcd.hgr.zx02 FCD.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/facd.hgr.zx02 FACD.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/fif.hgr.zx02 FIF.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/fif2.hgr.zx02 FIF2.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/oo4.hgr.zx02 OO4.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/oo2.hgr.zx02 OO2.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/fwq.hgr.zx02 FWQ.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/piz.hgr.zx02 PIZ.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/cit.hgr.zx02 CIT.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/cel.hgr.zx02 CEL.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/mug.hgr.zx02 MUG.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/quad.hgr.zx02 QUAD.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/gb.hgr.zx02 GB.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/jis.hgr.zx02 JIS.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/ojm.hgr.zx02 OJM.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/nda.hgr.zx02 NDA.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/fri.hgr.zx02 FRI.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/win.hgr.zx02 WIN.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/bar.hgr.zx02 BAR.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/ani.hgr.zx02 ANI.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/gld.hgr.zx02 GLD.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/rnu.hgr.zx02 RNU.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/ooh.hgr.zx02 OOH.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/two.hgr.zx02 TWO.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/rug.hgr.zx02 RUG.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/ndz.hgr.zx02 NDZ.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/crd.hgr.zx02 CRD.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/gfa.hgr.zx02 GFA.ZX02
	$(DOS33) -y hires_special.dsk BSAVE -a 0xa000 ./special/sxy.hgr.zx02 SXY.ZX02




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
	$(DOS33) -y hires_jiskey.dsk BSAVE -a 0xa000 ./jiskey/skull.hgr.zx02 SKULL.ZX02
	$(DOS33) -y hires_jiskey.dsk BSAVE -a 0xa000 ./jiskey/uw.hgr.zx02 UW.ZX02



####

HIRES_SPECIAL:	hires_special.o
	ld65 -o HIRES_SPECIAL hires_special.o -C ../../linker_scripts/apple2_c00.inc

hires_special.o:	hires_special.s hires_main.s zx02_optim.s \
	zp.inc hardware.inc
	ca65 -o hires_special.o hires_special.s -l hires_special.lst

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
		rm -f *~ *.o *.lst HIRES_SPECIAL HIRES_JISKEY HELLO

