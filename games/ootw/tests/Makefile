include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2RLE = ../../utils/gr-utils/png2rle
PNG2LZ4 = ../../utils/gr-utils/png2lz4
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

EMPTY_DISK = ../../empty_disk

all:	ootw.dsk ootw_side2.dsk ootw_side3.dsk

ootw.dsk:	HELLO TITLE \
		./intro/INTRO ./ootw_c1/OOTW_C1 ./ootw_c2/OOTW_C2 \
		./ootw_c3/OOTW_C3 ./ootw_c4/OOTW_C4 ./ootw_c5/OOTW_C5
	cp $(EMPTY_DISK)/empty.dsk ootw.dsk
	$(DOS33) -y ootw.dsk SAVE A HELLO
	$(DOS33) -y ootw.dsk BSAVE -a 0xd00 TITLE
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./intro/INTRO INTRO
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c1/OOTW_C1 OOTW_C1
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c2/OOTW_C2 OOTW_C2
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c3/OOTW_C3 OOTW_C3
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c4/OOTW_C4 OOTW_C4
	$(DOS33) -y ootw.dsk BSAVE -a 0x1700 ./ootw_c5/OOTW_C5 OOTW_C5

ootw_side2.dsk:	HELLO TITLE \
	./ootw_c6/OOTW_C6 ./ootw_c7/OOTW_C7 ./ootw_c8/OOTW_C8 \
	./ootw_c9/OOTW_C9 ./ootw_c10/OOTW_C10
	cp $(EMPTY_DISK)/empty.dsk ootw_side2.dsk
	$(DOS33) -y ootw_side2.dsk SAVE A HELLO HELLO
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0xd00 TITLE
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c6/OOTW_C6 OOTW_C6
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c7/OOTW_C7 OOTW_C7
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c8/OOTW_C8 OOTW_C8
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c9/OOTW_C9 OOTW_C9
	$(DOS33) -y ootw_side2.dsk BSAVE -a 0x1700 ./ootw_c10/OOTW_C10 OOTW_C10

ootw_side3.dsk:	HELLO TITLE ./ending/ENDING \
	./ootw_c11/OOTW_C11 ./ootw_c12/OOTW_C12 ./ootw_c13/OOTW_C13 \
	./ootw_c14/OOTW_C14 ./ootw_c15/OOTW_C15
	cp $(EMPTY_DISK)/empty.dsk ootw_side3.dsk
	$(DOS33) -y ootw_side3.dsk SAVE A HELLO HELLO
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0xd00 TITLE
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c11/OOTW_C11
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c12/OOTW_C12
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c13/OOTW_C13
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c14/OOTW_C14
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ootw_c15/OOTW_C15
	$(DOS33) -y ootw_side3.dsk BSAVE -a 0x1700 ./ending/ENDING


####

AUDIO_TEST:	audio.o
	ld65 -o AUDIO_TEST audio.o -C ../../linker_scripts/apple2_1700.inc

audio.o:	audio.s
	ca65 -o audio.o audio.s -l audio.lst


####

intro/INTRO:
	cd intro && make

ootw_c1/OOTW_C1:
	cd ootw_c1 && make

ootw_c2/OOTW_C2:
	cd ootw_c2 && make

ootw_c3/OOTW_C3:
	cd ootw_c3 && make

ootw_c4/OOTW_C4:
	cd ootw_c4 && make

ootw_c5/OOTW_C5:
	cd ootw_c5 && make

ootw_c6/OOTW_C6:
	cd ootw_c6 && make

ootw_c7/OOTW_C7:
	cd ootw_c7 && make

ootw_c8/OOTW_C8:
	cd ootw_c8 && make

ootw_c9/OOTW_C9:
	cd ootw_c9 && make

ootw_c10/OOTW_C10:
	cd ootw_c10 && make

ootw_c11/OOTW_C11:
	cd ootw_c11 && make

ootw_c12/OOTW_C12:
	cd ootw_c12 && make

ootw_c13/OOTW_C13:
	cd ootw_c13 && make

ootw_c14/OOTW_C14:
	cd ootw_c14 && make

ootw_c15/OOTW_C15:
	cd ootw_c15 && make

ending/ENDING:
	cd ending && make

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
		rm -f *~ *.o *.lst *.lz4 HELLO TITLE INTRO LOADER \
			COMPRESS-TEST AUDIO_TEST

