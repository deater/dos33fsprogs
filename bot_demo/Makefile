include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft
PNG2RLE = ../gr-utils/png2rle
LZSA = ~/research/lzsa/lzsa/lzsa

all:	bot_demo.dsk

bot_demo.dsk:	HELLO LOADER
	cp empty.dsk bot_demo.dsk
	$(DOS33) -y bot_demo.dsk BSAVE -a 0x1000 LOADER
	$(DOS33) -y bot_demo.dsk BSAVE -a 0x6000 BOTDEMO MYSTERY
	$(DOS33) -y bot_demo.dsk SAVE A HELLO


###

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../linker_scripts/apple2_1000.inc

loader.o:	loader.s BOTDEMO.LZ4
	ca65 -o loader.o loader.s -l loader.lst

###

BOTDEMO.LZ4:	BOTDEMO
	$(LZSA) -r -f2 BOTDEMO BOTDEMO.LZ4

###

BOTDEMO:	botdemo.o
	ld65 -o BOTDEMO botdemo.o -C ../linker_scripts/apple2_6000.inc

botdemo.o:	botdemo.s \
	zp.inc hardware.inc nozp.inc \
	load.s bg.inc \
	interrupt_handler.s \
	wipe.s
	ca65 -o botdemo.o botdemo.s -l botdemo.lst


###

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

###

RLE:	rle.o
	ld65 -o RLE rle.o -C ./apple2_custom.inc

rle.o:	rle.s
	ca65 -o rle.o rle.s -l rle.lst

####

bg.inc:	bg.png
	$(PNG2RLE) asm bg.png bg_rle > bg.inc

####

clean:	
	rm -f *~ *.o *.lst RLE BOTDEMO LOADER BOTDEMO.LZ4
