include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	lines.dsk

lines.dsk:	HELLO LINES LINES_ROM
	cp $(EMPTY_DISK)/empty.dsk lines.dsk
	$(DOS33) -y lines.dsk SAVE A HELLO
	$(DOS33) -y lines.dsk BSAVE -a 0x0C00 LINES
	$(DOS33) -y lines.dsk BSAVE -a 0x0C00 LINES_ROM

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

LINES_ROM:	lines_rom.o
	ld65 -o LINES_ROM lines_rom.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

lines_rom.o:	lines_rom.s
	ca65 -o lines_rom.o lines_rom.s -l lines_rom.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO LINES LINES_ROM

