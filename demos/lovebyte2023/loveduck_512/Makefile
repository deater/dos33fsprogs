include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
PICTUREDSK = ~/research/picturedsk.git/picturedsk
LINKER_SCRIPTS = ../../../linker_scripts/
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	love_duck.dsk

###

love_duck.dsk:	HELLO LOVE_DUCK
	cp $(EMPTYDISK) love_duck.dsk
	$(DOS33) -y love_duck.dsk SAVE A HELLO
	$(DOS33) -y love_duck.dsk BSAVE -a 0xc00 LOVE_DUCK

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

submit:	love_duck.zip

love_duck.zip:	LOVE_DUCK love_duck.dsk
	mkdir -p lovebyte2023_love_duck
	mkdir -p lovebyte2023_love_duck/src
	cp LOVE_DUCK ./lovebyte2023_love_duck
	cp *.s ./lovebyte2023_love_duck/src
	cp *.inc ./lovebyte2023_love_duck/src
	cp file_id.diz ./lovebyte2023_love_duck
	cp love_duck.dsk ./lovebyte2023_love_duck
	cp love_duck.mp4 ./lovebyte2023_love_duck
	cp love_duck_screen.png ./lovebyte2023_love_duck
	zip -r love_duck.zip lovebyte2023_love_duck

####

LOVE_DUCK:	love_duck.o
	ld65 -o LOVE_DUCK love_duck.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

love_duck.o:	love_duck.s
	ca65 -o love_duck.o love_duck.s -l love_duck.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO LOVE_DUCK *.zip

