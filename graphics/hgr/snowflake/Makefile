include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	snowflake.dsk

snowflake.dsk:	SNOW SNOW2 SNOW3
	cp $(EMPTY_DISK) snowflake.dsk
	$(DOS33) -y snowflake.dsk BSAVE -a 0x0300 SNOW
	$(DOS33) -y snowflake.dsk BSAVE -a 0x0300 SNOW2
	$(DOS33) -y snowflake.dsk BSAVE -a 0x03F5 SNOW3

###

SNOW:	snow.o
	ld65 -o SNOW snow.o -C $(LINKER_SCRIPTS)/apple2_300.inc

snow.o:	snow.s
	ca65 -o snow.o snow.s -l snow.lst

###

SNOW2:	snow2.o
	ld65 -o SNOW2 snow2.o -C $(LINKER_SCRIPTS)/apple2_300.inc

snow2.o:	snow2.s
	ca65 -o snow2.o snow2.s -l snow2.lst

###

SNOW3:	snow3.o
	ld65 -o SNOW3 snow3.o -C ./apple2_custom.inc

snow3.o:	snow3.s
	ca65 -o snow3.o snow3.s -l snow3.lst


###

clean:	
	rm -f *~ *.o *.lst SNOW SNOW2 SNOW3
