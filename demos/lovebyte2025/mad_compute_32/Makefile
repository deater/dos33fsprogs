include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	mad_compute_31.dsk

mad_compute_31.dsk:	HELLO MAD_COMPUTE_31
	cp $(EMPTYDISK) mad_compute_31.dsk
	$(DOS33) -y mad_compute_31.dsk SAVE A HELLO
	$(DOS33) -y mad_compute_31.dsk BSAVE -a 0xe7 MAD_COMPUTE_31

###

submit:	mad_compute_31.zip

mad_compute_31.zip:	MAD_COMPUTE_31 mad_compute_31.s file_id.diz mad_compute_31.dsk
	mkdir -p lovebyte2025_mad_compute_31
	cp MAD_COMPUTE_31 ./lovebyte2025_mad_compute_31
	cp mad_compute_31.s ./lovebyte2025_mad_compute_31
	cp file_id.diz ./lovebyte2025_mad_compute_31
	cp mad_compute_31.dsk ./lovebyte2025_mad_compute_31
	cp monitor.txt ./lovebyte2025_mad_compute_31
	cp mad_compute_31_screen.png ./lovebyte2025_mad_compute_31
	cp mad_compute_31_720p.mp4 ./lovebyte2025_mad_compute_31
	zip -r mad_compute_31.zip lovebyte2025_mad_compute_31

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

MAD_COMPUTE_31:	mad_compute_31.o
	ld65 -o MAD_COMPUTE_31 mad_compute_31.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

mad_compute_31.o:	mad_compute_31.s
	ca65 -o mad_compute_31.o mad_compute_31.s -l mad_compute_31.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO MAD_COMPUTE_31 *.zip
