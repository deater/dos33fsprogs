include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts

all:	thick_sine.dsk

thick_sine.dsk:	HELLO THICK_SINE
	cp $(EMPTYDISK) thick_sine.dsk
	$(DOS33) -y thick_sine.dsk SAVE A HELLO
	$(DOS33) -y thick_sine.dsk BSAVE -a 0xC00 THICK_SINE

###

submit:	thick_sine64

thick_sine64:	thick_sine.s file_id.diz thick_sine.dsk
	mkdir -p lovebyte2022_thick_sine64
	cp THICK_SINE ./lovebyte2022_thick_sine64
	cp thick_sine.s ./lovebyte2022_thick_sine64
	cp file_id.diz ./lovebyte2022_thick_sine64
	cp thick_sine.dsk ./lovebyte2022_thick_sine64
	cp thick_sine_720p.mp4 ./lovebyte2022_thick_sine64
	zip -r thick_sine64 lovebyte2022_thick_sine64

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

THICK_SINE:	thick_sine.o
	ld65 -o THICK_SINE thick_sine.o -C $(LINKERSCRIPTS)/apple2_c00.inc

thick_sine.o:	thick_sine.s
	ca65 -o thick_sine.o thick_sine.s -l thick_sine.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO THICK_SINE *.zip
