include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	dump_ed mock.dsk lzss_compress

mock.dsk:	KSP_THEME_UNCOMPRESSED KSP_THEME_COMPRESSED \
		KSP_THEME_INTERRUPT INTERRUPT_TEST
	$(DOS33) -y mock_test.dsk BSAVE -a 0x1000 KSP_THEME_UNCOMPRESSED
	$(DOS33) -y mock_test.dsk BSAVE -a 0x1000 KSP_THEME_COMPRESSED
	$(DOS33) -y mock_test.dsk BSAVE -a 0xc00 KSP_THEME_INTERRUPT
	$(DOS33) -y mock_test.dsk BSAVE -a 0x1000 INTERRUPT_TEST

KSP_THEME_COMPRESSED:	ksp_theme_compressed.o
	ld65 -o KSP_THEME_COMPRESSED ksp_theme_compressed.o -C ../linker_scripts/apple2_1000.inc

ksp_theme_compressed.o:	ksp_theme_compressed.s \
	../asm_routines/mockingboard.s \
	ksp_theme_compressed.inc
	ca65 -o ksp_theme_compressed.o ksp_theme_compressed.s -l ksp_theme_compressed.lst

KSP_THEME_INTERRUPT:	ksp_theme_interrupt.o
	ld65 -o KSP_THEME_INTERRUPT ksp_theme_interrupt.o -C ../linker_scripts/apple2_c00.inc

ksp_theme_interrupt.o:	ksp_theme_interrupt.s \
	../asm_routines/mockingboard.s \
	ksp_title.inc
	ca65 -o ksp_theme_interrupt.o ksp_theme_interrupt.s -l ksp_theme_interrupt.lst


KSP_THEME_UNCOMPRESSED:	ksp_theme_uncompressed.o
	ld65 -o KSP_THEME_UNCOMPRESSED ksp_theme_uncompressed.o -C ../linker_scripts/apple2_1000.inc

ksp_theme_uncompressed.o:	ksp_theme_uncompressed.s \
	../asm_routines/mockingboard.s
	ca65 -o ksp_theme_uncompressed.o ksp_theme_uncompressed.s -l ksp_theme_uncompressed.lst


INTERRUPT_TEST:	interrupt_test.o
	ld65 -o INTERRUPT_TEST interrupt_test.o -C ../linker_scripts/apple2_1000.inc

interrupt_test.o:	interrupt_test.s \
	../asm_routines/mockingboard.s
	ca65 -o interrupt_test.o interrupt_test.s -l interrupt_test.lst



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


lzss_compress.o:	lzss_compress.c
	$(CC) $(CFLAGS) -c lzss_compress.c

lzss_compress:	lzss_compress.o
	$(CC) $(LFLAGS) -o lzss_compress lzss_compress.o

clean:	
	rm -f *~ TITLE.GR *.o *.lst ED KSP_THEME_UNCOMPRESSED \
		KSP_THEME_COMPRESSED KSP_THEME_INTERRUPT INTERRUPT_TEST dump_ed

