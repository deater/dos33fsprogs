include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
PICTUREDSK = ~/research/picturedsk.git/picturedsk
LINKER_SCRIPTS = ../../../linker_scripts/
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	hectic.dsk

###

hectic.dsk:	HELLO HECTIC
	cp $(EMPTYDISK) hectic.dsk
	$(DOS33) -y hectic.dsk SAVE A HELLO
	$(DOS33) -y hectic.dsk BSAVE -a 0x6000 HECTIC


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

HECTIC:	hectic.o
	ld65 -o HECTIC hectic.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

hectic.o:	hectic.s
	ca65 -o hectic.o hectic.s -l hectic.lst



###

submit:	hectic.zip

hectic.zip:	HECTIC hectic.dsk
	mkdir -p outline2026_hectic
	mkdir -p outline2026_hectic/src
	cp HECTIC ./outline2026_hectic
	cp *.s ./outline2026_hectic/src
	cp *.inc ./outline2026_hectic/src
	cp file_id.diz ./outline2026_hectic
	cp hectic.dsk ./outline2026_hectic
	cp hectic_720p.mp4 ./outline2026_hectic
	cp hectic_screen.png ./outline2026_hectic
	zip -r hectic.zip outline2026_hectic


####

clean:	
	rm -f *~ *.o *.lst HELLO HECTIC

