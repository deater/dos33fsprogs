include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk
HGR2PNG = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	tiny_tracker3.dsk

####

tiny_tracker3.dsk:	HELLO D2
	cp $(EMPTY_DISK)/empty.dsk ./tiny_tracker3.dsk
	$(DOS33) -y tiny_tracker3.dsk SAVE A HELLO
	$(DOS33) -y tiny_tracker3.dsk -t BIN -a 0x6000 BSAVE D2

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

mA2E_3.s:	mA2E_3.txt text_to_tiny
	./text_to_tiny mA2E_3.txt > mA2E_3.s


####

D2:	d2.o
	ld65 -o D2 d2.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

d2.o:	d2.s \
	zp.inc hardware.inc \
	mA2E_2.s mA2E_3.s \
	interrupt_handler.s mockingboard_init.s \
	tracker_init.s mockingboard_constants.s ay3_write_regs.s
	ca65 -o d2.o d2.s -l d2.lst

####

text_to_tiny:	text_to_tiny.o
	$(CC) -o text_to_tiny text_to_tiny.o -lm

text_to_tiny.o:	text_to_tiny.c
	$(CC) $(CFLAGS) -c text_to_tiny.c

####

clean:
	rm -f *~ *.o *.lst D2 HELLO text_to_tiny mA2E_2.s mA2E_3.s
