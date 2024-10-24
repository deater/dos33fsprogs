include ../../../Makefile.inc

PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
LINKERSCRIPTS = ../../../linker_scripts/


all:	DNI

###

DNI:	dni.o
	ld65 -o DNI dni.o -C $(LINKERSCRIPTS)/apple2_4000.inc

dni.o:	dni.s \
	../zp.inc ../hardware.inc
	ca65 -o dni.o dni.s -l dni.lst

####

clean:		
		rm -f *~ *.o *.lst DNI
