include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	spiral_32.dsk

spiral_32.dsk:	HELLO SPIRAL_32
	cp $(EMPTYDISK) spiral_32.dsk
	$(DOS33) -y spiral_32.dsk SAVE A HELLO
	$(DOS33) -y spiral_32.dsk BSAVE -a 0xc00 SPIRAL_32

###

submit:	spiral_32.zip

spiral_32.zip:	SPIRAL_32 spiral_32.s file_id.diz spiral_32.dsk
	mkdir -p lovebyte2023_spiral_32
	cp SPIRAL_32 ./lovebyte2023_spiral_32
	cp spiral_32.s ./lovebyte2023_spiral_32
	cp file_id.diz ./lovebyte2023_spiral_32
	cp spiral_32.dsk ./lovebyte2023_spiral_32
	cp monitor.txt ./lovebyte2023_spiral_32
	cp spiral_32_screen.png ./lovebyte2023_spiral_32
	cp spiral_32_720p.mp4 ./lovebyte2023_spiral_32
	zip -r spiral_32.zip lovebyte2023_spiral_32

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SPIRAL_32:	spiral_32.o
	ld65 -o SPIRAL_32 spiral_32.o -C $(LINKERSCRIPTS)/apple2_c00.inc

spiral_32.o:	spiral_32.s
	ca65 -o spiral_32.o spiral_32.s -l spiral_32.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO SPIRAL_32 *.zip
