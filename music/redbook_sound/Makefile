include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts/
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	generate_frequencies redbook_sound.dsk

redbook_sound.dsk:	HELLO TEST_KEEN
	cp $(EMPTY_DISK) redbook_sound.dsk
	$(DOS33) -y redbook_sound.dsk SAVE A HELLO
	$(DOS33) -y redbook_sound.dsk BSAVE -a 0xc00 TEST_KEEN

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TEST_KEEN:	test_keen.o
	ld65 -o TEST_KEEN test_keen.o -C $(LINKER_SCRIPTS)apple2_c00.inc

test_keen.o:	test_keen.s lvldone.inc redbook_sound.s
	ca65 -o test_keen.o test_keen.s -l test_keen.lst


###

generate_frequencies:	generate_frequencies.o
	$(CC) -o generate_frequencies generate_frequencies.o -lm

generate_frequencies.o:
	$(CC) $(CFLAGS) -c generate_frequencies.c

###

clean:	
	rm -f *~ *.o generate_frequencies TEST_KEEN

