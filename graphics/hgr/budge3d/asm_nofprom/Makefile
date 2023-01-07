include ../../../../Makefile.inc

DOS33 = ../../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../../linker_scripts
EMPTY_DISK = ../../../../empty_disk

all:	budge3d.dsk

budge3d.dsk:	HELLO SHIP_CUBE
	cp $(EMPTY_DISK)/empty.dsk budge3d.dsk
	$(DOS33) -y budge3d.dsk SAVE A HELLO
	$(DOS33) -y budge3d.dsk BSAVE -a 0x800 SHIP_CUBE


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


####

SHIP_CUBE:	ship_cube.o
	ld65 -o SHIP_CUBE ship_cube.o -C $(LINKER_SCRIPTS)/apple2_800.inc

ship_cube.o:	ship_cube.s \
	zp.inc hardware.inc \
	shapes.s math_constants.s hgr_tables.s \
	scale_constants.s
	ca65 -o ship_cube.o ship_cube.s -l ship_cube.lst

####
clean:
	rm -f *~ *.o *.lst HELLO SHIP_CUBE
