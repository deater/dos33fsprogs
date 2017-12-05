include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr
PNG2RLE = ../gr-utils/png2rle

all:	dlowres_mode7.dsk

$(DOS33):	
	cd ../dos33fs-utils && make

dlowres_mode7.dsk:	$(DOS33) DLOWRES_MODE7
	$(DOS33) -y dlowres_mode7.dsk BSAVE -a 0x1000 DLOWRES_MODE7

###

DLOWRES_MODE7:	dlowres_mode7.o
	ld65 -o DLOWRES_MODE7 dlowres_mode7.o -C ./apple2_1000.inc

dlowres_mode7.o:	dlowres_mode7.s \
	dlowres_flying.s fast_multiply.s \
	dlowres_utils.s dlowres_zp.inc
	ca65 -o dlowres_mode7.o dlowres_mode7.s -l dlowres_mode7.lst

clean:	
	rm -f *~ *.o DLOWRES_MODE7 *.lst

