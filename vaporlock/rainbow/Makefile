include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
PICTUREDSK = ~/research/picturedsk.git/picturedsk
LINKER_SCRIPTS = ../../../linker_scripts/
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	blue_flame.dsk

###

blue_flame.dsk:	HELLO BLUE_FLAME TEST.BAS BEE.BAS BLACKHOLE_64 ENTROPY RAINBOW GEARS_FANCY
	cp $(EMPTYDISK) blue_flame.dsk
	$(DOS33) -y blue_flame.dsk SAVE A HELLO
	$(DOS33) -y blue_flame.dsk SAVE A TEST.BAS
	$(DOS33) -y blue_flame.dsk SAVE A BEE.BAS
	$(DOS33) -y blue_flame.dsk BSAVE -a 0x8000 BLUE_FLAME
	$(DOS33) -y blue_flame.dsk BSAVE -a 0x6000 BLACKHOLE_64
	$(DOS33) -y blue_flame.dsk BSAVE -a 0x6000 ENTROPY
	$(DOS33) -y blue_flame.dsk BSAVE -a 0x6000 RAINBOW
	$(DOS33) -y blue_flame.dsk BSAVE -a 0x6000 GEARS_FANCY
#	$(DOS33) -y blue_flame.dsk BSAVE -a 0x6000 BF

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

TEST.BAS:	test.bas
	$(TOKENIZE) < test.bas > TEST.BAS

###

BEE.BAS:	bee.bas
	$(TOKENIZE) < bee.bas > BEE.BAS

###

###

GEARS_FANCY:	gears_fancy.o
	ld65 -o GEARS_FANCY gears_fancy.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

gears_fancy.o:	gears_fancy.s
	ca65 -o gears_fancy.o gears_fancy.s -l gears_fancy.lst

###

BLACKHOLE_64:	blackhole_64.o
	ld65 -o BLACKHOLE_64 blackhole_64.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

blackhole_64.o:	blackhole_64.s
	ca65 -o blackhole_64.o blackhole_64.s -l blackhole_64.lst


###

ENTROPY:	entropy.o
	ld65 -o ENTROPY entropy.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

entropy.o:	entropy.s
	ca65 -o entropy.o entropy.s -l entropy.lst

###

RAINBOW:	rainbow.o
	ld65 -o RAINBOW rainbow.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

rainbow.o:	rainbow.s
	ca65 -o rainbow.o rainbow.s -l rainbow.lst



###

submit:	blue_flame.zip

blue_flame.zip:	BF blue_flame.dsk
	mkdir -p lovebyte2023_blue_flame
	mkdir -p lovebyte2023_blue_flame/src
	cp BF ./lovebyte2023_blue_flame
	cp *.s ./lovebyte2023_blue_flame/src
	cp *.inc ./lovebyte2023_blue_flame/src
	cp file_id.diz ./lovebyte2023_blue_flame
	cp blue_flame.dsk ./lovebyte2023_blue_flame
	cp blue_flame_720p.mp4 ./lovebyte2023_blue_flame
	cp blue_flame_screen.png ./lovebyte2023_blue_flame
	zip -r blue_flame.zip lovebyte2023_blue_flame

####

BLUE_FLAME:	blue_flame.o
	ld65 -o BLUE_FLAME blue_flame.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

blue_flame.o:	blue_flame.s
	ca65 -o blue_flame.o blue_flame.s -l blue_flame.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO BLUE_FLAME BF *.ZX02 *.zip make_points

