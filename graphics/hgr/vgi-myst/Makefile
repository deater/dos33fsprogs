include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk
MAKEVGI	= ./make_vgi_asm

all:	vgi_myst.dsk make_vgi_asm

vgi_myst.dsk:	HELLO VGI-MYST
	cp $(EMPTYDISK) vgi_myst.dsk
	$(DOS33) -y vgi_myst.dsk SAVE A HELLO
	$(DOS33) -y vgi_myst.dsk BSAVE -a 0xC00 VGI-MYST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

VGI-MYST:	myst_vgi.o
	ld65 -o VGI-MYST myst_vgi.o -C $(LINKERSCRIPTS)/apple2_c00.inc

myst_vgi.o: clock.data rocket.data rocket_door.data red_book.data fireplace.data path.data \
	myst_vgi.s vgi_clearscreen.s vgi_rectangle.s vgi_circles.s vgi_lines.s \
	vgi_triangles.s
	ca65 -o myst_vgi.o myst_vgi.s -l myst_vgi.lst

###

VGI-TEST:	test_vgi.o
	ld65 -o VGI-TEST test_vgi.o -C $(LINKERSCRIPTS)/apple2_4000.inc

test_vgi.o:	new.data \
	test_vgi.s vgi_clearscreen.s vgi_rectangle.s vgi_circles.s vgi_lines.s \
	vgi_triangles.s
	ca65 -o test_vgi.o test_vgi.s -l test_vgi.lst


###

COLOR-TEST:	color_test.o
	ld65 -o COLOR-TEST color_test.o -C $(LINKERSCRIPTS)/apple2_4000.inc

color_test.o: color_test.data \
	color_test.s vgi_clearscreen.s vgi_rectangle.s vgi_circles.s vgi_lines.s \
	vgi_triangles.s
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
	rm -f *~ *.o *.lst HELLO VGI-MYST VGI-DOOM COLOR-TEST \
		make_vgi_asm make_color_test *.data
