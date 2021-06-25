include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	vgi_myst.dsk make_boxes_asm

vgi_myst.dsk:	HELLO VGI-MYST VGI-DOOM
	cp $(EMPTYDISK) vgi_myst.dsk
	$(DOS33) -y vgi_myst.dsk SAVE A HELLO
	$(DOS33) -y vgi_myst.dsk BSAVE -a 0xC00 VGI-MYST
	$(DOS33) -y vgi_myst.dsk BSAVE -a 0x4000 VGI-DOOM


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

VGI-DOOM:	doom_vgi.o
	ld65 -o VGI-DOOM doom_vgi.o -C $(LINKERSCRIPTS)/apple2_4000.inc

doom_vgi.o: doom.data \
	doom_vgi.s vgi_clearscreen.s vgi_rectangle.s vgi_circles.s vgi_lines.s \
	vgi_triangles.s
	ca65 -o doom_vgi.o doom_vgi.s -l doom_vgi.lst



###

doom.data:	make_boxes_asm doom.vgi
	echo "doom_data:" > doom.data
	./make_boxes_asm < doom.vgi >> doom.data

###

clock.data:	make_boxes_asm clock.vgi
	echo "clock_data:" > clock.data
	./make_boxes_asm < clock.vgi >> clock.data

###

path.data:	make_boxes_asm path.vgi
	echo "path_data:" > path.data
	./make_boxes_asm < path.vgi >> path.data

###

rocket.data:	make_boxes_asm rocket.vgi
	echo "rocket_data:" > rocket.data
	./make_boxes_asm < rocket.vgi >> rocket.data

###

rocket_door.data:	make_boxes_asm rocket_door.vgi
	echo "rocket_door_data:" > rocket_door.data
	./make_boxes_asm < rocket_door.vgi >> rocket_door.data


###

red_book.data:	make_boxes_asm red_book.vgi
	echo "red_book_data:" > red_book.data
	./make_boxes_asm < red_book.vgi >> red_book.data

###

fireplace.data:	make_boxes_asm fireplace.vgi
	echo "fireplace_data:" > fireplace.data
	./make_boxes_asm < fireplace.vgi >> fireplace.data


###

make_boxes_asm:	make_boxes_asm.o
	$(CC) -o make_boxes_asm make_boxes_asm.o $(LFLAGS)

make_boxes_asm.o:	make_boxes_asm.c
	$(CC) $(CFLAGS) -c make_boxes_asm.c

###

clean:	
	rm -f *~ *.o *.lst HELLO VGI-MYST VGI-DOOM make_boxes_asm *.data
