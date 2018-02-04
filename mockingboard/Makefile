include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	dump_ed mock.dsk

mock.dsk:	KSP_THEME_UNCOMPRESSED
	$(DOS33) -y mock_test.dsk BSAVE -a 0x1000 KSP_THEME_UNCOMPRESSED

KSP_THEME_UNCOMPRESSED:	ksp_theme_uncompressed.o
	ld65 -o KSP_THEME_UNCOMPRESSED ksp_theme_uncompressed.o -C ./apple2_1000.inc

ksp_theme_uncompressed.o:	ksp_theme_uncompressed.s \
	../asm_routines/mockingboard.s
	ca65 -o ksp_theme_uncompressed.o ksp_theme_uncompressed.s -l ksp_theme_uncompressed.lst

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
	rm -f *~ TITLE.GR *.o *.lst ED KSP_THEME_UNCOMPRESSED dump_ed

