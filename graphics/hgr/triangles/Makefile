include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	triangles.dsk

triangles.dsk:	HELLO TRIANGLE.BAS LINES
	cp $(EMPTY_DISK)/empty.dsk triangles.dsk
	$(DOS33) -y triangles.dsk SAVE A HELLO
	$(DOS33) -y triangles.dsk SAVE A TRIANGLE.BAS
	$(DOS33) -y triangles.dsk BSAVE -a 0x0C00 LINES

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TRIANGLE.BAS:	triangle.bas
	$(TOKENIZE) < triangle.bas > TRIANGLE.BAS


###

LINES:	lines.o
	ld65 -o LINES lines.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

lines.o:	lines.s
	ca65 -o lines.o lines.s -l lines.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO LINES TRIANGLE.BAS

