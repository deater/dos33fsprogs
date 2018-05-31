include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33

all:	eduet.dsk

$(DOS33):	
	cd ../dos33fs-utils && make

eduet.dsk:	$(DOS33) ED HIGHWIND.ED FIGHTING.ED SA.ED KERBAL.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x900 ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 HIGHWIND.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 FIGHTING.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 SA.ED
	$(DOS33) -y eduet.dsk BSAVE -a 0x2000 KERBAL.ED

ED:	duet.o
	ld65 -o ED duet.o -C ../linker_scripts/apple2_900.inc

duet.o:	duet.s
	ca65 -o duet.o duet.s -l duet.lst

clean:	
	rm -f *~ *.o *.lst ED

