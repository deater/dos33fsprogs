include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk
HGR2PNG = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	tiny_music.dsk

tiny_music.dsk:	HELLO MUSIC
	cp $(EMPTY_DISK)/empty.dsk ./tiny_music.dsk
	$(DOS33) -y tiny_music.dsk SAVE A HELLO
	$(DOS33) -y tiny_music.dsk -t BIN -a 0x2000 BSAVE MUSIC

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####



MUSIC:	music.o
	ld65 -o MUSIC music.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

music.o:	music.s \
	zp.inc hardware.inc nozp.inc \
	yankee_music.s \
	interrupt_handler.s mockingboard_setup.s
	ca65 -o music.o music.s -l music.lst

####

clean:
	rm -f *~ *.o *.lst MUSIC HELLO
