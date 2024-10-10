include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../linker_scripts/
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	generate_frequencies convert_frequencies redbook_sound.dsk

redbook_sound.dsk:	HELLO TEST_KEEN TEST_PQ
	cp $(EMPTY_DISK) redbook_sound.dsk
	$(DOS33) -y redbook_sound.dsk SAVE A HELLO
	$(DOS33) -y redbook_sound.dsk BSAVE -a 0xc00 TEST_KEEN
	$(DOS33) -y redbook_sound.dsk BSAVE -a 0xc00 TEST_PQ

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TEST_KEEN:	test_keen.o
	ld65 -o TEST_KEEN test_keen.o -C $(LINKER_SCRIPTS)apple2_c00.inc

test_keen.o:	test_keen.s longer_sound.s ck1_sounds.inc
	ca65 -o test_keen.o test_keen.s -l test_keen.lst


###

TEST_PQ:	test_pq.o
	ld65 -o TEST_PQ test_pq.o -C $(LINKER_SCRIPTS)apple2_c00.inc

test_pq.o:	test_pq.s longer_sound.s pq_sounds.inc
	ca65 -o test_pq.o test_pq.s -l test_pq.lst



###

generate_frequencies:	generate_frequencies.o
	$(CC) -o generate_frequencies generate_frequencies.o -lm

generate_frequencies.o:	generate_frequencies.c
	$(CC) $(CFLAGS) -c generate_frequencies.c

###

convert_frequencies:	convert_frequencies.o
	$(CC) -o convert_frequencies convert_frequencies.o -lm

convert_frequencies.o:	convert_frequencies.c
	$(CC) $(CFLAGS) -c convert_frequencies.c

###

clean:	
	rm -f *~ *.o generate_frequencies convert_frequencies TEST_KEEN TEST_PQ

