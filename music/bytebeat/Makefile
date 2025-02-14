include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk
HGR2PNG = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	bytebeat.dsk

####

bytebeat.dsk:	HELLO BYTEBEAT HEARTBEAT
	cp $(EMPTY_DISK)/empty.dsk ./bytebeat.dsk
	$(DOS33) -y bytebeat.dsk SAVE A HELLO
	$(DOS33) -y bytebeat.dsk -t BIN -a 0xC00 BSAVE BYTEBEAT
	$(DOS33) -y bytebeat.dsk -t BIN -a 0xC00 BSAVE HEARTBEAT


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

BYTEBEAT:	bytebeat.o
	ld65 -o BYTEBEAT bytebeat.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bytebeat.o:	bytebeat.s
	ca65 -o bytebeat.o bytebeat.s -l bytebeat.lst

####

HEARTBEAT:	heartbeat.o
	ld65 -o HEARTBEAT heartbeat.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

heartbeat.o:	heartbeat.s
	ca65 -o heartbeat.o heartbeat.s -l heartbeat.lst

####

clean:
	rm -f *~ *.o *.lst HELLO \
		BYTEBEAT HEARTBEAT
