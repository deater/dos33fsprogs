include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk
HGR2PNG = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	hgr_d2.dsk text_to_tiny

submit:	hgr_d2_1k.zip

####

hgr_d2.dsk:	HELLO D4
	cp $(EMPTY_DISK)/empty.dsk ./hgr_d2.dsk
	$(DOS33) -y hgr_d2.dsk SAVE A HELLO
	$(DOS33) -y hgr_d2.dsk -t BIN -a 0x6000 BSAVE D4

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

mA2E_4.s:	mA2E_4.txt text_to_tiny
	./text_to_tiny mA2E_4.txt > mA2E_4.s


####

D4:	d4.o
	ld65 -o D4 d4.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

d4.o:	d4.s \
	zp.inc hardware.inc \
	mA2E_4.s \
	mockingboard_init.s play_frame.s \
	tracker_init.s ay3_write_regs.s
	ca65 -o d4.o d4.s -l d4.lst



####

text_to_tiny:	text_to_tiny.o
	$(CC) -o text_to_tiny text_to_tiny.o -lm

text_to_tiny.o:	text_to_tiny.c
	$(CC) $(CFLAGS) -c text_to_tiny.c

####

clean:
	rm -f *~ *.o *.lst D2 HELLO text_to_tiny mA2E_2.s mA2E_3.s mA2E_4.s
