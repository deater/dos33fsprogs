include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	star.dsk

$(DOS33):	
	cd ../../../utils/dos33fs-utils && make

star.dsk:	$(DOS33) HELLO STAR STARS STARS_BOT STARS_128
	cp $(EMPTY_DISK)/empty.dsk star.dsk
	$(DOS33) -y star.dsk SAVE A HELLO
	$(DOS33) -y star.dsk BSAVE -a 0xc00 STAR
	$(DOS33) -y star.dsk BSAVE -a 0xc00 STARS
	$(DOS33) -y star.dsk BSAVE -a 0x36B STARS_BOT
	$(DOS33) -y star.dsk BSAVE -a 0x60 STARS_128

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

STAR:   star.o
	ld65 -o STAR star.o -C $(LINKERSCRIPTS)/apple2_c00.inc

star.o: star.s
	ca65 -o star.o star.s -l star.lst

###

STARS:   stars.o
	ld65 -o STARS stars.o -C $(LINKERSCRIPTS)/apple2_c00.inc

stars.o: stars.s
	ca65 -o stars.o stars.s -l stars.lst


###

STARS_BOT:   stars_bot.o
	ld65 -o STARS_BOT stars_bot.o -C $(LINKERSCRIPTS)/apple2_36b.inc

stars_bot.o: stars_bot.s
	ca65 -o stars_bot.o stars_bot.s -l stars_bot.lst

###

STARS_128:   stars_128.o
	ld65 -o STARS_128 stars_128.o -C $(LINKERSCRIPTS)/apple2_60_zp.inc

stars_128.o: stars_128.s
	ca65 -o stars_128.o stars_128.s -l stars_128.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO STAR STARS STARS_BOT STARS_128

