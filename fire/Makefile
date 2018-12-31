include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_RLE = ../gr-utils/png2rle


all:	fire.dsk

fire.dsk:	FIRE FIRE_TINY HELLO COOL_EFFECT
	$(DOS33) -y fire.dsk SAVE A HELLO
	$(DOS33) -y fire.dsk BSAVE -a 0x1000 FIRE
	$(DOS33) -y fire.dsk BSAVE -a 0x70 FIRE_TINY
	$(DOS33) -y fire.dsk BSAVE -a 0x70 COOL_EFFECT

####

FIRE:	fire.o
	ld65 -o FIRE fire.o -C ../linker_scripts/apple2_1000.inc

fire.o:	fire.s gr_fast_clear.s vapor_lock.s \
	delay_a.s
	ca65 -o fire.o fire.s -l fire.lst

####

FIRE_TINY:	fire_tiny.o
	ld65 -o FIRE_TINY fire_tiny.o -C ../linker_scripts/apple2_70.inc

fire_tiny.o:	fire_tiny.s
	ca65 -o fire_tiny.o fire_tiny.s -l fire_tiny.lst


####

COOL_EFFECT:	cool_effect.o
	ld65 -o COOL_EFFECT cool_effect.o -C ../linker_scripts/apple2_70.inc

cool_effect.o:	cool_effect.s
	ca65 -o cool_effect.o cool_effect.s -l cool_effect.lst



####

HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


#####

clean:		
		rm -f *~ *.o *.lst FIRE FIRE_TINY COOL_EFFECT HELLO


