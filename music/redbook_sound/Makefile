include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	generate_frequencies

#still_alive.dsk:	SA_COMPRESSED STILL_ALIVE TITLE.BAS ENDING
#	$(DOS33) -y still_alive.dsk BSAVE -a 0x5900 SA_COMPRESSED
#	$(DOS33) -y still_alive.dsk BSAVE -a 0x0800 STILL_ALIVE
#	$(DOS33) -y still_alive.dsk BSAVE -a 0x1800 ENDING
#	$(DOS33) -y still_alive.dsk SAVE A TITLE.BAS

STILL_ALIVE:	still_alive.o
	ld65 -o STILL_ALIVE still_alive.o -C ../../linker_scripts/apple2_800.inc


###

generate_frequencies:	generate_frequencies.o
	$(CC) -o generate_frequencies generate_frequencies.o -lm

generate_frequencies.o:
	$(CC) $(CFLAGS) -c generate_frequencies.c

###

clean:	
	rm -f *~ *.o generate_frequencies

