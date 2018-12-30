include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_RLE = ../gr-utils/png2rle


all:	fire.dsk

fire.dsk:	FIRE HELLO
	$(DOS33) -y fire.dsk SAVE A HELLO
	$(DOS33) -y fire.dsk BSAVE -a 0x1000 FIRE

####

FIRE:	fire.o
	ld65 -o FIRE fire.o -C ../linker_scripts/apple2_1000.inc

fire.o:	fire.s gr_fast_clear.s vapor_lock.s \
	delay_a.s
	ca65 -o fire.o fire.s -l fire.lst


####

HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


#####

clean:		
		rm -f *~ *.o *.lst FIRE HELLO


