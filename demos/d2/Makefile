include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk
HGR2PNG = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	tiny_tracker.dsk text_to_tiny

tiny_tracker.dsk:	HELLO D2
	cp $(EMPTY_DISK)/empty.dsk ./tiny_tracker.dsk
	$(DOS33) -y tiny_tracker.dsk SAVE A HELLO
	$(DOS33) -y tiny_tracker.dsk -t BIN -a 0x6000 BSAVE D2

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

peasant_music.s:	peasant.txt text_to_tiny
	./text_to_tiny peasant.txt > peasant_music.s

####

D2:	d2.o
	ld65 -o D2 d2.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

d2.o:	d2.s \
	moving.s wires.s oval.s dsr_shape.s \
	zp.inc hardware.inc \
	peasant_music.s \
	interrupt_handler.s mockingboard_setup.s
	ca65 -o d2.o d2.s -l d2.lst

####

text_to_tiny:	text_to_tiny.o
	$(CC) -o text_to_tiny text_to_tiny.o -lm

text_to_tiny.o:	text_to_tiny.c
	$(CC) $(CFLAGS) -c text_to_tiny.c

####

clean:
	rm -f *~ *.o *.lst D2 HELLO text_to_tiny peasant_music.s

