include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	TUNNEL

####

TUNNEL:	tunnel.o
	ld65 -o TUNNEL tunnel.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

tunnel.o:	tunnel.s \
	../zp.inc ../hardware.inc ../qload.inc
	ca65 -o tunnel.o tunnel.s -l tunnel.lst

###


clean:
		rm -f *~ *.o *.lst TUNNEL
