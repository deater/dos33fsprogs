include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	font_collapse.dsk

font_collapse.dsk:	HELLO FONT_CONVERT FONT_DROP
	cp $(EMPTY_DISK)/empty.dsk font_collapse.dsk
	$(DOS33) -y font_collapse.dsk SAVE A HELLO
	$(DOS33) -y font_collapse.dsk BSAVE -a 0x6000 FONT_CONVERT
	$(DOS33) -y font_collapse.dsk BSAVE -a 0x6000 FONT_DROP

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

FONT_CONVERT:	font_convert.o
	ld65 -o FONT_CONVERT font_convert.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_convert.o:	font_convert.s \
	font_putchar.s \
	font_vmw_1x8.s \
	fonts/a2_lowercase_font.inc \
	hgr_clearscreen.s
	ca65 -o font_convert.o font_convert.s -l font_convert.lst

###

FONT_DROP:	font_drop.o
	ld65 -o FONT_DROP font_drop.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

font_drop.o:	font_drop.s \
	font_putchar.s \
	font_vmw_1x8.s \
	fonts/a2_lowercase_font.inc \
	hgr_clearscreen.s
	ca65 -o font_drop.o font_drop.s -l font_drop.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO FONT_CONVERT FONT_DROP

