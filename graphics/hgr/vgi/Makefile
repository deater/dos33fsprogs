include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk
MAKEVGI	= ./make_vgi_asm

all:	vgi_test.dsk make_vgi_asm make_color_test

vgi_test.dsk:	HELLO COLOR-TEST VGI-TEST BENCHMARK_SLOW BENCHMARK_ORIGINAL BENCHMARK_FAST
	cp $(EMPTYDISK) vgi_test.dsk
	$(DOS33) -y vgi_test.dsk SAVE A HELLO
	$(DOS33) -y vgi_test.dsk BSAVE -a 0x4000 COLOR-TEST
	$(DOS33) -y vgi_test.dsk BSAVE -a 0x4000 VGI-TEST
	$(DOS33) -y vgi_test.dsk BSAVE -a 0x4000 BENCHMARK_SLOW
	$(DOS33) -y vgi_test.dsk BSAVE -a 0x4000 BENCHMARK_ORIGINAL
	$(DOS33) -y vgi_test.dsk BSAVE -a 0x4000 BENCHMARK_FAST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

BENCHMARK_SLOW:	benchmark_slow.o
	ld65 -o BENCHMARK_SLOW benchmark_slow.o -C $(LINKERSCRIPTS)/apple2_4000.inc

benchmark_slow.o: clock.data rocket.data rocket_door.data red_book.data fireplace.data path.data \
	benchmark_slow.s \
	./vgi_slow/vgi_common.s \
	./vgi_slow/vgi_clearscreen.s \
	./vgi_slow/vgi_rectangle.s \
	./vgi_slow/vgi_circles.s \
	./vgi_slow/vgi_lines.s \
	./vgi_slow/vgi_triangles.s
	ca65 -o benchmark_slow.o benchmark_slow.s -l benchmark_slow.lst

###

BENCHMARK_ORIGINAL:	benchmark_original.o
	ld65 -o BENCHMARK_ORIGINAL benchmark_original.o -C $(LINKERSCRIPTS)/apple2_4000.inc

benchmark_original.o: clock.data rocket.data rocket_door.data red_book.data fireplace.data path.data \
	benchmark_original.s \
	./vgi_original/vgi_common.s \
	./vgi_original/vgi_clearscreen.s \
	./vgi_original/vgi_rectangle.s \
	./vgi_original/vgi_circles.s \
	./vgi_original/vgi_lines.s \
	./vgi_original/vgi_triangles.s
	ca65 -o benchmark_original.o benchmark_original.s -l benchmark_original.lst

###

BENCHMARK_FAST:	benchmark_fast.o
	ld65 -o BENCHMARK_FAST benchmark_fast.o -C $(LINKERSCRIPTS)/apple2_4000.inc

benchmark_fast.o: clock.data rocket.data rocket_door.data red_book.data fireplace.data path.data \
	benchmark_fast.s \
	./vgi_fast/vgi_common.s \
	./vgi_fast/vgi_clearscreen.s \
	./vgi_fast/vgi_rectangle.s \
	./vgi_fast/vgi_circles.s \
	./vgi_fast/vgi_lines.s \
	./vgi_fast/vgi_triangles.s
	ca65 -o benchmark_fast.o benchmark_fast.s -l benchmark_fast.lst



###

VGI-TEST:	test_vgi.o
	ld65 -o VGI-TEST test_vgi.o -C $(LINKERSCRIPTS)/apple2_4000.inc

test_vgi.o:	new.data \
	test_vgi.s \
	./vgi_fast/vgi_common.s \
	./vgi_fast/vgi_clearscreen.s \
	./vgi_fast/vgi_rectangle.s \
	./vgi_fast/vgi_circles.s \
	./vgi_fast/vgi_lines.s \
	./vgi_fast/vgi_triangles.s
	ca65 -o test_vgi.o test_vgi.s -l test_vgi.lst


###

COLOR-TEST:	color_test.o
	ld65 -o COLOR-TEST color_test.o -C $(LINKERSCRIPTS)/apple2_4000.inc

color_test.o: color_test.data \
	color_test.s \
	./vgi_fast/vgi_common.s \
	./vgi_fast/vgi_clearscreen.s \
	./vgi_fast/vgi_rectangle.s \
	./vgi_fast/vgi_circles.s \
	./vgi_fast/vgi_lines.s \
	./vgi_fast/vgi_triangles.s
	ca65 -o color_test.o color_test.s -l color_test.lst




###

clock.data:	make_vgi_asm clock.vgi
	echo "clock_data:" > clock.data
	./make_vgi_asm < clock.vgi >> clock.data

###

path.data:	make_vgi_asm path.vgi
	echo "path_data:" > path.data
	./make_vgi_asm < path.vgi >> path.data

###

rocket.data:	make_vgi_asm rocket.vgi
	echo "rocket_data:" > rocket.data
	./make_vgi_asm < rocket.vgi >> rocket.data

###

rocket_door.data:	make_vgi_asm rocket_door.vgi
	echo "rocket_door_data:" > rocket_door.data
	./make_vgi_asm < rocket_door.vgi >> rocket_door.data


###

new.data:	make_vgi_asm new.vgi
	echo "new_data:" > new.data
	./make_vgi_asm < new.vgi >> new.data

###

red_book.data:	make_vgi_asm red_book.vgi
	echo "red_book_data:" > red_book.data
	./make_vgi_asm < red_book.vgi >> red_book.data

###

fireplace.data:	make_vgi_asm fireplace.vgi
	echo "fireplace_data:" > fireplace.data
	./make_vgi_asm < fireplace.vgi >> fireplace.data

###

color_test.vgi:	make_color_test
	./make_color_test > color_test.vgi

color_test.data:	make_vgi_asm color_test.vgi
	echo "color_test_data:" > color_test.data
	./make_vgi_asm < color_test.vgi >> color_test.data


###

make_vgi_asm:	make_vgi_asm.o
	$(CC) -o make_vgi_asm make_vgi_asm.o $(LFLAGS)

make_vgi_asm.o:	make_vgi_asm.c
	$(CC) $(CFLAGS) -c make_vgi_asm.c

###

make_color_test:	make_color_test.o
	$(CC) -o make_color_test make_color_test.o $(LFLAGS)

make_color_test.o:	make_color_test.c
	$(CC) $(CFLAGS) -c make_color_test.c


###

clean:	
	rm -f *~ *.o *.lst HELLO COLOR-TEST BENCHMARK_SLOW BENCHMARK_FAST BENCHMARK_ORIGINAL \
		make_vgi_asm make_color_test *.data
