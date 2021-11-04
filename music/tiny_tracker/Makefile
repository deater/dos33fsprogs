include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk
HGR2PNG = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	tiny_tracker.dsk text_to_tiny

tiny_tracker.dsk:	HELLO PEASANT
	cp $(EMPTY_DISK)/empty.dsk ./tiny_tracker.dsk
	$(DOS33) -y tiny_tracker.dsk SAVE A HELLO
	$(DOS33) -y tiny_tracker.dsk -t BIN -a 0x2000 BSAVE PEASANT

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

YANKEE:	yankee.o
	ld65 -o YANKEE yankee.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

yankee.o:	yankee.s \
	zp.inc hardware.inc \
	yankee_music.s \
	interrupt_handler.s mockingboard_setup.s
	ca65 -o yankee.o yankee.s -l yankee.lst

####

PEASANT:	peasant.o
	ld65 -o PEASANT peasant.o -C $(LINKER_SCRIPTS)/apple2_2000.inc

peasant.o:	peasant.s \
	zp.inc hardware.inc \
	peasant_music.s \
	interrupt_handler.s mockingboard_setup.s
	ca65 -o peasant.o peasant.s -l peasant.lst

####

text_to_tiny:	text_to_tiny.o
	$(CC) -o text_to_tiny text_to_tiny.o -lm

text_to_tiny.o:	text_to_tiny.c
	$(CC) $(CFLAGS) -c text_to_tiny.c

####

clean:
	rm -f *~ *.o *.lst YANKEE PEASANT HELLO text_to_tiny
