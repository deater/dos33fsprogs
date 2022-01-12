include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	flyer_512.dsk


flyer_512.dsk:	FLYER
	# 0, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 15
	dd if=/dev/zero of=flyer_512.dsk bs=256 count=560
	dd conv=notrunc if=FLYER of=flyer_512.dsk bs=256 count=1
	dd conv=notrunc if=FLYER of=flyer_512.dsk bs=256 count=1 seek=7 skip=1

###

submit:	text8.zip

text8.zip:	FLYER flyer.s file_id.diz flyer_512.dsk
	mkdir -p lovebyte2021_flyer_512
	cp FLYER ./lovebyte2021_flyer_512
	cp flyer.s ./lovebyte2021_flyer_512
	cp file_id.diz ./lovebyte2021_flyer_512
	cp flyer_512.dsk ./lovebyte2021_flyer_512
	cp flyer_720p.mp4 ./lovebyte2021_flyer_512
	zip -r text8.zip lovebyte2021_flyer_512

####

FLYER:	flyer.o
	ld65 -o FLYER flyer.o -C ./apple2_800.inc

flyer.o:	flyer.s \
	ay3_write_regs.s flyer.s interrupt_handler.s \
	mA2E_3.s mockingboard_constants.s mockingboard_init.s tracker_init.s
	ca65 -o flyer.o flyer.s -l flyer.lst

####

clean:	
	rm -f *~ *.o *.lst FLYER *.zip

