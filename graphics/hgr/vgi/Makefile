include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKERSCRIPTS = ../../../linker_scripts
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	vgi.dsk make_boxes_asm

vgi.dsk:	HELLO VGI
	cp $(EMPTYDISK) vgi.dsk
	$(DOS33) -y vgi.dsk SAVE A HELLO
	$(DOS33) -y vgi.dsk BSAVE -a 0xC00 VGI


###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

VGI:	vgi.o
	ld65 -o VGI vgi.o -C $(LINKERSCRIPTS)/apple2_c00.inc

vgi.o: clock.data rocket.data rocket_door.data red_book.data fireplace.data \
	vgi.s vgi_clearscreen.s vgi_rectangle.s vgi_circles.s vgi_lines.s \
	vgi_triangles.s
	ca65 -o vgi.o vgi.s -l vgi.lst


###

clock.data:	make_boxes_asm clock.vgi
	echo "clock_data:" > clock.data
	./make_boxes_asm < clock.vgi >> clock.data

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
	rm -f *~ *.o *.lst HELLO VGI make_boxes_asm *.data
