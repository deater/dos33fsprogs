include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	horiz_scroll.dsk

####

horiz_scroll.dsk:	HELLO HSCROLL_TEST
	cp $(EMPTY_DISK) horiz_scroll.dsk
	$(DOS33) -y horiz_scroll.dsk SAVE A HELLO
	$(DOS33) -y horiz_scroll.dsk BSAVE -a 0x6000 HSCROLL_TEST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO



####

HSCROLL_TEST:	hscroll_test.o
	ld65 -o HSCROLL_TEST hscroll_test.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

hscroll_test.o:	hscroll_test.s zx02_optim.s \
	graphics/pq2_bgl.hgr.zx02 \
	graphics/pq2_bgr.hgr.zx02 \
	horiz_scroll.s hgr_partial.s \
	zp.inc hardware.inc
	ca65 -o hscroll_test.o hscroll_test.s -l hscroll_test.lst

###

graphics/pq2_bgl.hgr.zx02:	
	cd graphics && make

clean:
	rm -f *~ *.o *.lst HELLO HSCROLL_TEST
	cd graphics && make clean
