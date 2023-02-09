include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
PICTUREDSK = ~/research/picturedsk.git/picturedsk
LINKER_SCRIPTS = ../../../linker_scripts/
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	love_duck.dsk love_duck.woz

###


love_duck.dsk:	LD
	# 0, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 15
	dd if=/dev/zero of=love_duck.dsk bs=256 count=560
	dd conv=notrunc if=LD of=love_duck.dsk bs=256 count=1
	dd conv=notrunc if=LD of=love_duck.dsk bs=256 count=1 seek=7 skip=1

###

love_duck.woz:	LD
	$(PICTUREDSK) ./flux_image/duck.bmp love_duck.woz LD



###

love_duck_raw.dsk:	HELLO LOVE_DUCK LD
	cp $(EMPTYDISK) love_duck_raw.dsk
	$(DOS33) -y love_duck_raw.dsk SAVE A HELLO
	$(DOS33) -y love_duck_raw.dsk BSAVE -a 0x1000 LOVE_DUCK

###

LOVE_DUCK.ZX02:	LOVE_DUCK
	$(ZX02) -f LOVE_DUCK LOVE_DUCK.ZX02

LD:	ld.o
	ld65 -o LD ld.o -C $(LINKER_SCRIPTS)/apple2_800.inc

ld.o:	ld.s LOVE_DUCK
	ca65 -o ld.o ld.s -l ld.lst



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
	ld65 -o LOVE_DUCK love_duck.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

love_duck.o:	love_duck.s speaker_beeps.s dsr_lores.s dsr_extra.s
	ca65 -o love_duck.o love_duck.s -l love_duck.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO LOVE_DUCK *.zip

