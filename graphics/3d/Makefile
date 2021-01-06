include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
PNG2DHGR = ../../utils/hgr-utils/png2dhgr

all:	3d.dsk

3d.dsk:	HELLO LOAD CUBE_WHITE.BIN CUBE_PINK.BIN CUBE_BLACK.BIN
	cp empty.dsk 3d.dsk
	$(DOS33) -y 3d.dsk SAVE A HELLO
	$(DOS33) -y 3d.dsk SAVE A LOAD
	$(DOS33) -y 3d.dsk BSAVE -a 0x2000 CUBE_WHITE.AUX
	$(DOS33) -y 3d.dsk BSAVE -a 0x2000 CUBE_WHITE.BIN
	$(DOS33) -y 3d.dsk BSAVE -a 0x2000 CUBE_BLACK.AUX
	$(DOS33) -y 3d.dsk BSAVE -a 0x2000 CUBE_BLACK.BIN
	$(DOS33) -y 3d.dsk BSAVE -a 0x2000 CUBE_PINK.AUX
	$(DOS33) -y 3d.dsk BSAVE -a 0x2000 CUBE_PINK.BIN

###

CUBE_WHITE.BIN:	cube_white_bg.png
	$(PNG2DHGR) ./cube_white_bg.png CUBE_WHITE

CUBE_BLACK.BIN:	cube_black_bg.png
	$(PNG2DHGR) ./cube_black_bg.png CUBE_BLACK

CUBE_PINK.BIN:	cube_pink_bg.png
	$(PNG2DHGR) ./cube_pink_bg.png CUBE_PINK

###

HELLO:  hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

LOAD:  load.bas
	$(TOKENIZE) < load.bas > LOAD

####


clean:	
	rm -f *~ *.o LOAD HELLO *.BIN *.AUX
