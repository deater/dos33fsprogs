include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
LINKER_SCRIPTS = ../../linker_scripts/

all:	tiny_demos.dsk

tiny_demos.dsk:	HELLO CHEVRON_17 CIRCUIT_17 TIGER_22
	cp $(EMPTYDISK) tiny_demos.dsk
	$(DOS33) -y tiny_demos.dsk SAVE A HELLO
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 CHEVRON_17
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 CIRCUIT_17
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 TIGER_22

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

CHEVRON_17:	chevron_17.o
	ld65 -o CHEVRON_17 chevron_17.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

chevron_17.o:	chevron_17.s
	ca65 -o chevron_17.o chevron_17.s -l chevron_17.lst

###

CIRCUIT_17:	circuit_17.o
	ld65 -o CIRCUIT_17 circuit_17.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

circuit_17.o:	circuit_17.s
	ca65 -o circuit_17.o circuit_17.s -l circuit_17.lst

###

TIGER_22:	tiger_22.o
	ld65 -o TIGER_22 tiger_22.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

tiger_22.o:	tiger_22.s
	ca65 -o tiger_22.o tiger_22.s -l tiger_22.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO \
		CHEVRON_17 CIRCUIT_17 TIGER_22 *.zip

