include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk

all:	orb.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

orb.dsk:	$(DOS33) HELLO COMBO
	cp $(EMPTYDISK)/empty.dsk orb.dsk
	$(DOS33) -y orb.dsk SAVE A HELLO
	$(DOS33) -y orb.dsk BSAVE -a 0xc00 COMBO

###

submit:	orb_256.zip

orb_256.zip:	COMBO combo.s orb.s staggered.s boxes.s file_id.diz orb.dsk
	mkdir -p lovebyte2022_orb_256
	cp COMBO ./lovebyte2022_orb_256
	cp combo.s ./lovebyte2022_orb_256
	cp staggered.s ./lovebyte2022_orb_256
	cp orb.s ./lovebyte2022_orb_256
	cp boxes.s ./lovebyte2022_orb_256
	cp file_id.diz ./lovebyte2022_orb_256
	cp orb.dsk ./lovebyte2022_orb_256
	cp orb_720p.mp4 ./lovebyte2022_orb_256
	zip -r orb_256.zip lovebyte2022_orb_256

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

COMBO:	combo.o
	ld65 -o COMBO combo.o -C $(LINKERSCRIPTS)/apple2_c00.inc

combo.o:	combo.s orb.s staggered.s boxes.s
	ca65 -o combo.o combo.s -l combo.lst



###


clean:	
	rm -f *~ *.o HELLO COMBO *.lst

