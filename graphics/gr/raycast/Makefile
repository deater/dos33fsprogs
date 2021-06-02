include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk

all:	raycast.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

raycast.dsk:	$(DOS33) HELLO RAYCAST RAYMARCH RAYMARCH_TINY RAY.BAS
	cp $(EMPTYDISK)/empty.dsk raycast.dsk
	$(DOS33) -y raycast.dsk SAVE A HELLO
	$(DOS33) -y raycast.dsk SAVE A RAY.BAS
	$(DOS33) -y raycast.dsk BSAVE -a 0xc00 RAYCAST
	$(DOS33) -y raycast.dsk BSAVE -a 0xc00 RAYMARCH
	$(DOS33) -y raycast.dsk BSAVE -a 0xc00 RAYMARCH_TINY



###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

RAY.BAS:	ray.bas
	$(TOKENIZE) < ray.bas > RAY.BAS


###

RAYCAST:	raycast.o
	ld65 -o RAYCAST raycast.o -C $(LINKERSCRIPTS)/apple2_c00.inc

raycast.o:	raycast.s
	ca65 -o raycast.o raycast.s -l raycast.lst

###

RAYMARCH:	raymarch.o
	ld65 -o RAYMARCH raymarch.o -C $(LINKERSCRIPTS)/apple2_c00.inc

raymarch.o:	raymarch.s
	ca65 -o raymarch.o raymarch.s -l raymarch.lst

###

RAYMARCH_TINY:	raymarch_tiny.o
	ld65 -o RAYMARCH_TINY raymarch_tiny.o -C $(LINKERSCRIPTS)/apple2_c00.inc

raymarch_tiny.o:	raymarch_tiny.s
	ca65 -o raymarch_tiny.o raymarch_tiny.s -l raymarch_tiny.lst



###


clean:	
	rm -f *~ *.o HELLO RAYCAST RAYMARCH RAYMARCH_TINY *.lst

