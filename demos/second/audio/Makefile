include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33


all:	test_audio.dsk

test_audio.dsk:	TEST_AUDIO
	cp $(EMPTYDISK) test_audio.dsk
	$(DOS33) -y test_audio.dsk BSAVE -a 0x6000 TEST_AUDIO


####

TEST_AUDIO:  test_audio.o
	ld65 -o TEST_AUDIO test_audio.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

test_audio.o: test_audio.s
	ca65 -o test_audio.o test_audio.s -l test_audio.lst

####

transmission.btc.zx02:	transmission.btc
	$(ZX02) transmission.btc transmission.btc.zx02

####

clean:
	rm -f *~
