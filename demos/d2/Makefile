include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk
HGR2PNG = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	hgr_d2.dsk text_to_tiny

hgr_d2.dsk:	HELLO D2
	cp $(EMPTY_DISK)/empty.dsk ./hgr_d2.dsk
	$(DOS33) -y hgr_d2.dsk SAVE A HELLO
	$(DOS33) -y hgr_d2.dsk -t BIN -a 0x6000 BSAVE D2

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

peasant_music.s:	peasant.txt text_to_tiny
	./text_to_tiny peasant.txt > peasant_music.s

####

mA2E_2.s:	mA2E_2.txt text_to_tiny
	./text_to_tiny mA2E_2.txt > mA2E_2.s


####

D2:	d2.o
	ld65 -o D2 d2.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

d2.o:	d2.s \
	moving.s wires.s oval.s dsr_shape.s \
	zp.inc hardware.inc \
	mA2E_2.s \
	interrupt_handler.s mockingboard_setup.s
	ca65 -o d2.o d2.s -l d2.lst

####

text_to_tiny:	text_to_tiny.o
	$(CC) -o text_to_tiny text_to_tiny.o -lm

text_to_tiny.o:	text_to_tiny.c
	$(CC) $(CFLAGS) -c text_to_tiny.c

####

clean:
	rm -f *~ *.o *.lst D2 HELLO text_to_tiny mA2E_2.s
