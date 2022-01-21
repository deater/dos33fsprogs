include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk
HGR2PNG = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	hgr_d2.dsk text_to_tiny

submit:	hgr_d2_1k.zip

####

hgr_d2.dsk:	HELLO D2 VIZ
	cp $(EMPTY_DISK)/empty.dsk ./hgr_d2.dsk
	$(DOS33) -y hgr_d2.dsk SAVE A HELLO
	$(DOS33) -y hgr_d2.dsk -t BIN -a 0x7E BSAVE D2
	$(DOS33) -y hgr_d2.dsk -t BIN -a 0xc00 BSAVE VIZ

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
	ld65 -o D2 d2.o -C ./apple2_7e_zp.inc

d2.o:	d2.s \
	zp.inc hardware.inc \
	mA2E_2.s visual.s \
	mockingboard_init.s play_frame.s \
	ay3_write_regs.s
	ca65 -o d2.o d2.s -l d2.lst

####

VIZ:	viz.o
	ld65 -o VIZ viz.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

viz.o:	viz.s \
	zp.inc hardware.inc
	ca65 -o viz.o viz.s -l viz.lst


####

text_to_tiny:	text_to_tiny.o
	$(CC) -o text_to_tiny text_to_tiny.o -lm

text_to_tiny.o:	text_to_tiny.c
	$(CC) $(CFLAGS) -c text_to_tiny.c

####

clean:
	rm -f *~ *.o *.lst D2 VIZ HELLO text_to_tiny mA2E_2.s
