include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	scroller.dsk

$(DOS33):	
	cd ../../../utils/dos33fs-utils && make

scroller.dsk:	$(DOS33) HELLO DIAMOND DIAMOND_BOT RANDOM RANDOM_BOT RANDOM_128 RANDOM_FUN
	cp $(EMPTY_DISK)/empty.dsk scroller.dsk
	$(DOS33) -y scroller.dsk SAVE A HELLO
	$(DOS33) -y scroller.dsk BSAVE -a 0xc00 DIAMOND
	$(DOS33) -y scroller.dsk BSAVE -a 0x36B DIAMOND_BOT
	$(DOS33) -y scroller.dsk BSAVE -a 0xc00 RANDOM
	$(DOS33) -y scroller.dsk BSAVE -a 0x36B RANDOM_BOT
	$(DOS33) -y scroller.dsk BSAVE -a 0x70 RANDOM_128
	$(DOS33) -y scroller.dsk BSAVE -a 0x70 RANDOM_FUN
###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DIAMOND:   diamond.o
	ld65 -o DIAMOND diamond.o -C $(LINKERSCRIPTS)/apple2_c00.inc

diamond.o: diamond.s
	ca65 -o diamond.o diamond.s -l diamond.lst

###

DIAMOND_BOT:   diamond_bot.o
	ld65 -o DIAMOND_BOT diamond_bot.o -C $(LINKERSCRIPTS)/apple2_36b.inc

diamond_bot.o: diamond_bot.s
	ca65 -o diamond_bot.o diamond_bot.s -l diamond_bot.lst

###

RANDOM:   random.o
	ld65 -o RANDOM random.o -C $(LINKERSCRIPTS)/apple2_c00.inc

random.o: random.s
	ca65 -o random.o random.s -l random.lst

###

RANDOM_128:   random_128.o
	ld65 -o RANDOM_128 random_128.o -C $(LINKERSCRIPTS)/apple2_70_zp.inc

random_128.o: random_128.s
	ca65 -o random_128.o random_128.s -l random_128.lst

###

RANDOM_FUN:   random_fun.o
	ld65 -o RANDOM_FUN random_fun.o -C $(LINKERSCRIPTS)/apple2_70_zp.inc

random_fun.o: random_fun.s
	ca65 -o random_fun.o random_fun.s -l random_fun.lst


###


RANDOM_BOT:   random_bot.o
	ld65 -o RANDOM_BOT random_bot.o -C $(LINKERSCRIPTS)/apple2_36b.inc

random_bot.o: random_bot.s
	ca65 -o random_bot.o random_bot.s -l random_bot.lst

###


clean:	
	rm -f *~ *.o *.lst HELLO DIAMOND DIAMOND_BOT RANDOM

