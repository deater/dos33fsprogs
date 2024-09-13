include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/

all:	pq2.dsk

####

pq2.dsk:	HELLO PQ2
	cp $(EMPTY_DISK) pq2.dsk
	$(DOS33) -y pq2.dsk SAVE A HELLO
	$(DOS33) -y pq2.dsk BSAVE -a 0x6000 PQ2

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO



####

PQ2:	pq2.o
	ld65 -o PQ2 pq2.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

pq2.o:	pq2.s zx02_optim.s \
	graphics/pq2_bgl.hgr.zx02 \
	graphics/pq2_bgr.hgr.zx02 \
	graphics/pq2_dialog1.hgr.zx02 \
	graphics/pq2_dialog2.hgr.zx02 \
	horiz_scroll.s hgr_partial.s \
	zp.inc hardware.inc
	ca65 -o pq2.o pq2.s -l pq2.lst

###

graphics/pq2_bgl.hgr.zx02:	
	cd graphics && make

clean:
	rm -f *~ *.o *.lst HELLO PQ2
	cd graphics && make clean
