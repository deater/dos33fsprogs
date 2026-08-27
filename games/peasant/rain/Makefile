include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	RAIN rain.inc

###

rain.inc:	RAIN
	../generate_common -a 0xe000 -s draw_rain rain.lst > rain.inc
	../generate_common -a 0xe000 -s grey_sky rain.lst >> rain.inc


###

RAIN:	rain.o
	ld65 -o RAIN rain.o -C $(LINKER_SCRIPTS)/apple2_e000.inc

rain.o:	rain.s \
		../hardware.inc ../zp.inc ../qload.inc
	ca65 -o rain.o rain.s -l rain.lst

###

rain_sprites/rain_sprites.inc:
	cd rain_sprites && make

###

distclean:
	make clean
	cd rain_sprites && make clean

###

clean:	
	rm -f *~ *.o *.lst RAIN
