include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	lines.dsk

lines.dsk:	HELLO LINES LINES_SMALL LINES_ROM LINES_WIKI
	cp $(EMPTYDISK) lines.dsk
	$(DOS33) -y lines.dsk SAVE A HELLO
	$(DOS33) -y lines.dsk BSAVE -a 0xC00 LINES
	$(DOS33) -y lines.dsk BSAVE -a 0xC00 LINES_SMALL
	$(DOS33) -y lines.dsk BSAVE -a 0xC00 LINES_ROM
	$(DOS33) -y lines.dsk BSAVE -a 0xC00 LINES_WIKI

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

LINES:	lines.o
	ld65 -o LINES lines.o -C $(LINKERSCRIPTS)/apple2_c00.inc

lines.o:	lines.s
	ca65 -o lines.o lines.s -l lines.lst

###

LINES_SMALL:	lines_small.o
	ld65 -o LINES_SMALL lines_small.o -C $(LINKERSCRIPTS)/apple2_c00.inc

lines_small.o:	lines_small.s
	ca65 -o lines_small.o lines_small.s -l lines_small.lst

###

LINES_ROM:	lines_rom.o
	ld65 -o LINES_ROM lines_rom.o -C $(LINKERSCRIPTS)/apple2_c00.inc

lines_rom.o:	lines_rom.s
	ca65 -o lines_rom.o lines_rom.s -l lines_rom.lst

###

LINES_WIKI:	lines_wiki.o
	ld65 -o LINES_WIKI lines_wiki.o -C $(LINKERSCRIPTS)/apple2_c00.inc

lines_wiki.o:	lines_wiki.s
	ca65 -o lines_wiki.o lines_wiki.s -l lines_wiki.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO LINES LINES_SMALL LINES_ROM LINES_WIKI
