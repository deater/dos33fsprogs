include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	rr.dsk

submit:	rr256.zip

rr256.zip:	RR rr.s file_id.diz rr.dsk rr.woz
	mkdir -p lovebyte2021_rr256
	cp RR ./lovebyte2021_rr256
	cp rr.s ./lovebyte2021_rr256
	cp file_id.diz ./lovebyte2021_rr256
	cp rr.dsk ./lovebyte2021_rr256
	cp rr.woz ./lovebyte2021_rr256
	cp rr_flux.png ./lovebyte2021_rr256
	cp rr_720p.mp4 ./lovebyte2021_rr256
	zip -r rr256.zip lovebyte2021_rr256



###

rr.dsk:	RR
	dd if=RR of=rr.dsk bs=256 count=1
	dd if=/dev/zero of=rr2.dsk bs=256 count=559
	cat rr2.dsk >> rr.dsk

###

RR:	rr.o
	ld65 -o RR rr.o -C ./apple2_800.inc

rr.o:	rr.s
	ca65 -o rr.o rr.s -l rr.lst

###

clean:	
	rm -f *~ *.o *.lst RR rr.dsk rr2.dsk
