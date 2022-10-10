include ../../../Makefile.inc

LINKER_DIR = ../../../linker_scripts/

EMPTY_DISK = ../../../empty_disk/empty.dsk
DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	both.dsk

both.dsk:	HELLO DSR_LORES PROOF PROOF2
	cp $(EMPTY_DISK) both.dsk
	$(DOS33) -y both.dsk SAVE A HELLO
	$(DOS33) -y both.dsk BSAVE -a 0x373 DSR_LORES
	$(DOS33) -y both.dsk BSAVE -a 0xC00 PROOF
	$(DOS33) -y both.dsk BSAVE -a 0xC00 PROOF2


###

DSR_LORES: dsr_lores.o
	ld65 -o DSR_LORES dsr_lores.o -C $(LINKER_DIR)/apple2_373.inc

dsr_lores.o:	dsr_lores.s
	ca65 -o dsr_lores.o dsr_lores.s -l dsr_lores.lst

###

PROOF: proof.o
	ld65 -o PROOF proof.o -C $(LINKER_DIR)/apple2_c00.inc

proof.o:	proof.s
	ca65 -o proof.o proof.s -l proof.lst

###

PROOF2: proof2.o
	ld65 -o PROOF2 proof2.o -C $(LINKER_DIR)/apple2_c00.inc

proof2.o:	proof2.s
	ca65 -o proof2.o proof2.s -l proof2.lst

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####


clean:		
		rm -f *~ *.o *.lst HELLO DSR_LORES PROOF PROOF2

