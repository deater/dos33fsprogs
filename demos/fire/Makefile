include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_RLE = ../gr-utils/png2rle


all:	fire.dsk

fire.dsk:	FIRE FIRE_TINY FIRE_FIRMWARE FIRE_EXTREME FIRE_QKUMBA HELLO COOL_EFFECT RASTER
	$(DOS33) -y fire.dsk SAVE A HELLO
	$(DOS33) -y fire.dsk BSAVE -a 0x1000 FIRE
	$(DOS33) -y fire.dsk BSAVE -a 0x70 FIRE_TINY
	$(DOS33) -y fire.dsk BSAVE -a 0x70 FIRE_FIRMWARE
	$(DOS33) -y fire.dsk BSAVE -a 0x70 FIRE_EXTREME
	$(DOS33) -y fire.dsk BSAVE -a 0x70 FIRE_QKUMBA
	$(DOS33) -y fire.dsk BSAVE -a 0x70 RASTER
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

FIRE_FIRMWARE:	fire_firmware.o
	ld65 -o FIRE_FIRMWARE fire_firmware.o -C ../linker_scripts/apple2_70.inc

fire_firmware.o:	fire_firmware.s
	ca65 -o fire_firmware.o fire_firmware.s -l fire_firmware.lst

####

FIRE_EXTREME:	fire_extreme.o
	ld65 -o FIRE_EXTREME fire_extreme.o -C ../linker_scripts/apple2_70.inc

fire_extreme.o:	fire_extreme.s
	ca65 -o fire_extreme.o fire_extreme.s -l fire_extreme.lst

####

FIRE_HIGH:	fire_high.o
	ld65 -o FIRE_HIGH fire_high.o -C ../linker_scripts/apple2_c00.inc

fire_high.o:	fire_high.s
	ca65 -o fire_high.o fire_high.s -l fire_high.lst


####

FIRE_QKUMBA:	fire_qkumba.o
	ld65 -o FIRE_QKUMBA fire_qkumba.o -C ../linker_scripts/apple2_70.inc

fire_qkumba.o:	fire_qkumba.s
	ca65 -o fire_qkumba.o fire_qkumba.s -l fire_qkumba.lst



####

COOL_EFFECT:	cool_effect.o
	ld65 -o COOL_EFFECT cool_effect.o -C ../linker_scripts/apple2_70.inc

cool_effect.o:	cool_effect.s
	ca65 -o cool_effect.o cool_effect.s -l cool_effect.lst


####


RASTER:	raster.o
	ld65 -o RASTER raster.o -C ../linker_scripts/apple2_70.inc

raster.o:	raster.s
	ca65 -o raster.o raster.s -l raster.lst

####

HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


#####

clean:		
		rm -f *~ *.o *.lst FIRE FIRE_TINY FIRE_FIRMWARE COOL_EFFECT HELLO FIRE_EXTREME FIRE_QKUMBA RASTER



