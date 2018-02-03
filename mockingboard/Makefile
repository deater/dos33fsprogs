include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	dump_ed mock.dsk

mock.dsk:	MOCK_TEST
	$(DOS33) -y mock_test.dsk BSAVE -a 0x1000 MOCK_TEST

MOCK_TEST:	mock_test.o
	ld65 -o MOCK_TEST mock_test.o -C ./apple2_1000.inc

mock_test.o:	mock_test.s
	ca65 -o mock_test.o mock_test.s -l mock_test.lst

ED:	duet.o
	ld65 -o ED duet.o -C ./apple2_900.inc

duet.o:	duet.s
	ca65 -o duet.o duet.s -l duet.lst

notes.o:	notes.c
	$(CC) $(CFLAGS) -c notes.c

dump_ed.o:	dump_ed.c notes.h
	$(CC) $(CFLAGS) -c dump_ed.c

dump_ed:	dump_ed.o notes.o
	$(CC) $(LFLAGS) -o dump_ed dump_ed.o notes.o


clean:	
	rm -f *~ TITLE.GR *.o *.lst ED MOCK_TEST dump_ed

