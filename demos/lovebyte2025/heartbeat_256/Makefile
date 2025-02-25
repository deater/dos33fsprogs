include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk
HGR2PNG = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	heartbeat.dsk

####

submit:	heartbeat256.zip

heartbeat256.zip:	HEARTBEAT heartbeat.s file_id.diz heartbeat.dsk
	mkdir -p lovebyte2025_heartbeat_256
	cp HEARTBEAT ./lovebyte2025_heartbeat_256
	cp *.s ./lovebyte2025_heartbeat_256
	cp file_id.diz ./lovebyte2025_heartbeat_256
	cp heartbeat.dsk ./lovebyte2025_heartbeat_256
	cp heartbeat_720p.mp4 ./lovebyte2025_heartbeat_256
	zip -r heartbeat256.zip lovebyte2025_heartbeat_256

####

heartbeat.dsk:	HELLO HEARTBEAT
	cp $(EMPTY_DISK)/empty.dsk ./heartbeat.dsk
	$(DOS33) -y heartbeat.dsk SAVE A HELLO
	$(DOS33) -y heartbeat.dsk -t BIN -a 0xC00 BSAVE HEARTBEAT


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

HEARTBEAT:	heartbeat.o
	ld65 -o HEARTBEAT heartbeat.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

heartbeat.o:	heartbeat.s
	ca65 -o heartbeat.o heartbeat.s -l heartbeat.lst

####

clean:
	rm -f *~ *.o *.lst HEARTBEAT HELLO
