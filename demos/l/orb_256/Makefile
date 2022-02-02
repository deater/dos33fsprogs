include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
PNG2GR = ../../../utils/gr-utils/png2gr
PNG2RLE = ../../../utils/gr-utils/png2rle
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk

all:	combo.dsk

$(DOS33):	
	cd ../../utils/dos33fs-utils && make

combo.dsk:	$(DOS33) HELLO COMBO
	cp $(EMPTYDISK)/empty.dsk combo.dsk
	$(DOS33) -y combo.dsk SAVE A HELLO
	$(DOS33) -y combo.dsk BSAVE -a 0xc00 COMBO

###

submit:	combo_256.zip

combo_256.zip:	BOXES boxes.s file_id.diz combo.dsk
	mkdir -p lovebyte2022_combo_256
	cp BOXES ./lovebyte2022_combo_256
	cp boxes.s ./lovebyte2022_combo_256
	cp file_id.diz ./lovebyte2022_combo_256
	cp combo.dsk ./lovebyte2022_combo_256
	cp combo_256_720p.mp4 ./lovebyte2022_combo_256
	zip -r combo_256.zip lovebyte2022_combo_256

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

