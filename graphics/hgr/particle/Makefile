include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	particle_hgr.dsk

$(DOS33):	
	cd ../../../utils/dos33fs-utils && make

particle_hgr.dsk:	$(DOS33) HELLO PARTICLE_HGR PARTICLE_HGR_BOT
	cp $(EMPTY_DISK)/empty.dsk particle_hgr.dsk
	$(DOS33) -y particle_hgr.dsk SAVE A HELLO
	$(DOS33) -y particle_hgr.dsk BSAVE -a 0xc00 PARTICLE_HGR
	$(DOS33) -y particle_hgr.dsk BSAVE -a 0x36C PARTICLE_HGR_BOT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

PARTICLE_HGR:   particle_hgr.o
	ld65 -o PARTICLE_HGR particle_hgr.o -C $(LINKERSCRIPTS)/apple2_c00.inc

particle_hgr.o: particle_hgr.s
	ca65 -o particle_hgr.o particle_hgr.s -l particle_hgr.lst

###

PARTICLE_HGR_BOT:   particle_hgr_bot.o
	ld65 -o PARTICLE_HGR_BOT particle_hgr_bot.o -C $(LINKERSCRIPTS)/apple2_36c.inc

particle_hgr_bot.o: particle_hgr_bot.s
	ca65 -o particle_hgr_bot.o particle_hgr_bot.s -l particle_hgr_bot.lst


###

clean:	
	rm -f *~ *.o *.lst HELLO PARTICLE_HGR PARTICLE_HGR_BOT

