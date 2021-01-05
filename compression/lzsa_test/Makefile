include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG_TO_40x96 = ../../utils/gr-utils/png_to_40x96
PNG_TO_40x48D = ../../utils/gr-utils/png_to_40x48d
PNG2RLE = ../../utils/gr-utils/png2rle
B2D = ../../utils/bmp2dhr/b2d

all:	gr_lzsa.dsk

gr_lzsa.dsk:	HELLO GR_LZSA LZSA2_SMALL_BENCH LZSA2_FAST_BENCH \
	LZ4_BENCH RLE_BENCH
	cp empty.dsk lzsa_test.dsk
	$(DOS33) -y lzsa_test.dsk SAVE A HELLO
	$(DOS33) -y lzsa_test.dsk BSAVE -a 0x1000 GR_LZSA
	$(DOS33) -y lzsa_test.dsk BSAVE -a 0x1000 LZSA2_SMALL_BENCH
	$(DOS33) -y lzsa_test.dsk BSAVE -a 0x1000 LZSA2_FAST_BENCH
	$(DOS33) -y lzsa_test.dsk BSAVE -a 0x1000 RLE_BENCH
	$(DOS33) -y lzsa_test.dsk BSAVE -a 0x1000 LZ4_BENCH

###

GR_LZSA: gr_lzsa.o
	ld65 -o GR_LZSA gr_lzsa.o -C ../../linker_scripts/apple2_1000.inc

gr_lzsa.o:	gr_lzsa.s decompress_small_v2.s
	ca65 -o gr_lzsa.o gr_lzsa.s -l gr_lzsa.lst

###

LZSA2_SMALL_BENCH: lzsa2_small_bench.o
	ld65 -o LZSA2_SMALL_BENCH lzsa2_small_bench.o -C ../../linker_scripts/apple2_1000.inc

lzsa2_small_bench.o:	lzsa2_small_bench.s decompress_small_v2.s
	ca65 -o lzsa2_small_bench.o lzsa2_small_bench.s -l lzsa2_small_bench.lst

###

LZSA2_FAST_BENCH: lzsa2_fast_bench.o
	ld65 -o LZSA2_FAST_BENCH lzsa2_fast_bench.o -C ../../linker_scripts/apple2_1000.inc

lzsa2_fast_bench.o:	lzsa2_fast_bench.s decompress_fast_v2.s
	ca65 -o lzsa2_fast_bench.o lzsa2_fast_bench.s -l lzsa2_fast_bench.lst

###

RLE_BENCH: rle_bench.o
	ld65 -o RLE_BENCH rle_bench.o -C ../../linker_scripts/apple2_1000.inc

rle_bench.o:	rle_bench.s gr_unrle.s
	ca65 -o rle_bench.o rle_bench.s -l rle_bench.lst

###

LZ4_BENCH: lz4_bench.o
	ld65 -o LZ4_BENCH lz4_bench.o -C ../../linker_scripts/apple2_1000.inc

lz4_bench.o:	lz4_bench.s lz4_decode.s spaceship_far_n.lz4
	ca65 -o lz4_bench.o lz4_bench.s -l lz4_bench.lst

###


spaceship_far_n.lz4:
	lz4 -f -16 spaceship_far_n.gr
	dd if=spaceship_far_n.gr.lz4 of=spaceship_far_n.lz4 bs=1 skip=11
	truncate spaceship_far_n.lz4 -s -8


###

HELLO:	hello.bas
	../../utils/asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

####

clean:		
		rm -f *~ *.o *.lst HELLO GR_LZSA RLE_BENCH LZSA2_FAST_BENCH LZSA2_SMALL_BENCH LZ4_BENCH

