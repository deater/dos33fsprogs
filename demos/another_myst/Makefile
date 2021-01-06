include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2RLE = ../../utils/gr-utils/png2rle
PNG2LZ4 = ../../utils/gr-utils/png2lz4
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	am.dsk

am.dsk:	HELLO ANOTHERMIST INTRO TITLE
	cp empty.dsk am.dsk
	$(DOS33) -y am.dsk SAVE A HELLO
	$(DOS33) -y am.dsk BSAVE -a 0x1700 ANOTHERMIST
	$(DOS33) -y am.dsk BSAVE -a 0x1700 INTRO
	$(DOS33) -y am.dsk BSAVE -a 0xd00 TITLE

####

INTRO:	intro.o
	ld65 -o INTRO intro.o -C ../../linker_scripts/apple2_1700_9000.inc

intro.o:	intro.s \
	gr_copy.s gr_fast_clear.s gr_pageflip.s gr_unrle.s gr_putsprite.s \
	gr_overlay.s gr_run_sequence.s \
	keyboard.s random16.s text_print.s zp.inc \
	intro_data_01.lz4 \
	intro_data_04.lz4 \
	intro_data_06.lz4 \
	intro_data_08.lz4 \
	intro_data_09.lz4
	ca65 -o intro.o intro.s -l intro.lst

####

intro_data_01.lz4:	intro_data_01
	lz4 -f -16 intro_data_01
	truncate -s-8 intro_data_01.lz4

intro_data_01:	intro_data_01.o
	ld65 -o intro_data_01 intro_data_01.o -C ../../linker_scripts/apple2_9000.inc

intro_data_01.o:	intro_data_01.s
	ca65 -o intro_data_01.o intro_data_01.s -l intro_data_01.lst


intro_data_04.lz4:	intro_data_04
	lz4 -f -16 intro_data_04
	truncate -s-8 intro_data_04.lz4

intro_data_04:	intro_data_04.o
	ld65 -o intro_data_04 intro_data_04.o -C ../../linker_scripts/apple2_9000.inc

intro_data_04.o:	intro_data_04.s
	ca65 -o intro_data_04.o intro_data_04.s -l intro_data_04.lst


intro_data_06.lz4:	intro_data_06
	lz4 -f -16 intro_data_06
	truncate -s-8 intro_data_06.lz4

intro_data_06:	intro_data_06.o
	ld65 -o intro_data_06 intro_data_06.o -C ../../linker_scripts/apple2_9000.inc

intro_data_06.o:	intro_data_06.s
	ca65 -o intro_data_06.o intro_data_06.s -l intro_data_06.lst


intro_data_08.lz4:	intro_data_08
	lz4 -f -16 intro_data_08
	truncate -s-8 intro_data_08.lz4

intro_data_08:	intro_data_08.o
	ld65 -o intro_data_08 intro_data_08.o -C ../../linker_scripts/apple2_9000.inc

intro_data_08.o:	intro_data_08.s
	ca65 -o intro_data_08.o intro_data_08.s -l intro_data_08.lst


intro_data_09.lz4:	intro_data_09
	lz4 -f -16 intro_data_09
	truncate -s-8 intro_data_09.lz4

intro_data_09:	intro_data_09.o
	ld65 -o intro_data_09 intro_data_09.o -C ../../linker_scripts/apple2_9000.inc

intro_data_09.o:	intro_data_09.s
	ca65 -o intro_data_09.o intro_data_09.s -l intro_data_09.lst




####

LOADER:	loader.o
	ld65 -o LOADER loader.o -C ../../linker_scripts/apple2_1400.inc

loader.o:	loader.s
	ca65 -o loader.o loader.s -l loader.lst

####

LOADER2:	loader2.o
	ld65 -o LOADER2 loader2.o -C ../../linker_scripts/apple2_1400.inc

loader2.o:	loader2.s
	ca65 -o loader2.o loader2.s -l loader2.lst

####

TITLE:	title.o
	ld65 -o TITLE title.o -C ../../linker_scripts/apple2_d00.inc

title.o:	title.s loader.s
	ca65 -o title.o title.s -l title.lst



####


HELLO:  hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####


HELLO2:  hello2.bas
	$(TOKENIZE) < hello2.bas > HELLO2


#####

ANOTHERMIST:	anothermist.o
	ld65 -o ANOTHERMIST anothermist.o -C ../../linker_scripts/apple2_1700.inc

anothermist.o:	anothermist.s \
	pt3_lib_core.s pt3_lib_init.s pt3_lib_mockingboard_detect.s \
	pt3_lib_mockingboard_setup.s pt3_lib_irq_handler.s interrupt_handler.s \
	ootw_graphics/ootw_c16_end.inc \
	ootw_audio/ootw_outro.pt3 \
	ootw_c5_cave.s ootw_c1.s
	ca65 -o anothermist.o anothermist.s -l anothermist.lst
#####

compress_test.inc:	intro_graphics/07_soda/drinking01.png
	$(PNG2RLE) asm intro_graphics/07_soda/drinking01.png test_rle > compress_test.inc
	$(PNG2LZ4) asm intro_graphics/07_soda/drinking01.png test_lz4 >> compress_test.inc

COMPRESS-TEST:	compress_test.o
	ld65 -o COMPRESS-TEST compress_test.o -C ../../linker_scripts/apple2_2000.inc

compress_test.o:	compress_test.s lz4_decode.s compress_test.inc
	ca65 -o compress_test.o compress_test.s -l compress_test.lst


#####

zip:	ootw.dsk ootw_side2.dsk side3.dsk
	zip ootw.zip ootw.dsk ootw_side2.dsk ootw_side3.dsk

#####

clean:		
		rm -f *~ *.o *.lst *.lz4 HELLO ANOTHERMIST INTRO TITLE

