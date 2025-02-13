include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk
HGR2PNG = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	bytebeat.dsk

####

submit:	bytebeat256.zip

bytebeat256.zip:	BYTEBEAT bytebeat.s file_id.diz bytebeat.dsk
	mkdir -p lovebyte2022_bytebeat_256
	cp BYTEBEAT ./lovebyte2022_bytebeat_256
	cp *.s ./lovebyte2022_bytebeat_256
	cp file_id.diz ./lovebyte2022_bytebeat_256
	cp bytebeat.dsk ./lovebyte2022_bytebeat_256
	cp bytebeat_720p.mp4 ./lovebyte2022_bytebeat_256
	zip -r bytebeat256.zip lovebyte2022_bytebeat_256

####

bytebeat.dsk:	HELLO BYTEBEAT
	cp $(EMPTY_DISK)/empty.dsk ./bytebeat.dsk
	$(DOS33) -y bytebeat.dsk SAVE A HELLO
	$(DOS33) -y bytebeat.dsk -t BIN -a 0xC00 BSAVE BYTEBEAT


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

BYTEBEAT:	bytebeat.o
	ld65 -o BYTEBEAT bytebeat.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bytebeat.o:	bytebeat.s
	ca65 -o bytebeat.o bytebeat.s -l bytebeat.lst

####

clean:
	rm -f *~ *.o *.lst BYTEBEAT HELLO
