include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	particle.dsk

$(DOS33):	
	cd ../../../utils/dos33fs-utils && make

particle.dsk:	$(DOS33) HELLO PARTICLE PARTICLE_BOT
	cp $(EMPTY_DISK)/empty.dsk particle.dsk
	$(DOS33) -y particle.dsk SAVE A HELLO
	$(DOS33) -y particle.dsk BSAVE -a 0xc00 PARTICLE
	$(DOS33) -y particle.dsk BSAVE -a 0x36C PARTICLE_BOT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PARTICLE:   particle.o
	ld65 -o PARTICLE particle.o -C $(LINKERSCRIPTS)/apple2_c00.inc

particle.o: particle.s
	ca65 -o particle.o particle.s -l particle.lst

###

PARTICLE_BOT:   particle_bot.o
	ld65 -o PARTICLE_BOT particle_bot.o -C $(LINKERSCRIPTS)/apple2_36c.inc

particle_bot.o: particle_bot.s
	ca65 -o particle_bot.o particle_bot.s -l particle_bot.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO PARTICLE PARTICLE_BOT

