include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr
PNG2RLE = ../gr-utils/png2rle

all:	mode7.dsk

$(DOS33):	
	cd ../dos33fs-utils && make

mode7.dsk:	$(DOS33) MODE7
	$(DOS33) -y mode7.dsk BSAVE -a 0x1000 MODE7

###

MODE7:	mode7.o
	ld65 -o MODE7 mode7.o -C ./apple2_1000.inc

mode7.o:	mode7.s \
	flying.s fast_multiply.s \
	utils.s zp.inc sprites.inc
	ca65 -o mode7.o mode7.s -l mode7.lst

clean:	
	rm -f *~ *.o MODE7 *.lst

