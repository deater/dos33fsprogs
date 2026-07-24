DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../../empty_disk/empty.dsk
LINKER_SCRIPTS = ../../../linker_scripts

all:	test_sound.dsk

test_sound.dsk:	HELLO TEST_SOUND
	cp $(EMPTY_DISK) test_sound.dsk
	$(DOS33) -y test_sound.dsk SAVE A HELLO
	$(DOS33) -y test_sound.dsk BSAVE -a 0x1000 TEST_SOUND

###

TEST_SOUND: test_sound.o
	ld65 -o TEST_SOUND test_sound.o -C $(LINKER_SCRIPTS)/apple2_1000.inc

test_sound.o:	test_sound.s \
	kerrek_appear.s baby_lady.s
	ca65 -o test_sound.o test_sound.s -l test_sound.lst

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
		rm -f *~ *.o *.lst HELLO TEST_SOUND
