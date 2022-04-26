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

scroller.dsk:	$(DOS33) HELLO HEXAGON
	cp $(EMPTY_DISK)/empty.dsk scroller.dsk
	$(DOS33) -y scroller.dsk SAVE A HELLO
	$(DOS33) -y scroller.dsk BSAVE -a 0xc00 HEXAGON
#	$(DOS33) -y scroller.dsk BSAVE -a 0x36C PARTICLE_BOT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

HEXAGON:   hexagon.o
	ld65 -o HEXAGON hexagon.o -C $(LINKERSCRIPTS)/apple2_c00.inc

hexagon.o: hexagon.s
	ca65 -o hexagon.o hexagon.s -l hexagon.lst

###

HEXAGON_BOT:   hexagon_bot.o
	ld65 -o HEXAGON_BOT hexagon_bot.o -C $(LINKERSCRIPTS)/apple2_36c.inc

hexagon_bot.o: hexagon_bot.s
	ca65 -o hexagon_bot.o hexagon_bot.s -l hexagon_bot.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO HEXAGON HEXAGON_BOT

