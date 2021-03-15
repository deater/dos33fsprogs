include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	checkers32.dsk

submit:	checkers32.zip

checkers32.zip:	CHECKERS checkers.s file_id.diz checkers32.dsk
	mkdir -p lovebyte2021_checkers32
	cp CHECKERS ./lovebyte2021_checkers32
	cp checkers.s ./lovebyte2021_checkers32
	cp file_id.diz ./lovebyte2021_checkers32
	cp checkers32.dsk ./lovebyte2021_checkers32
	cp checkers_720p.mp4  ./lovebyte2021_checkers32
	zip -r checkers32.zip lovebyte2021_checkers32

checkers32.dsk:	HELLO CHECKERS
	cp $(EMPTY_DISK) checkers32.dsk
	$(DOS33) -y checkers32.dsk SAVE A HELLO
	$(DOS33) -y checkers32.dsk BSAVE -a 0x070 CHECKERS

###

CHECKERS: checkers.o
	ld65 -o CHECKERS checkers.o -C $(LINKER_DIR)/apple2_70_zp.inc

checkers.o:	checkers.s
	ca65 -o checkers.o checkers.s -l checkers.lst

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####


clean:		
		rm -f *~ *.o *.lst HELLO CHECKERS *.zip

